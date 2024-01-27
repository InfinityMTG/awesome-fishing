local rod = require("entity/rod")
local keymap = require("keymap")

function love.load()
  love.window.setTitle("awesome fishing")
  love.graphics.setBackgroundColor(53/255, 81/255, 92/255, 1)
end

function love.draw()
  love.graphics.draw(rod.texture, rod.x, rod.y)
end

function love.update()
  print(rod.x, rod.y)
end

function sig_fig(n)
  return tonumber(string.format("%.3f", n))
  -- change the 3 in 3f to set the amount of sig figs.
end

love.keypressed = function(pressed_key)
  if keymap[pressed_key] then
      keymap[pressed_key]()
  end
end
