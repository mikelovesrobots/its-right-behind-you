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
    { 3, 2, 2, 2, 1, 3, 3, 3, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 2, 1, 1, 3, 3},
    { 3, 3, 2, 1, 1, 0, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 3, 2, 1, 0, 0, 3, 3, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 0, 0, 3, 1, 1, 1, 1, 1, 1, 0, 0, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 3, 3, 3, 0, 0, 0, 0, 3, 1, 1, 1, 1, 1, 1, 0, 0, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 1, 1, 2, 1, 1, 1, 1, 1, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 2, 2, 1, 1, 1, 2, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 0, 0, 0, 0, 1, 2, 2, 2, 2, 1, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 0, 0, 0, 0, 0, 1, 2, 0, 2, 2, 1, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 2, 0, 0, 2, 1, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 2, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 1, 2, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 0, 0, 0, 2, 2, 1, 2, 0, 0, 0, 1, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 0, 0, 0, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 3, 3, 3, 0, 0, 0, 3, 2, 3, 3, 0, 0, 0, 0, 1, 1, 1, 3, 2, 3, 1, 1, 1},
    { 3, 1, 2, 2, 2, 1, 2, 2, 3, 3, 3, 0, 0, 0, 0, 0, 1, 3, 3, 3, 2, 2, 3, 1, 3},
    { 3, 1, 1, 1, 2, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 1, 1, 3, 3, 3, 2, 3, 3, 3},
    { 3, 3, 3, 3, 3, 4, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 3, 3, 2, 3, 1, 3},
    { 3, 1, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 0, 2, 1, 1, 3, 3, 2, 3, 1, 2},
    { 3, 1, 3, 1, 4, 4, 4, 2, 3, 4, 4, 4, 4, 3, 3, 0, 0, 0, 0, 3, 3, 3, 1, 1, 3},
    { 3, 1, 3, 1, 4, 4, 3, 1, 3, 2, 4, 4, 1, 2, 3, 2, 0, 0, 0, 1, 2, 3, 1, 2, 3},
    { 3, 2, 2, 2, 1, 1, 3, 3, 3, 2, 1, 1, 1, 2, 3, 2, 0, 0, 0, 1, 2, 2, 1, 2, 3},
    { 3, 1, 2, 1, 1, 1, 0, 0, 0, 2, 2, 1, 1, 0, 1, 2, 0, 0, 2, 1, 2, 2, 2, 2, 3},
    { 3, 1, 1, 1, 1, 2, 2, 0, 0, 0, 1, 1, 1, 0, 1, 2, 2, 0, 2, 2, 3, 2, 2, 3, 3},
    { 3, 2, 2, 2, 1, 3, 3, 3, 1, 0, 0, 1, 0, 0, 0, 1, 1, 2, 2, 2, 3, 2, 2, 3, 3},
    { 3, 2, 1, 1, 1, 3, 2, 3, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 1, 2, 3, 2, 1, 3, 1},
    { 3, 2, 2, 2, 2, 3, 2, 3, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 1, 2, 3, 1, 1, 3, 3},
    { 3, 2, 2, 2, 1, 3, 3, 3, 0, 2, 4, 4, 4, 3, 1, 1, 1, 2, 2, 2, 2, 1, 1, 3, 3},
    { 3, 3, 2, 1, 1, 1, 1, 0, 0, 2, 2, 4, 2, 3, 3, 3, 3, 3, 3, 3, 2, 1, 1, 2, 3},
    { 3, 3, 2, 1, 0, 0, 1, 1, 2, 2, 2, 4, 2, 2, 2, 2, 3, 3, 3, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 1, 1, 1, 2, 2, 2, 2, 2, 1, 2, 1, 3, 3, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 1, 1, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 3, 4, 3, 0, 0, 0, 0, 0, 0, 1, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 3, 3, 2, 1, 3, 3, 3, 3, 2, 1, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 1, 0, 3, 2, 1, 2, 2, 2, 2, 2, 1, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 2, 0, 0, 0, 0, 0, 2, 3, 2, 1, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 3, 1, 4, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 0, 0, 0, 2, 0, 0, 0, 0, 1, 4, 4, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 2, 2, 2, 2, 3, 2, 3, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 1, 2, 3, 1, 1, 3, 3},
    { 3, 2, 2, 2, 1, 3, 3, 3, 3, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 2, 1, 1, 3, 3},
    { 3, 3, 2, 1, 1, 0, 0, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 3, 2, 1, 0, 0, 0, 3, 3, 2, 2, 0, 0, 0, 2, 2, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 3, 3, 3, 3, 2, 2, 1, 1, 2, 1, 1, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 3, 3, 0, 2, 2, 1, 1, 1, 1, 1, 1, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 4, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 2, 1, 4, 1, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 1, 4, 4, 4, 4, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 2, 1, 1, 4, 4, 4, 4, 1, 2, 2, 2, 3, 3},
    { 3, 3, 2, 1, 2, 2, 2, 2, 2, 0, 0, 0, 1, 1, 1, 4, 4, 4, 4, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 2, 2, 1, 1, 3, 0, 1, 1, 1, 1, 1, 1, 2, 4, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 2, 2, 0, 0, 0, 0, 0, 0, 2, 1, 1, 2, 2, 4, 3, 2, 1, 1, 2, 3},
    { 3, 2, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 3, 2, 4, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 3, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 3, 2, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 3, 3, 2, 1, 0, 0, 0, 0, 0, 0, 1, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 2, 3, 2, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 2, 2, 3, 2, 1, 1, 0, 0, 0, 3, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 2, 2, 2, 2, 1, 0, 0, 3, 3, 3, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 2, 1, 0, 0, 0, 2, 2, 2, 1, 0, 1, 3, 2, 2, 2, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 1, 2, 0, 0, 1, 1, 1, 1, 1, 1, 2, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 4, 1, 2, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 4, 1, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 0, 0, 0, 0, 0, 0, 3, 3, 1, 4, 1, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 2, 2, 0, 1, 3, 1, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 2, 0, 0, 0, 0, 1, 2, 0, 0, 2, 3, 3, 3, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 0, 0, 0, 3, 3, 1, 1, 0, 2, 3, 3, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 2, 1, 0, 2, 2, 0, 3, 3, 3, 2, 0, 2, 2, 3, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 2, 1, 1, 3, 3, 2, 1, 1, 1, 1, 1, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 2, 2, 3, 3, 2, 2, 2, 2, 2, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 3, 3, 3, 0, 0, 3, 3, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 0, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 0, 0, 3, 3, 0, 0, 0, 0, 3, 1, 1, 1, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 0, 0, 0, 3, 0, 0, 0, 0, 3, 1, 2, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 2, 2, 0, 0, 2, 2, 0, 2, 3, 1, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 1, 2, 2, 0, 0, 2, 2, 2, 2, 3, 3, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 1, 2, 2, 0, 0, 0, 2, 2, 2, 3, 3, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 2, 0, 1, 2, 3, 0, 0, 0, 2, 2, 3, 1, 1, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 0, 0, 1, 3, 3, 0, 0, 0, 2, 3, 3, 2, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 2, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 3, 3, 3, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 3, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 3, 3, 3, 3, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 3, 0, 0, 2, 0, 0, 0, 0, 0, 1, 2, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 4, 4, 3, 2, 0, 0, 0, 0, 0, 1, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 4, 4, 4, 3, 2, 0, 0, 0, 0, 1, 1, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 2, 2, 4, 3, 2, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 2, 1, 2, 2, 2, 2, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 1, 1, 2, 2, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3},
    { 3, 3, 2, 1, 1, 1, 1, 1, 1, 2, 1, 1, 0, 0, 1, 1, 1, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 0, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 0, 2, 1, 1, 0, 0, 2, 2, 1, 0, 0, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 3, 3, 3, 0, 0, 0, 2, 0, 0, 0, 0, 0, 2, 1, 0, 0, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 3, 2, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 3, 2, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 0, 3, 2, 1, 1, 0, 0, 0, 0, 0, 1, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 0, 0, 2, 1, 1, 0, 0, 0, 2, 2, 1, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 2, 0, 0, 2, 2, 1, 1, 0, 2, 2, 2, 2, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 2, 2, 2, 2, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 2, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 3, 3, 3, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 0, 0, 0, 2, 3, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 3, 3, 0, 3, 3, 0, 0, 0, 3, 1, 1, 1, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 3, 4, 0, 2, 3, 0, 0, 2, 3, 1, 2, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 3, 2, 0, 3, 2, 0, 1, 2, 3, 1, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 0, 0, 2, 2, 3, 2, 0, 1, 2, 2, 1, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 0, 0, 1, 2, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 2, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 2, 2, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 2, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 2, 3, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 1, 1, 1, 2, 1, 1, 1, 1, 3, 1, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 0, 0, 2, 2, 2, 0, 0, 3, 3, 1, 1, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 3, 3, 3, 0, 0, 0, 0, 2, 2, 0, 3, 4, 1, 3, 1, 1, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 1, 3, 3, 3, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 4, 4, 4, 4, 2, 3, 2, 3, 3, 1, 1, 1, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 3, 4, 4, 4, 2, 3, 2, 0, 3, 1, 2, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 3, 3, 2, 1, 2, 3, 0, 0, 0, 1, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 0, 3, 3, 2, 1, 0, 0, 0, 0, 0, 1, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 0, 0, 2, 1, 2, 1, 0, 0, 0, 0, 1, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 2, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 2, 2, 2, 2, 2, 2, 3, 2, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 3, 2, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 0, 3, 2, 1, 1, 0, 0, 0, 0, 0, 1, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 0, 0, 2, 1, 1, 0, 0, 0, 2, 2, 1, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 2, 0, 0, 2, 2, 1, 1, 0, 2, 2, 2, 2, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 2, 2, 2, 2, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 2, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 3, 3, 3, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 0, 0, 0, 2, 3, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 3, 3, 0, 3, 3, 0, 0, 0, 3, 1, 1, 1, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 3, 4, 0, 2, 3, 0, 0, 2, 3, 1, 2, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 3, 2, 0, 3, 2, 0, 1, 2, 3, 1, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 0, 0, 2, 2, 3, 2, 0, 1, 2, 2, 1, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 2, 2, 2, 2, 2, 2, 3, 4, 0, 2, 3, 0, 0, 2, 3, 1, 2, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 3, 2, 0, 3, 2, 0, 1, 2, 3, 1, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 0, 0, 2, 2, 3, 2, 0, 1, 2, 2, 1, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 0, 0, 1, 2, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 2, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 2, 2, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 2, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 2, 3, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 1, 1, 1, 2, 1, 1, 1, 1, 3, 1, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 0, 0, 2, 2, 2, 0, 0, 3, 3, 1, 1, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 3, 3, 3, 0, 0, 0, 0, 2, 2, 0, 3, 4, 1, 3, 1, 1, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 1, 3, 3, 3, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 4, 4, 4, 4, 2, 3, 2, 3, 3, 1, 1, 1, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 3, 4, 4, 4, 2, 3, 2, 0, 3, 1, 2, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 3, 3, 2, 1, 2, 3, 0, 0, 0, 1, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 0, 3, 3, 2, 1, 0, 0, 0, 0, 0, 1, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 0, 0, 2, 1, 2, 1, 0, 0, 0, 0, 1, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 0, 0, 1, 2, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 2, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 2, 2, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    { 3, 3, 2, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 2, 3, 0, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 1, 1, 1, 2, 1, 1, 1, 1, 3, 1, 0, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 0, 0, 0, 0, 2, 2, 2, 0, 0, 3, 3, 1, 1, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 3, 3, 3, 0, 0, 0, 0, 2, 2, 0, 3, 4, 1, 3, 1, 1, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 1, 3, 3, 3, 0, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 4, 4, 4, 4, 2, 3, 2, 3, 3, 1, 1, 1, 3, 2, 1, 1, 2, 3},
    { 3, 2, 2, 2, 2, 2, 2, 3, 4, 4, 4, 2, 3, 2, 0, 3, 1, 2, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 2, 3, 3, 2, 1, 2, 3, 0, 0, 0, 1, 1, 2, 3, 2, 1, 1, 2, 3},
    { 3, 2, 1, 2, 2, 2, 0, 3, 3, 2, 1, 0, 0, 0, 0, 0, 1, 2, 2, 3, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 1, 1, 0, 0, 2, 1, 2, 1, 0, 0, 0, 0, 1, 1, 1, 1, 2, 1, 2, 3, 3},
    { 3, 1, 1, 1, 2, 2, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
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

  -- breaking bricks
  self.break_x = 0
  self.break_y = 0
  self.break_dt = 0

  -- lava
  self.lava_dt = 0
end

function Game:draw()
  self:draw_map()
  love.graphics.draw(app.config.PLAYER_IMAGE, self.x, self.y - self.map_y)
end

function Game:update(dt)
  local desired_x = self.x
  local desired_y = self.y

  if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
    desired_x = desired_x - (app.config.SPEED * dt)
  elseif love.keyboard.isDown("right") or love.keyboard.isDown("d") then
    desired_x = desired_x + (app.config.SPEED * dt)
  end

  desired_x = round(desired_x)
  if desired_x < self.x then
    if self:player_colliding_on_left(desired_x, desired_y) then
      self.x = self:clip_left(desired_x)
      self:bump_left(dt)
    else
      self.x = desired_x
    end
  elseif desired_x > self.x then
    if self:player_colliding_on_right(desired_x, desired_y) then
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
  if self:player_colliding_on_bottom(desired_x, desired_y) then
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

  if desired_y < self.y then
    if self:player_colliding_on_top(desired_x, desired_y) then
      self.current_gravity = 0
      self.y = self:clip_top(desired_y)
    else
      self.y = desired_y
    end
  elseif desired_y > self.y then
    if self:player_colliding_on_bottom(desired_x, desired_y) then
      self.y = self:clip_bottom(desired_y)
    else
      self.y = desired_y
    end
  end
  self.map_y = self.y - 300

  self:update_lava_flow(dt)

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
      if x + first_tile_x == self.break_x and y + first_tile_y == self.break_y then
        love.graphics.setColor(self:break_color(), self:break_color(), self:break_color())
      else
        love.graphics.setColor(255,255,255)
      end

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

function Game:player_colliding_on_left(x,y)
  return not(
    (self:tile_at_point(self:left_boundary(x), self:top_boundary(y) + 2) == 0) and
    (self:tile_at_point(self:left_boundary(x), self:bottom_boundary(y) - 2) == 0)
  )
end

function Game:player_colliding_on_right(x,y)
  return not(
    (self:tile_at_point(self:right_boundary(x), self:top_boundary(y) + 2) == 0) and
    (self:tile_at_point(self:right_boundary(x), self:bottom_boundary(y) - 2) == 0)
  )
end

function Game:player_colliding_on_top(x,y)
  return not(
    (self:tile_at_point(self:left_boundary(x) + 2, self:top_boundary(y)) == 0) and
    (self:tile_at_point(self:right_boundary(x) - 2, self:top_boundary(y)) == 0)
  )
end

function Game:player_colliding_on_bottom(x,y)
  return not(
    (self:tile_at_point(self:left_boundary(x) + 2, self:bottom_boundary(y)) == 0) and
    (self:tile_at_point(self:right_boundary(x) - 2, self:bottom_boundary(y)) == 0)
  )
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
  return y - (self:bottom_boundary(y) % app.config.TILE_WIDTH) + (app.config.TILE_WIDTH / 2)
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

function Game:update_lava_flow(dt)
  self.lava_dt = self.lava_dt + dt
  if self.lava_dt > app.config.LAVA_LIMIT then
    self:lava_flow()
    self.lava_dt = 0
  end
end

function Game:lava_flow()
  local new_lava = {}
  for y=1, #self.map do
    for x=1, #self.map[y] do
      if self.map[y][x] == 4 then
        local tile_underneath = self.map[y + 1][x]
        local tile_left = self.map[y][x - 1]
        local tile_right = self.map[y][x + 1]

        if tile_underneath == 0 then
          table.push(new_lava, {y+1,x})
        elseif tile_underneath >= 1 and tile_underneath <= 3 then
          if tile_left == 0 then
            table.push(new_lava, {y,x-1})
          end

          if tile_right == 0 then
            table.push(new_lava, {y,x+1})
          end
        elseif tile_underneath == 4 then
          if tile_left == 0 and math.random(1,round(1/app.config.LAVA_SPREAD_CHANCE)) == 1 then
            table.push(new_lava, {y,x-1})
          end

          if tile_right == 0 and math.random(1,round(1/app.config.LAVA_SPREAD_CHANCE)) == 1 then
            table.push(new_lava, {y,x+1})
          end
        end
      end
    end
  end

  table.each(new_lava, function(x)
                         self.map[x[1]][x[2]] = 4
                       end)
end