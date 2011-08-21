-- add a state to that class using addState, and re-define the method
local DeadScreen = ScreenManager:addState('DeadScreen')

function DeadScreen:enterState()
end

function DeadScreen:draw()
  love.graphics.setColor(255,255,255);
  love.graphics.printf("You have died!", 0, 200, 800, 'center')
  love.graphics.printf("You survived " .. self.elapsed_time .. " seconds", 0, 250, 800, 'center')
  love.graphics.printf("Press enter to return to try again", 0, 400, 800, 'center')
end

function DeadScreen:keypressed(key, unicode)
  if (key == "return") then
    screen_manager:popState()
  end
end
