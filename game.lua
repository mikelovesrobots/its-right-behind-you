-- add a state to that class using addState, and re-define the method
Game = {}
function Game:enterState()
  debug("Game initialized")

  love.graphics.setFont(app.config.MENU_FONT);
  self.x = 400
  self.y = 80
  self.current_gravity = 0
  self.start_time = love.timer.getMicroTime()
  self.new_lava = {}
  self.facing_right = true

  -- breaking bricks
  self.break_x = 0
  self.break_y = 0
  self.break_dt = 0

  -- lava
  self.lava_dt = 0
  self.death_dt = 0

  -- setup the map
  self:initialize_level()

  -- map variables
  self.map_width = #self.map[1] -- Obtains the width of the first row of the map
  self.map_height = #self.map -- Obtains the height of the map
  self.map_x = 0
  self.map_y = 0
  self.map_display_buffer = 2 -- We have to buffer one tile before and behind our viewpoint.
                               -- Otherwise, the tiles will just pop into view, and we don't want that.
end

function Game:initialize_level()
end

function Game:draw()
  self:draw_map()
  love.graphics.draw(app.config.PLAYER_IMAGE, self:player_display_x(), self:player_display_y(), self:death_radians(), self:player_scale_x(), self:player_scale_y())
end

function Game:update(dt)
  if self:player_dying() then
    self.death_dt = self.death_dt + dt
    if self.death_dt > app.config.DEATH_ANIMATION_LIMIT then
      screen_manager:popState()
      screen_manager:pushState('DeadScreen')
    else
      self:update_lava_flow(dt)
    end
    return
  end

  local desired_x = self.x
  local desired_y = self.y

  if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
    desired_x = desired_x - (app.config.SPEED * dt)
    self.facing_right = false
  elseif love.keyboard.isDown("right") or love.keyboard.isDown("d") then
    desired_x = desired_x + (app.config.SPEED * dt)
    self.facing_right = true
  end

  desired_x = round(desired_x)
  if desired_x < 2 - (app.config.TILE_WIDTH / 2) or desired_x > self:map_max_x() - (app.config.TILE_WIDTH / 2) then
    -- stay on the goddamn map
    desired_x = self.x
  elseif desired_x < self.x then
    if self:tile_colliding_on_left(desired_x, desired_y) then
      self.x = self:clip_left(desired_x)
      self:bump_left(dt)
    else
      self.x = desired_x
    end
  elseif desired_x > self.x then
    if self:tile_colliding_on_right(desired_x, desired_y) then
      self.x = self:clip_right(desired_x)
      self:bump_right(dt)
    else
      self.x = desired_x
    end
  end
  desired_x = self.x

  --
  -- y
  --

  -- gravity
  if self:tile_colliding_on_bottom(desired_x, desired_y) then
    if self.current_gravity == 0 and (love.keyboard.isDown(" ") or love.keyboard.isDown("up") or love.keyboard.isDown("w")) then
      self.current_gravity = -app.config.JUMP_SPEED
    else
      self.current_gravity = 0
    end

    if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
      self:bump_down(dt)
    end
  else
    self.current_gravity = self.current_gravity + (app.config.GRAVITY * dt)
  end
  desired_y = round(desired_y + (self.current_gravity * dt))

  if desired_y < 1 - (app.config.TILE_WIDTH / 2) or desired_y > self:map_max_y() - app.config.TILE_WIDTH then
    -- stay on the goddamn map
    desired_y = self.y
  elseif desired_y < self.y then
    if self:tile_colliding_on_top(desired_x, desired_y) then
      self.current_gravity = 0
      self.y = self:clip_top(desired_y)
    else
      self.y = desired_y
    end
  elseif desired_y > self.y then
    if self:tile_colliding_on_bottom(desired_x, desired_y) then
      self.y = self:clip_bottom(desired_y)
    else
      self.y = desired_y
    end
  end
  self.map_y = self.y - 300

  self:update_environmental(dt)
  self:check_for_player_death()

  if self:win_colliding() then
    self:stop_timer()
    screen_manager:popState()
    screen_manager:pushState('WinScreen')
  end

  if love.keyboard.isDown("q") or love.keyboard.isDown("escape") then
    screen_manager:popState()
  end
end

function Game:keypressed(key, unicode)
end

-- custom functions

