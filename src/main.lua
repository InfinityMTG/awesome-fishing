love = love
--added to stop annoying syntax highlighting hahah

local rod = require("entity/rod")
local keymap = require("keymap")
local particles = require("entity/particles")
local cursor = require("entity/fishing_cursor")

function love.load()
  love.window.setTitle("awesome fishing")
  love.graphics.setBackgroundColor(53/255, 81/255, 92/255, 1)
 end

function love.draw()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(rod.texture, rod.x, rod.y)
  love.graphics.setColor(0.5, 0, 0, 1)
  love.graphics.draw(cursor.texture, cursor.x, cursor.y)
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.line(rod.x + 246, rod.y + 1, cursor.x + 32, cursor.y + 16)
end

function love.update()
  rod.x = 295 + ((cursor.x - 480 - 10) * 2)
end

love.keypressed = function(pressed_key)
  if keymap[pressed_key] then
      keymap[pressed_key]()
  end
end

-- function sig_fig(n)
--   return tonumber(string.format("%.3f", n))
--   -- change the 3 in 3f to set the amount of sig figs.
-- end
