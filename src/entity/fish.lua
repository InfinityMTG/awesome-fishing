local cursor = require("entity/fishing_cursor")
local fish = {}
fish.x = 400
fish.y = 350
fish.hidden = true
fish.hitbox = love.physics.newRectangleShape(fish.x + 23, fish.y + 14, 111, 60, 0)
fish.texture = love.graphics.newImage("textures/examplefish.png")

fish.checkCollision = function ()
  local topLeftX, topLeftY, bottomRightX, bottomRightY = fish.hitbox:computeAABB(0, 0, 0, 1)
  if cursor.x >= topLeftX and cursor.x <= bottomRightX and cursor.y >= topLeftY and cursor.y <= bottomRightY then
    print("cursor: " , cursor.x , cursor.y, "fish: ", topLeftX, fish.x, topLeftY, fish.y, bottomRightX, bottomRightY, "(collision!)")
  	return true
  else
    print("cursor: " , cursor.x , cursor.y, "fish: ", topLeftX, fish.x, topLeftY, fish.y, bottomRightX, bottomRightY)
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
  -- topLeftX = topLeftX - 23
  -- topLeftY = topLeftY - 14
  love.graphics.line(0,0,topLeftX, topLeftY)
  love.graphics.line(topLeftX, topLeftY, topLeftX + bottomRightX, topLeftY)
  love.graphics.line(topLeftX + bottomRightX, topLeftY, topLeftX + bottomRightX, topLeftY + bottomRightY)
  love.graphics.line(topLeftX + bottomRightX, topLeftY + bottomRightY, topLeftX, topLeftY + bottomRightY)
  love.graphics.line(topLeftX, topLeftY + bottomRightY, topLeftX, topLeftY)
end
return fish