function Game:draw_map()
  local offset_x = self.map_x % app.config.TILE_WIDTH
  local offset_y = self.map_y % app.config.TILE_HEIGHT
  local first_tile_x = math.floor(self.map_x / app.config.TILE_WIDTH)
  local first_tile_y = math.floor(self.map_y / app.config.TILE_HEIGHT)

  for y=1, (app.config.MAP_DISPLAY_HEIGHT + self.map_display_buffer) do
    for x=1, (app.config.MAP_DISPLAY_WIDTH + self.map_display_buffer) do
      if x + first_tile_x == self.break_x and y + first_tile_y == self.break_y then
        love.graphics.setColor(self:break_color(), self:break_color(), self:break_color())
      else
        if self:tile_is_new_lava(x + first_tile_x, y + first_tile_y) then
          love.graphics.setColor(self:new_lava_color(), self:new_lava_color(), self:new_lava_color())
        else
          love.graphics.setColor(255,255,255)
        end
      end

      -- Note that this condition block allows us to go beyond the edge of the map.
      if y + first_tile_y >= 1 and y + first_tile_y <= self.map_height
        and x + first_tile_x >= 1 and x + first_tile_x <= self.map_width
      then
        local tile = self.tiles[self.map[y + first_tile_y][x + first_tile_x]]
        if tile then
          love.graphics.draw(
            tile,
            (x * app.config.TILE_WIDTH) - offset_x - app.config.TILE_WIDTH,
            (y * app.config.TILE_HEIGHT) - offset_y - app.config.TILE_HEIGHT)
        end
      end
    end
  end
end

function Game:coord()
  return {x=self.x, y=self.y}
end

function Game:tile_at_point(x,y)
  return self:tile_at_coord({x=x,y=y})
end

function Game:tile_at_coord(coord)
  return self.map[self:tile_y(coord.y)][self:tile_y(coord.x)]
end

function Game:tile_x(x)
  return round(1 + (x / app.config.TILE_WIDTH))
end

function Game:tile_y(y)
  return round(1 + (y / app.config.TILE_HEIGHT))
end

function Game:left_boundary(x)
  return x - app.config.PLAYER_LEFT
end

function Game:right_boundary(x)
  return x + app.config.PLAYER_RIGHT
end

function Game:top_boundary(y)
  return y - app.config.PLAYER_TOP
end

function Game:bottom_boundary(y)
  return y + app.config.PLAYER_BOTTOM
end

function Game:tile_is_walkable(tile)
  return tile == 0
end

function Game:first_solid_tile(tiles)
  return table.detect(tiles, function(tile)
                               if not self:tile_is_walkable(tile) then
                                 return tile
                               else
                                 return nil
                               end
                             end)
end

function Game:tile_colliding_on_left(x,y)
  return self:first_solid_tile({self:tile_at_point(self:left_boundary(x), self:top_boundary(y) + 2),
                                self:tile_at_point(self:left_boundary(x), self:bottom_boundary(y) - 2)})
end

function Game:tile_colliding_on_right(x,y)
  return self:first_solid_tile({self:tile_at_point(self:right_boundary(x), self:top_boundary(y) + 2),
                                self:tile_at_point(self:right_boundary(x), self:bottom_boundary(y) - 2)})
end

function Game:tile_colliding_on_top(x,y)
  return self:first_solid_tile({self:tile_at_point(self:left_boundary(x) + 2, self:top_boundary(y)),
                                self:tile_at_point(self:right_boundary(x) - 2, self:top_boundary(y))})
end

function Game:tile_colliding_on_bottom(x,y)
  return self:first_solid_tile({self:tile_at_point(self:left_boundary(x) + 2, self:bottom_boundary(y)),
                                self:tile_at_point(self:right_boundary(x) - 2, self:bottom_boundary(y))})
end

function Game:clip_left(x)
  return x - (self:left_boundary(x) % app.config.TILE_WIDTH) + (app.config.TILE_WIDTH / 2)
end


function Game:clip_right(x)
  return x - (self:right_boundary(x) % app.config.TILE_WIDTH) + (app.config.TILE_WIDTH / 2)
end

function Game:clip_top(y)
  return y - (self:top_boundary(y) % app.config.TILE_WIDTH) + (app.config.TILE_WIDTH / 2)
end

