-- add a state to that class using addState, and re-define the method
local MainMenuScreen = ScreenManager:addState('MainMenuScreen')
MainMenuScreen.CHANGE_RATE = 1

function MainMenuScreen:enterState()
  debug("MainMenuScreen initialized")

  self.current_color = {0,0,0}
  self.time_since_last_change = 0
  self.regenerate_target_color(self)

  self:reset_menu()
end

function MainMenuScreen:draw()
  love.graphics.setFont(app.config.TITLE_FONT);
  set_color(self.current_color)
  love.graphics.printf(app.config.TITLE, 0, 200, 800, 'center')

  love.graphics.setFont(app.config.MENU_FONT);
  set_color(app.config.MENU_REGULAR_COLOR)

  for i,v in ipairs(self.menu) do
    local text = v.label
    if self.menu_index == i then
      text = "[ " .. text .. " ]"
    end

    love.graphics.printf(text, 0, 300 + (25 * i), 800, 'center')
  end
end

function MainMenuScreen:keypressed(key, unicode)
  if (key == "down") then
    self.menu_index = self.menu_index + 1
    if (self.menu_index > #self.menu) then
      self.menu_index = 1
    end
  end

  if (key == "up") then
    self.menu_index = self.menu_index - 1
    if (self.menu_index <= 0) then
      self.menu_index = #self.menu
    end
  end

  if (key == "return") then
    self.menu[self.menu_index].f()
  end
end

function MainMenuScreen:update(dt)
  self.time_since_last_change = self.time_since_last_change + dt
  if (self.time_since_last_change >= MainMenuScreen.CHANGE_RATE) then
    self.regenerate_target_color(self)
    self.time_since_last_change = 0
  end

  local multiplier = dt * 1/MainMenuScreen.CHANGE_RATE

  self.current_color[1] = self.current_color[1] + ((self.target_color[1] - self.current_color[1]) * multiplier)
  self.current_color[2] = self.current_color[2] + ((self.target_color[2] - self.current_color[2]) * multiplier)
  self.current_color[3] = self.current_color[3] + ((self.target_color[3] - self.current_color[3]) * multiplier)
end

function MainMenuScreen:reset_menu()
  debug("resetting the menu")

  self.menu = {
    {label="Start New Game", f=self.start_new_game_selected},
    {label="About", f=self.about_selected},
    {label="Quit", f=self.quit_selected}
  }

  self.menu_index = 1
end


function MainMenuScreen:regenerate_target_color()
  self.target_color = {math.random(200,255), math.random(200,255), math.random(100,255)}
end

function MainMenuScreen:start_new_game_selected()
  screen_manager:pushState('Game')
  screen_manager:start_new_game()
end

function MainMenuScreen:about_selected()
  screen_manager:pushState('AboutScreen')
end

function MainMenuScreen:quit_selected()
  love.event.push('q') -- quit the game
end

