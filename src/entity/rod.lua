cursor = require("entity/fishing_cursor")

local rod = {}
rod.texture = love.graphics.newImage("textures/rod.png", {dpiscale=1.5})
rod.x = 295 + (cursor.x - 480) 
rod.y = 300

return rod