function Game:clip_bottom(y)
  if self:inside_map_y(y) then
    return y - (self:bottom_boundary(y) % app.config.TILE_WIDTH) + (app.config.TILE_WIDTH / 2)
  else
    debug("wrapped around the map -- bottom")
    return self:map_max_y() - (app.config.TILE_WIDTH / 2)
  end
end

function Game:bump_left(dt)
  local x = self:tile_x(self.x) - 1
  local y = self:tile_y(self.y)

  if self:break_brick(x, y, dt) then
    self.map[y][x] = 0
  end
end

function Game:bump_right(dt)
  local x = self:tile_x(self.x) + 1
  local y = self:tile_y(self.y)

  if self:break_brick(x, y, dt) then
    self.map[y][x] = 0
  end
end

function Game:bump_down(dt)
  local x = self:tile_x(self.x)
  local y = self:tile_y(self.y) + 1

  if self:break_brick(x, y, dt) then
    self.map[y][x] = 0
  end
end

function Game:break_brick(x, y, dt)
  if self.break_x == x and self.break_y == y then
    if self.break_dt + dt > app.config.BREAK_LIMIT then
      return true
    else
      self.break_dt = self.break_dt + dt
      return false
    end
  else
    self:reset_break(x, y, dt)
    return false
  end
end

function Game:reset_break(x, y, dt)
  self.break_x = x
  self.break_y = y
  self.break_dt = dt
end

function Game:break_percentage()
  return self.break_dt / app.config.BREAK_LIMIT
end

function Game:break_color()
  return 255 - (100 * self:break_percentage())
end

function Game:update_environmental()
end

function Game:inside_map(x, y)
  return self:inside_map_x(x) and self:inside_map_y(y)
end

function Game:inside_map_tiles(x, y)
  return self:inside_map_x(x * app.config.TILE_WIDTH) and self:inside_map_y(y * app.config.TILE_WIDTH)
end


function Game:inside_map_x(x)
  return x >= 1 and x <= self:map_max_x()
end

function Game:map_max_x()
  return #self.map[1] * app.config.TILE_WIDTH
end

function Game:inside_map_y(y)
  return y >= 1 and y <= self:map_max_y()
end

function Game:map_max_y()
  return  #self.map * app.config.TILE_WIDTH
end

function Game:check_for_player_death()
end

function Game:die()
  self.death_dt = 0.01
  self:stop_timer()
end

function Game:stop_timer()
  self.elapsed_time = love.timer.getMicroTime() - self.start_time
end

function Game:win_colliding()
  return self:is_touching_tile(function (tile) return tile == 5 end)
end

function Game:is_touching_tile(func)
  local tiles = {self:tile_at_point(self:left_boundary(self.x) - 2, self.y),
                 self:tile_at_point(self:right_boundary(self.x) + 2, self.y),
                 self:tile_at_point(self.x, self:top_boundary(self.y)),
                 self:tile_at_point(self.x, self:bottom_boundary(self.y))}

  return table.any(tiles, func)
end

function Game:player_dying()
  return self.death_dt > 0
end

function Game:player_alive()
  return not self:player_dying()
end

function Game:key_down(key)
  return self:player_alive() and love.keyboard.isDown(key)
end

function Game:tile_is_new_lava(x,y)
  return table.any(self.new_lava, function (pair) return pair[1] == y and pair[2] == x end)
end

function Game:new_lava_color()
  return 100 + 155 * self.lava_dt / app.config.LAVA_LIMIT
end

function Game:death_radians()
  if self:player_alive() then
    return 0
  else
    return app.config.DEATH_ANIMATION_RADIANS * self.death_dt / app.config.DEATH_ANIMATION_LIMIT
  end
end

function Game:player_display_x()
  if self.facing_right then
    return self.x
  else
    return self.x + app.config.TILE_WIDTH
  end
end

function Game:player_display_y()
  return self.y - self.map_y
end

function Game:player_scale_x()
  if self:player_alive() then
    if self.facing_right then
      return 1
    else
      return -1
    end
  else
    return self:death_scale()
  end
end

function Game:player_scale_y()
  if self:player_alive() then
    return 1
  else
    return self:death_scale()
  end
end

function Game:death_scale()
  return app.config.DEATH_ANIMATION_SCALE * self.death_dt / app.config.DEATH_ANIMATION_LIMIT
end
