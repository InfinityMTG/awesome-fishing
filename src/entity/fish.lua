local cursor = require("entity/fishing_cursor")
local fish = {}
fish.color = "blurple"
fish.x = 380
fish.y = 300
-- fish.width = 111
-- fish.height = 60
-- fish.hitbox = love.physics.newRectangleShape(fish.x + 23, fish.y + 14, fish.width, fish.height, 0)

fish.checkCollision = function ()
  if not fish.caught then
    local topLeftX, topLeftY, bottomRightX, bottomRightY = fish.hitbox:computeAABB(0, 0, 0, 1)
    if cursor.x >= topLeftX and cursor.x <= bottomRightX and cursor.y >= topLeftY and cursor.y <= bottomRightY then
      -- print("cursor: " , cursor.x , cursor.y, "fish: ", topLeftX, fish.x, topLeftY, fish.y, bottomRightX, bottomRightY, "(collision!)")
    	return true
    else
      print("cursor: " , cursor.x , cursor.y, "fish: ", topLeftX, fish.x, topLeftY, fish.y, bottomRightX, bottomRightY)
      return false
    end
  end
end

fish.drawImageEdges = function ()
  print("drawing image edges...")
  love.graphics.line(fish.x, fish.y, fish.x + fish.width, fish.y)
  love.graphics.line(fish.x + fish.width, fish.y, fish.x + fish.width, fish.y + fish.height)
  love.graphics.line(fish.x + fish.width, fish.y + fish.height, fish.x, fish.y + fish.height)
  love.graphics.line(fish.x, fish.y + fish.height, fish.x, fish.y)
end

-- fish.drawCollision = function ()
--   local topLeftX, topLeftY, bottomRightX, bottomRightY = fish.hitbox:computeAABB(0, 0, 0, 1)
--   -- topLeftX = topLeftX - 23
--   -- topLeftY = topLeftY - 14
--   love.graphics.line(0,0,topLeftX, topLeftY)
--   love.graphics.line(topLeftX, topLeftY, topLeftX + bottomRightX, topLeftY)
--   love.graphics.line(topLeftX + bottomRightX, topLeftY, topLeftX + bottomRightX, topLeftY + bottomRightY)
--   love.graphics.line(topLeftX + bottomRightX, topLeftY + bottomRightY, topLeftX, topLeftY + bottomRightY)
--   love.graphics.line(topLeftX, topLeftY + bottomRightY, topLeftX, topLeftY)
-- end

fish.caught = false

return fish
