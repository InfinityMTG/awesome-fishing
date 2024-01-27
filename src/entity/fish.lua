local cursor = require("entity/fishing_cursor")
local fish = {}
fish.x = 400
fish.y = 350
fish.hidden = true
fish.hitbox = love.physics.newRectangleShape(400, 350, 128, 64, 0)

fish.checkCollision = function ()
  local topLeftX, topLeftY, bottomRightX, bottomRightY = fish.hitbox:computeAABB(0, 00, 0, 1)
  if cursor.x >= topLeftX and cursor.x <= bottomRightX and cursor.y >= topLeftY and cursor.y <= bottomRightY then
  	return true
  else
    -- print("cursor: " , cursor.x , cursor.y, "fish: ", topLeftX, fish.x, topLeftY, fish.y, bottomRightX, bottomRightY)
    return false
  end
end
return fish
