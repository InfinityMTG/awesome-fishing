local rod = require("entity/rod")

function love.load()
  love.window.setTitle("awesome fishing")
end

function love.draw()
  love.graphics.draw(rod.texture, 200+100*math.sin(rod.x), rod.y)
end

function love.update()
  rod.x = sig_fig((rod.x + 0.1) % (math.pi * 2))
  print(rod.x, rod.y)
end

function sig_fig(n)
  return tonumber(string.format("%.3f", n))
  -- change the 3 in 3f to set the amount of sig figs.
end

