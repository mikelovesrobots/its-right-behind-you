-- add a state to that class using addState, and re-define the method
local WinScreen = ScreenManager:addState('WinScreen')

function WinScreen:enterState()
end

function WinScreen:draw()
  love.graphics.setColor(255,255,255);
  love.graphics.printf("You win!", 0, 200, 800, 'center')
  love.graphics.printf("You completed this level in " .. self.elapsed_time .. " seconds", 0, 250, 800, 'center')
  love.graphics.printf("Try to beat it even faster!", 0, 300, 800, 'center')
  love.graphics.printf("Press enter to return to try again", 0, 400, 800, 'center')
end

function WinScreen:keypressed(key, unicode)
  if key == "return" then
    screen_manager:popState()
  end
end
