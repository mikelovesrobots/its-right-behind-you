local Level2 = ScreenManager:addState('Level2')
Level2:include(Game)

function Level2:initialize_level()
  love.graphics.setBackgroundColor(20, 109, 204);

  self.x = 380
  self.y = 318 -- 444

  self.tiles = {
    love.graphics.newImage("images/concrete.png"),
    love.graphics.newImage("images/chair.png"),
    love.graphics.newImage("images/table.png"),
    love.graphics.newImage("images/filecabinet.png"),
    love.graphics.newImage("images/highlight.png"),
    love.graphics.newImage("images/beam.png")
  }
  self.mothership_image = love.graphics.newImage("images/mothership.png")
  self.mothership_x = 0
  self.mothership_y = 0

  -- beams
  self.beams_count = 8
  self.beams_dt = 0
  self.beams_limit = 0.66

  self.map = {
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 0, 2, 3, 2, 0, 0, 4, 0, 4, 0, 0, 2, 3, 3, 2, 0, 1, 1, 0, 0, 0, 1, 0},
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0},
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4, 1, 0},
    { 0, 1, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0},
    { 0, 1, 3, 2, 3, 0, 0, 0, 0, 2, 3, 3, 3, 2, 0, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0},
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 0, 2, 2, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 2, 2, 2, 3, 0, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 2, 2, 4, 4, 2, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 2, 3, 3, 2, 0, 0, 1, 0},
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 2, 2, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    { 0, 1, 3, 2, 3, 2, 1, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 3, 3, 0, 0},
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 1, 0},
    { 0, 1, 4, 0, 2, 3, 3, 3, 3, 2, 1, 0, 1, 2, 3, 3, 3, 3, 2, 0, 0, 4, 4, 1, 0},
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 4, 4, 4, 0, 0, 1, 2, 2, 3, 2, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 4, 4, 4, 4, 0, 1, 2, 2, 3, 2, 2, 3, 2, 2, 1, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 4, 4, 4, 4, 0, 1, 2, 2, 2, 2, 2, 2, 3, 2, 1, 0, 0, 0, 0, 4, 4, 1, 0},
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0}
  }

  self.mothership_pause_limit = 2.0
  self.mothership_pause_dt = 0.0
  self.mothership_limit = 6.0
  self.mothership_dt = 0.0
end

function Level2:update_environmental(dt)
  self:update_mothership(dt)
end

function Level2:update_mothership(dt)
  if self:mothership_is_pausing() then
    self.mothership_pause_dt = self.mothership_pause_dt + dt
    self.mothership_y = -50 * self.mothership_pause_dt / self.mothership_pause_limit
    self.mothership_x = 30 * self.mothership_pause_dt / self.mothership_pause_limit
  elseif self:mothership_is_lifting_off() then
    self.mothership_dt = self.mothership_dt + dt
    self.mothership_y = -50 + -400 * self.mothership_dt / self.mothership_limit
    self.mothership_x = 30 + -30 * self.mothership_dt / self.mothership_limit
  elseif self:mothership_is_firing_beams() then
    if self.beams_dt == 0 then
      self:clear_beams()
      self:fire_beam()
    end

    if self.beams_dt < self.beams_limit then
      self.beams_dt = self.beams_dt + dt
    else
      self.beams_dt = 0
    end
  end
end

function Level2:clear_beams()
  self.new_tiles = {}
  for y=1, #self.map do
    for x=1, #self.map[y] do
      if self.map[y][x] == 6 then
        self.map[y][x] = 0
      end
    end
  end
end

function Level2:fire_beam()
  local x = math.random(1, #self.map[1] - self.beams_count)
  table.times(self.beams_count, function (x_offset)
                                  local absolute_x = x + x_offset - 1
                                  for y = 1, #self.map - 1 do
                                    if self:tile_is_walkable(self.map[y][absolute_x]) then
                                      self.map[y][absolute_x] = 6
                                    else
                                      -- nuke the first tile
                                      self.map[y][absolute_x] = 6
                                      table.push(self.new_tiles, {y, absolute_x})
                                      break
                                    end
                                  end
                                end)
end

function Level2:draw()
  if self:mothership_is_lifting_off() then
    self:shake_screen(3)
  end

  Game.draw(self)
end

function Level2:new_tile_color()
  return 100 + 155 * self.beams_dt / self.beams_limit
end


function Level2:draw_level()
  if self.mothership_dt < self.mothership_limit then
    love.graphics.draw(self.mothership_image, self.mothership_x, self.mothership_y - self.map_y)
  end
end

function Level2:mothership_is_pausing()
  return self.mothership_pause_dt < self.mothership_pause_limit
end

function Level2:mothership_is_lifting_off()
  return not(self:mothership_is_pausing()) and self.mothership_dt < self.mothership_limit
end

function Level2:mothership_is_firing_beams()
  return self.mothership_dt >= self.mothership_limit
end

function Level2:shake_screen(amplitude)
  love.graphics.translate(math.random(amplitude*2)-amplitude, math.random(amplitude*2)-amplitude)
end

function Level2:check_for_player_death()
  if self:player_alive() and self:beam_colliding() then
    self:die()
  end
end

function Level2:beam_colliding()
  return self:is_touching_tile(function (tile) return tile == 6 end)
end