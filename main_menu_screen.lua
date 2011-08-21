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

function MainMenuScreen:continuedState()
  self:reset_menu()
end

function MainMenuScreen:draw()
  love.graphics.setFont(app.config.TITLE_FONT);
  set_color(self.current_color)
  love.graphics.printf(app.config.TITLE, 0, 150, 800, 'center')

  love.graphics.setFont(app.config.MENU_FONT);
  set_color(app.config.MENU_REGULAR_COLOR)

  for i,v in ipairs(self.menu) do
    local text = v.label
    if self.menu_index == i then
      text = "[ " .. text .. " ]"
    end

    love.graphics.printf(text, 0, 250 + (25 * i), 800, 'center')
  end

  love.graphics.printf("Instructions: use the arrows for movement or wasd/space. q quits.", 0, 500, 800, 'center')
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

  if (key == "return" or key == "space") then
    self.menu[self.menu_index].f()
  end

  if (key == "q" or key == "escape") then
    self.quit_selected()
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
  love.graphics.setBackgroundColor(0,0,0);

  debug("resetting the menu")

  self.menu = {
    {label="Start Beginner Game", f=self.start_easy_game_selected},
    {label="Start Experienced Game", f=self.start_medium_game_selected},
    {label="Start Expert Game", f=self.start_hard_game_selected},
    {label="Start Nightmare Game", f=self.start_nightmare_game_selected},
    {label="About", f=self.about_selected},
    {label="Quit", f=self.quit_selected}
  }

  self.menu_index = 1
end


function MainMenuScreen:regenerate_target_color()
  self.target_color = {math.random(200,255), math.random(200,255), math.random(100,255)}
end

function MainMenuScreen:start_easy_game_selected()
  app.config.LAVA_LIMIT = 0.33
  screen_manager:pushState('Game')
end

function MainMenuScreen:start_medium_game_selected()
  app.config.LAVA_LIMIT = 0.27
  screen_manager:pushState('Game')
end

function MainMenuScreen:start_hard_game_selected()
  app.config.LAVA_LIMIT = 0.20
  screen_manager:pushState('Game')
end

function MainMenuScreen:start_nightmare_game_selected()
  app.config.LAVA_LIMIT = 0.15
  screen_manager:pushState('Game')
end

function MainMenuScreen:about_selected()
  screen_manager:pushState('AboutScreen')
end

function MainMenuScreen:quit_selected()
  love.event.push('q') -- quit the game
end

