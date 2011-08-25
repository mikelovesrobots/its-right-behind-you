local Level1 = ScreenManager:addState('Level1')
Level1:include(Game)

function Level1:initialize_level()
  love.graphics.setBackgroundColor(35, 15, 43)

  self.x = 400
  self.y = 80

  self.tiles = {
    love.graphics.newImage("images/dirt1.png"),
    love.graphics.newImage("images/dirt2.png"),
    love.graphics.newImage("images/dirt3.png"),
    love.graphics.newImage("images/lava.png"),
    love.graphics.newImage("images/highlight.png")
  }

  self.map = {
    { 3, 3, 3, 3, 3, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 3, 2, 3, 1, 1, 1},
    { 3, 3, 3, 3, 3, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 1, 3, 3, 2, 3, 1, 1, 1},
    { 3, 3, 3, 3, 3, 4, 4, 0, 0, 0, 0, 0, 0, 0, 1, 2, 1, 1, 3, 3, 2, 3, 1, 1, 1},
    { 3, 3, 3, 3, 3, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 3, 2, 3, 1, 1, 1},
    { 3, 3, 3, 3, 3, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 3, 2, 3, 1, 1, 1},
    { 3, 1, 2, 2, 2, 1, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 3, 3, 2, 2, 3, 1, 3},
    { 3, 1, 1, 1, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 3, 3, 3, 2, 3, 3, 3},
    { 3, 3, 3, 3, 3, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 3, 3, 2, 3, 1, 3},
    { 3, 1, 3, 3, 1, 1, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 3, 3, 2, 3, 1, 2},
    { 3, 1, 3, 1, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 3, 1, 1, 3},
    { 3, 1, 3, 1, 1, 1, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 1, 2, 3},
    { 3, 2, 2, 2, 1, 1, 3, 3, 0, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 1, 2, 3},
    { 3, 1, 2, 1, 1, 1, 0, 0, 0, 1, 2, 2, 2, 3, 1, 0, 0, 0, 2, 1, 2, 2, 2, 2, 3},
    { 3, 1, 1, 1, 1, 2, 2, 1, 1, 2, 2, 2, 2, 1, 1, 1, 0, 0, 2, 2, 3, 2, 2, 3, 3},
    { 3, 2, 2, 2, 1, 3, 3, 3, 1, 1, 2, 0, 0, 0, 1, 0, 0, 2, 2, 2, 3, 2, 2, 3, 3},
    { 3, 2, 1, 1, 1, 3, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 2, 1, 2, 3, 2, 1, 3, 1},
    { 3, 2, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 1, 2, 3, 1, 1, 3, 3},
    { 3, 2, 2, 2, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 2, 1, 1, 3, 3},
    { 3, 3, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 0, 3, 3, 1, 1, 1, 1, 1, 1, 1, 4, 4, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 0, 0, 3, 1, 1, 2, 2, 1, 1, 4, 4, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 3, 3, 3, 0, 0, 0, 0, 3, 1, 1, 1, 2, 2, 1, 4, 4, 4, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 2, 2, 4, 4, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 1, 1, 2, 1, 1, 1, 1, 1, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 3, 2, 2, 1, 1, 1, 2, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 0, 0, 0, 0, 1, 2, 2, 2, 2, 1, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 0, 0, 0, 0, 2, 1, 2, 0, 2, 2, 1, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 0, 0, 0, 1, 2, 1, 2, 0, 0, 2, 1, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 2, 0, 0, 0, 1, 2, 1, 2, 0, 0, 0, 1, 2, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 0, 0, 0, 2, 2, 1, 2, 0, 0, 0, 1, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 0, 0, 0, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 3, 3, 3, 0, 0, 0, 3, 2, 3, 3, 0, 0, 0, 0, 1, 1, 1, 3, 2, 3, 1, 1, 1},
    { 3, 1, 2, 2, 2, 1, 2, 2, 3, 3, 3, 0, 0, 0, 0, 0, 1, 3, 3, 3, 2, 2, 3, 1, 3},
    { 3, 1, 1, 1, 2, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 1, 1, 3, 3, 3, 2, 3, 3, 3},
    { 3, 3, 3, 3, 3, 4, 1, 1, 0, 0, 0, 2, 3, 0, 0, 0, 1, 2, 0, 3, 3, 2, 3, 1, 3},
    { 3, 1, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 0, 2, 1, 1, 3, 3, 2, 3, 1, 2},
    { 3, 1, 3, 1, 4, 4, 4, 2, 3, 4, 4, 4, 4, 3, 3, 0, 0, 0, 0, 3, 3, 3, 1, 1, 3},
    { 3, 1, 3, 1, 4, 4, 3, 1, 3, 2, 4, 4, 1, 2, 3, 2, 0, 0, 0, 1, 2, 3, 1, 2, 3},
    { 3, 2, 2, 2, 1, 1, 3, 3, 3, 2, 1, 1, 1, 2, 3, 2, 0, 0, 0, 1, 2, 2, 1, 2, 3},
    { 3, 1, 2, 1, 1, 1, 1, 2, 1, 2, 2, 1, 1, 0, 1, 2, 0, 0, 2, 1, 2, 2, 2, 2, 3},
    { 3, 1, 1, 1, 1, 2, 2, 2, 1, 0, 1, 1, 1, 0, 1, 2, 2, 0, 2, 2, 3, 2, 2, 3, 3},
    { 3, 2, 2, 2, 1, 3, 3, 3, 1, 0, 0, 1, 0, 0, 0, 1, 1, 2, 2, 2, 3, 2, 2, 3, 3},
    { 3, 2, 1, 1, 1, 3, 2, 3, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 1, 2, 3, 2, 1, 3, 1},
    { 3, 2, 2, 2, 2, 3, 2, 3, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 1, 2, 3, 1, 1, 3, 3},
    { 3, 2, 2, 2, 1, 3, 3, 3, 0, 2, 0, 0, 0, 3, 1, 1, 1, 2, 2, 2, 2, 1, 1, 3, 3},
    { 3, 3, 2, 1, 1, 1, 1, 0, 0, 2, 2, 4, 2, 3, 3, 3, 3, 3, 3, 3, 2, 1, 1, 2, 3},
    { 3, 3, 2, 1, 0, 0, 1, 1, 2, 2, 2, 4, 2, 2, 2, 2, 3, 3, 3, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 1, 1, 1, 2, 2, 2, 2, 2, 1, 2, 1, 3, 3, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 0, 0, 0, 1, 1, 0, 0, 2, 2, 0, 2, 2, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 4, 4, 4, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 4, 4, 4, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 4, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 3, 4, 3, 0, 0, 0, 0, 0, 0, 1, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 3, 3, 2, 1, 3, 3, 3, 3, 2, 1, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 1, 0, 3, 2, 1, 2, 2, 2, 2, 2, 1, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 2, 0, 0, 0, 0, 0, 2, 3, 2, 1, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 3, 1, 4, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 0, 0, 0, 2, 2, 0, 0, 0, 1, 4, 4, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 2, 2, 2, 2, 3, 2, 3, 0, 2, 2, 0, 0, 0, 1, 1, 1, 2, 1, 2, 3, 1, 1, 3, 3},
    { 3, 2, 2, 2, 1, 3, 3, 3, 3, 2, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 2, 1, 1, 3, 3},
    { 3, 3, 2, 1, 1, 0, 0, 3, 3, 4, 4, 4, 3, 3, 3, 2, 2, 3, 3, 3, 2, 1, 1, 2, 3},
    { 3, 3, 2, 1, 0, 0, 0, 3, 3, 2, 2, 4, 4, 3, 2, 2, 1, 2, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 3, 3, 3, 3, 2, 2, 1, 1, 2, 1, 1, 2, 1, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 3, 3, 0, 2, 2, 1, 1, 1, 1, 1, 1, 1, 3, 2, 1, 1, 2, 3},
    { 3, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 1, 3, 2, 1, 1, 2, 3},
    { 3, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 1, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 1, 2, 2, 2, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 0, 0, 0, 0, 0, 3, 0, 0, 2, 0, 0, 2, 2, 0, 0, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 3, 0, 2, 1, 0, 1, 1, 1, 1, 0, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 4, 4, 4, 3, 2, 4, 4, 4, 2, 1, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 4, 4, 4, 3, 2, 1, 4, 4, 1, 1, 4, 4, 4, 4, 1, 2, 2, 2, 3, 3},
    { 3, 3, 2, 1, 2, 4, 4, 4, 2, 3, 2, 2, 1, 1, 1, 4, 4, 4, 4, 3, 3, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 2, 2, 1, 1, 3, 0, 1, 1, 1, 1, 1, 1, 2, 4, 2, 1, 0, 1, 2, 3},
    { 3, 2, 2, 3, 3, 2, 2, 0, 0, 0, 0, 0, 0, 2, 1, 1, 2, 2, 1, 1, 0, 0, 1, 2, 3},
    { 3, 2, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 3, 0, 0, 0, 0, 0, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 3, 2, 0, 0, 1, 0, 0, 0, 0, 1, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 3, 3, 2, 1, 0, 1, 1, 0, 0, 0, 1, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 2, 3, 2, 1, 1, 1, 1, 2, 0, 0, 1, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 2, 2, 3, 2, 1, 1, 1, 3, 2, 3, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 0, 0, 2, 2, 2, 2, 1, 2, 3, 3, 3, 3, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 2, 1, 0, 0, 0, 2, 2, 2, 1, 2, 1, 3, 2, 2, 2, 0, 0, 0, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 4, 4, 1, 3, 2, 0, 1, 1, 1, 1, 1, 1, 2, 0, 0, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 4, 4, 4, 3, 3, 0, 0, 0, 0, 2, 2, 2, 2, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 3, 3, 3, 4, 4, 4, 3, 3, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 4, 4, 4, 3, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 3, 3, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 1, 1, 1, 0, 0, 0, 0, 2, 3, 1, 2, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 1, 2, 0, 0, 0, 0, 0, 2, 4, 1, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 1, 2, 0, 0, 0, 0, 3, 3, 3, 4, 4, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 2, 2, 0, 3, 4, 4, 4, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 2, 4, 4, 4, 4, 1, 2, 0, 0, 2, 3, 4, 3, 3, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 4, 4, 4, 3, 3, 1, 1, 0, 2, 3, 3, 2, 3, 1, 2, 2, 2, 3, 3},
    { 3, 3, 2, 1, 0, 2, 2, 0, 3, 3, 3, 2, 0, 2, 2, 3, 1, 2, 1, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 2, 1, 1, 3, 3, 2, 1, 1, 1, 1, 1, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 2, 2, 3, 3, 2, 2, 2, 2, 2, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 3, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 2, 2, 2, 2, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 2, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 2, 3},
    { 3, 2, 3, 3, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 1, 2, 1, 1, 2, 3},
    { 3, 2, 2, 4, 4, 2, 2, 0, 0, 0, 2, 3, 0, 0, 0, 2, 0, 0, 1, 1, 2, 1, 1, 2, 3},
    { 3, 2, 4, 4, 4, 2, 2, 3, 3, 0, 3, 3, 0, 0, 0, 3, 4, 4, 4, 4, 2, 1, 1, 2, 3},
    { 3, 2, 4, 4, 4, 2, 2, 3, 4, 0, 2, 3, 0, 0, 2, 3, 1, 4, 4, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 4, 4, 4, 2, 3, 2, 0, 3, 2, 0, 1, 2, 3, 1, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 4, 4, 4, 4, 4, 2, 0, 0, 2, 0, 1, 2, 2, 1, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 4, 4, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 2, 4, 1, 1, 4, 4, 4, 1, 1, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 1, 1, 1, 4, 4, 4, 1, 2, 2, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 2, 1, 0, 0, 1, 1, 1, 1, 4, 4, 1, 1, 2, 3, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 1, 1, 1, 2, 1, 1, 1, 1, 3, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 0, 0, 2, 2, 2, 0, 0, 3, 3, 0, 1, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 3, 3, 3, 0, 0, 0, 0, 2, 2, 0, 3, 4, 1, 3, 2, 1, 4, 4, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 1, 3, 3, 3, 4, 4, 4, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 4, 4, 4, 4, 2, 3, 2, 3, 3, 1, 1, 1, 4, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 3, 4, 4, 4, 2, 3, 2, 0, 3, 1, 2, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 3, 3, 2, 1, 2, 3, 0, 0, 0, 1, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 3, 3, 2, 1, 0, 0, 0, 0, 0, 1, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 1, 3, 2, 1, 2, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 2, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 0, 3, 2, 1, 1, 3, 0, 0, 0, 0, 1, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 0, 0, 2, 1, 1, 4, 4, 4, 4, 2, 1, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 2, 0, 0, 2, 2, 1, 1, 4, 4, 4, 2, 2, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 2, 4, 2, 2, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 2, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 3, 3, 3, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 0, 0, 0, 2, 3, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 3, 3, 0, 3, 3, 0, 0, 0, 3, 1, 1, 1, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 3, 4, 4, 4, 4, 4, 4, 2, 3, 1, 2, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 3, 2, 4, 4, 4, 4, 1, 2, 3, 1, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 0, 0, 2, 2, 4, 4, 4, 1, 2, 2, 1, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 2, 2, 2, 2, 2, 2, 3, 4, 0, 2, 4, 4, 0, 2, 3, 1, 2, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 3, 2, 0, 3, 2, 4, 1, 2, 3, 1, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 0, 0, 2, 2, 3, 2, 4, 1, 2, 2, 1, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 0, 0, 1, 2, 0, 2, 1, 1, 0, 0, 1, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 2, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 2, 2, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 2, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 2, 3, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 1, 1, 1, 2, 1, 1, 1, 1, 3, 1, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 0, 0, 2, 2, 2, 0, 0, 3, 3, 1, 1, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 3, 3, 3, 0, 0, 0, 0, 2, 2, 0, 3, 4, 1, 3, 1, 1, 0, 0, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 1, 3, 3, 3, 0, 0, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 4, 4, 4, 4, 2, 3, 2, 3, 3, 1, 0, 0, 0, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 3, 4, 4, 4, 2, 3, 2, 0, 3, 1, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 3, 3, 2, 1, 2, 3, 0, 0, 0, 1, 0, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 0, 3, 3, 2, 1, 0, 0, 0, 0, 0, 1, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 0, 0, 2, 1, 2, 1, 0, 0, 0, 0, 1, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 0, 0, 1, 2, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 2, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 2, 2, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 2, 1, 2, 2, 2, 0, 3, 3, 2, 1, 0, 0, 0, 0, 0, 1, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 0, 0, 2, 1, 2, 1, 0, 0, 0, 0, 1, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 2, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 3, 3},
    { 3, 3, 3, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 3, 3},
    { 3, 3, 3, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 3, 3},
    { 3, 3, 3, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 3, 3},
    { 3, 3, 3, 3, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 3, 3},
    { 3, 3, 3, 3, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 3, 3, 3, 3},
    { 3, 3, 2, 3, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 3, 3, 3, 3},
    { 3, 3, 2, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 3, 3, 3, 3},
    { 3, 3, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 3, 3, 2, 3, 3},
    { 3, 3, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3},
    { 3, 3, 2, 1, 1, 1, 1, 1, 0, 0, 0, 5, 5, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 1, 1, 0, 0, 0, 5, 5, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 0, 5, 5, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3}
  }
