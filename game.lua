-- add a state to that class using addState, and re-define the method
local Game = ScreenManager:addState('Game')
function Game:enterState()
  debug("Game initialized")

  love.graphics.setFont(app.config.MENU_FONT);
  love.graphics.setBackgroundColor(229, 232, 220);
  self.x = 400
  self.y = 50
  self.speed = 200
  self.gravity = 200
  self.current_gravity = 0
end

function Game:start_new_game()
end

function Game:draw()
  love.graphics.draw(app.config.PLAYER_IMAGE, self.x, self.y)
end

function Game:update(dt)
  self.current_gravity = self.current_gravity + (self.gravity * dt)
  self.y = self.y + (self.current_gravity * dt)

  if love.keyboard.isDown("right") then
    self.x = self.x + (self.speed * dt)
  elseif love.keyboard.isDown("left") then
    self.x = self.x - (self.speed * dt)
  end

  if love.keyboard.isDown("down") then
    self.y = self.y + (self.speed * dt)
  elseif love.keyboard.isDown("up") then
    self.y = self.y - (self.speed * dt)
  end

  if love.keyboard.isDown("q") then
    screen_manager:popState()
  end
end

function Game:keypressed(key, unicode)
end

