local rod = require("entity/rod")

function love.load()
  
end

function love.draw()
  love.graphics.draw(rod.texture, 100*rod.x, rod.y)
end

function love.update()
  rod.x = sig_fig(math.sin((rod.x + 0.1) % (math.pi * 2)), 2)
  print(rod.x, rod.y)
end

