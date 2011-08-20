-- add a state to that class using addState, and re-define the method
local Game = ScreenManager:addState('Game')
function Game:enterState()
  debug("Game initialized")

  love.graphics.setFont(app.config.MENU_FONT);
  love.graphics.setBackgroundColor(229, 232, 220);
  self.x = 400
  self.y = 50
  self.current_gravity = 0

  self.map = {
    { 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 0, 1, 1, 1, 3, 2, 3, 1, 1, 1},
    { 3, 1, 2, 2, 2, 1, 2, 2, 4, 4, 4, 0, 0, 0, 0, 0, 1, 3, 3, 3, 2, 2, 3, 1, 3},
    { 3, 1, 1, 1, 2, 2, 2, 2, 4, 4, 4, 0, 0, 0, 0, 0, 1, 1, 3, 3, 3, 2, 3, 3, 3},
    { 3, 3, 3, 3, 3, 3, 1, 1, 0, 4, 4, 0, 0, 0, 0, 0, 1, 2, 0, 3, 3, 2, 3, 1, 3},
    { 3, 1, 3, 3, 1, 1, 2, 1, 0, 4, 4, 0, 0, 0, 0, 0, 2, 1, 1, 3, 3, 2, 3, 1, 2},
    { 3, 1, 3, 1, 2, 2, 2, 2, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 3, 1, 1, 3},
    { 3, 1, 3, 1, 1, 1, 3, 1, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 1, 2, 3},
    { 3, 2, 2, 2, 1, 1, 3, 3, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 1, 2, 3},
    { 3, 1, 2, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 2, 2, 2, 2, 3},
    { 3, 1, 1, 1, 1, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 3, 2, 2, 3, 3},
    { 3, 2, 2, 2, 1, 3, 3, 3, 1, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 2, 3, 2, 2, 3, 3},
    { 3, 2, 1, 1, 1, 3, 2, 3, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 1, 2, 3, 2, 1, 3, 1},
    { 3, 2, 2, 2, 2, 3, 2, 3, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 1, 2, 3, 1, 1, 3, 3},
    { 3, 2, 2, 2, 1, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 2, 2, 1, 1, 3, 3},
    { 3, 3, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3}
  }

  -- map variables
  self.map_width = #self.map[1] -- Obtains the width of the first row of the map
  self.map_height = #self.map -- Obtains the height of the map
  self.map_x = 0
  self.map_y = 0
  self.map_display_buffer = 2 -- We have to buffer one tile before and behind our viewpoint.
                               -- Otherwise, the tiles will just pop into view, and we don't want that.
end

function Game:draw()
  self:draw_map()
  love.graphics.draw(app.config.PLAYER_IMAGE, self.x, self.y)
end

function Game:update(dt)
  if (self:tile_at_coord(self:bottom_boundary()) == 0) then
    self.current_gravity = self.current_gravity + (app.config.GRAVITY * dt)
    local new_y = self.y + (self.current_gravity * dt)
    if self:tile_at_point(self.x, new_y) == 0 then
      self.y = self.y + (self.current_gravity * dt)
    end
  else
    self.current_gravity = 0;
  end

  if love.keyboard.isDown("right") then
    local new_x = self.x + (app.config.SPEED * dt)
    if self:tile_at_point(new_x, self.y) == 0 then
      self.x = new_x
    end
  elseif love.keyboard.isDown("left") then
    local new_x = self.x - (app.config.SPEED * dt)
    if self:tile_at_point(new_x, self.y) == 0 then
      self.x = new_x
    end
  end

  if love.keyboard.isDown("down") then
    -- self.y = self.y + (app.config.SPEED * dt)
  elseif love.keyboard.isDown("up") then
    local new_y = self.y - (app.config.SPEED * dt)
    if self:tile_at_point(self.x, new_y) == 0 then
      self.y = new_y
    end
  end

  if love.keyboard.isDown(" ") then
    self.current_gravity = 0
  end

  if love.keyboard.isDown("q") then
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
      -- Note that this condition block allows us to go beyond the edge of the map.
      if y + first_tile_y >= 1 and y + first_tile_y <= self.map_height
        and x + first_tile_x >= 1 and x + first_tile_x <= self.map_width
      then
        local tile = app.config.TILES[self.map[y + first_tile_y][x + first_tile_x]]
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
  local tile_x = round(1 + (coord.x / app.config.TILE_WIDTH))
  local tile_y = round(1 + (coord.y / app.config.TILE_HEIGHT))
  return self.map[tile_y][tile_x]
end

function Game:left_boundary()
  return {x=self.x - (app.config.TILE_WIDTH / 2), y=self.y}
end

function Game:right_boundary()
  return {x=self.x + (app.config.TILE_WIDTH / 2), y=self.y}
end

function Game:top_boundary()
  return {x=self.x, y=self.y - (app.config.TILE_WIDTH / 2)}
end

function Game:bottom_boundary()
  return {x=self.x, y=self.y + (app.config.TILE_WIDTH / 2)}
end