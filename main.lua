require('middleclass')
require('middleclass-extras')
require('lua-enumerable')

require('extras')
require('config')

require('screen_manager')
require('main_menu_screen')
require('about_screen')
require('dead_screen')
require('win_screen')
require('game')
require('levels/level1')
require('levels/level2')

DEBUG = true

function love.load()
  math.randomseed( os.time() )
  screen_manager = ScreenManager:new() -- this will call initialize and will set the initial menu
end

function love.draw()
  screen_manager:draw()
end

function love.update(dt)
  screen_manager:update(dt)
end

function love.keypressed(key, unicode)
  screen_manager:keypressed(key, unicode)
end
