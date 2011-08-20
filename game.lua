-- add a state to that class using addState, and re-define the method
local Game = ScreenManager:addState('Game')
function Game:enterState()
  debug("Game initialized")

  love.graphics.setFont(app.config.MENU_FONT);
end

function Game:start_new_game()
end

function Game:draw()
end

function Game:update()
end

function Game:keypressed(key, unicode)
  if (key == "q") then
    screen_manager:popState()
  else
    debug("unmapped key:" .. key)
  end
end

