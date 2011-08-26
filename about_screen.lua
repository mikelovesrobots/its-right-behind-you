-- add a state to that class using addState, and re-define the method
local AboutScreen = ScreenManager:addState('AboutScreen')

function AboutScreen:enterState()
end

function AboutScreen:draw()
  love.graphics.setColor(255,255,255);
  love.graphics.printf("Programming and Concept by Mike Judge", 0, 200, 800, 'center')
  love.graphics.printf("Graphics by M. Auayan", 0, 230, 800, 'center')
  love.graphics.printf("Music by Barton McGuire", 0, 260, 800, 'center')
  love.graphics.printf("Press enter to return to the previous screen", 0, 400, 800, 'center')
end

function AboutScreen:keypressed(key, unicode)
  if (key == "return") then
    screen_manager:popState()
  end
end