end

function Level1:update_environmental(dt)
  self:update_lava_flow(dt)
end

function Level1:update_lava_flow(dt)
  self.lava_dt = self.lava_dt + dt
  if self.lava_dt > app.config.LAVA_LIMIT then
    self:lava_flow()
    self.lava_dt = 0
  end
end

function Level1:lava_flow()
  self.new_tiles = {}
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
          table.push(self.new_tiles, {y+1,x})
        elseif tile_underneath and tile_underneath >= 1 and tile_underneath <= 3 then
          if tile_left == 0 then
            table.push(self.new_tiles, {y,x-1})
          end

          if tile_right == 0 then
            table.push(self.new_tiles, {y,x+1})
          end
        elseif tile_left and tile_left == 0 and math.random(1,round(1/app.config.LAVA_SPREAD_CHANCE)) == 1 then
          table.push(self.new_tiles, {y,x-1})
        elseif tile_right and tile_right == 0 and math.random(1,round(1/app.config.LAVA_SPREAD_CHANCE)) == 1 then
          table.push(self.new_tiles, {y,x+1})
        end
      end
    end
  end

  table.each(self.new_tiles, function(x)
                         self.map[x[1]][x[2]] = 4
                       end)
end

function Level1:check_for_player_death()
  if self:player_alive() and self:lava_colliding() then
    self:die()
  end
end

function Level1:lava_colliding()
  return self:is_touching_tile(function (tile) return tile == 4 end)
end
