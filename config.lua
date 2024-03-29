app = {}
app.config = {
  TITLE = "it's right behind you!",
  MENU_TITLE_COLOR = {235, 10, 68},
  MENU_HIGHLIGHT_COLOR = {255, 179, 11},
  MENU_REGULAR_COLOR = {200, 200, 200},
  MENU_FONT = love.graphics.newFont("fonts/VeraMono.ttf", 15),
  TITLE_FONT = love.graphics.newFont("fonts/AngelicWar.ttf", 48),
  PLAYER_IMAGE = love.graphics.newImage("images/player.png"),
  GRAVITY = 400,
  SPEED = 250,
  JUMP_SPEED = 300,
  TILE_WIDTH = 32,
  TILE_HEIGHT = 32,
  MAP_DISPLAY_WIDTH = 25,
  MAP_DISPLAY_HEIGHT = 18,
  PLAYER_LEFT = 4,
  PLAYER_RIGHT = 4,
  PLAYER_TOP = 16,
  PLAYER_BOTTOM = 16,
  BREAK_LIMIT = 0.25,
  LAVA_LIMIT = 0.27, --0.20 for expert, 0.27 for normal, 0.33 for easy
  LAVA_JUMP_CHANCE = 0.1,
  LAVA_SPREAD_CHANCE = 0.25,

  DEATH_ANIMATION_SCALE = 18,
  DEATH_ANIMATION_LIMIT = 0.75,
  DEATH_ANIMATION_RADIANS = 12,

  PLAYER_MESSAGE_WIDTH = 300,
  PLAYER_MESSAGE_DISTANCE_ABOVE_HEAD = 30,
  PLAYER_MESSAGE_COLOR = 255

}
