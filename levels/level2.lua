local Level2 = ScreenManager:addState('Level2')
Level2:include(Game)

function Level2:initialize_level()
  love.graphics.setBackgroundColor(20, 109, 204);

  self.tiles = {
    love.graphics.newImage("images/concrete.png"),
    love.graphics.newImage("images/chair.png"),
    love.graphics.newImage("images/table.png"),
    love.graphics.newImage("images/filecabinet.png"),
    love.graphics.newImage("images/highlight.png")
  }

  self.map = {
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 0, 2, 3, 2, 0, 0, 4, 0, 4, 0, 0, 2, 3, 3, 2, 0, 2, 3, 3, 2, 0, 1, 0},
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    { 0, 1, 2, 2, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    { 0, 1, 3, 2, 3, 2, 1, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 3, 3, 0, 0},
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    { 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0}
  }
end

function Level2:update_environmental(dt)
  self:update_lava_flow(dt)
end

function Level2:update_lava_flow(dt)
  self.lava_dt = self.lava_dt + dt
  if self.lava_dt > app.config.LAVA_LIMIT then
    self:lava_flow()
    self.lava_dt = 0
  end
end

function Level2:lava_flow()
  self.new_lava = {}
  for y=1, #self.map do
    for x=1, #self.map[y] do
      if self.map[y][x] == 4 then
        local tile_underneath, tile_left, tile_right

        if self:inside_map_tiles(x, y + 1) then
          tile_underneath = self.map[y + 1][x]
        end

        if self:inside_map_tiles(x - 1, y) then
          tile_left = self.map[y][x - 1]
        end

        if self:inside_map_tiles(x + 1, y) then
          tile_right = self.map[y][x + 1]
        end

        if tile_underneath and tile_underneath == 0 then
          table.push(self.new_lava, {y+1,x})
        elseif tile_underneath and tile_underneath >= 1 and tile_underneath <= 3 then
          if tile_left == 0 then
            table.push(self.new_lava, {y,x-1})
          end

          if tile_right == 0 then
            table.push(self.new_lava, {y,x+1})
          end
        elseif tile_left and tile_left == 0 and math.random(1,round(1/app.config.LAVA_SPREAD_CHANCE)) == 1 then
          table.push(self.new_lava, {y,x-1})
        elseif tile_right and tile_right == 0 and math.random(1,round(1/app.config.LAVA_SPREAD_CHANCE)) == 1 then
          table.push(self.new_lava, {y,x+1})
        end
      end
    end
  end

  table.each(self.new_lava, function(x)
                         self.map[x[1]][x[2]] = 4
                       end)
end
