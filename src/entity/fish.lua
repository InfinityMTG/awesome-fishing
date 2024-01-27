local cursor = require("entity/fishing_cursor")
local fish = {}
fish.x = 400
fish.y = 350
fish.hidden = true
fish.hitbox = love.physics.newRectangleShape(400, 350, 128, 64, 0)

fish.checkCollision = function ()
  local topLeftX, topLeftY, bottomRightX, bottomRightY = fish.hitbox:computeAABB(0, 0, 0, 1)
  if cursor.x >= topLeftX and cursor.x <= bottomRightX and cursor.y >= topLeftY and cursor.y <= bottomRightY then
  	return true
  else
    -- print("cursor: " , cursor.x , cursor.y, "fish: ", topLeftX, fish.x, topLeftY, fish.y, bottomRightX, bottomRightY)
    return false
  end
end
fish.drawImageEdges = function ()
  love.graphics.line(fish.x, fish.y, fish.x + 111, fish.y)
  love.graphics.line(fish.x + 111, fish.y, fish.x + 111, fish.y + 60)
  love.graphics.line(fish.x + 111, fish.y + 60, fish.x, fish.y + 60)
  love.graphics.line(fish.x, fish.y + 60, fish.x, fish.y)
end

fish.drawCollision = function ()
  local topLeftX, topLeftY, bottomRightX, bottomRightY = fish.hitbox:computeAABB(0, 0, 0, 1)
  love.graphics.line(topLeftX, topLeftY, topLeftX + bottomRightX, topLeftY)
  love.graphics.line(topLeftX + bottomRightX, topLeftY, topLeftX + bottomRightX, topLeftY + bottomRightY)
  love.graphics.line(topLeftX + bottomRightX, topLeftY + bottomRightY, topLeftX, topLeftY + bottomRightY)
  love.graphics.line(topLeftX, topLeftY + bottomRightY, topLeftX, topLeftY)
end
return fish
