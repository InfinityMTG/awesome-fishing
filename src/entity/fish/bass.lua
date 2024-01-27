local fish = require("entity/fish")

local bass = {}
bass.fish = fish
bass.texture = love.graphics.newImage("textures/bass.png", {dpiscale = 30})
bass.fish.width = 100
bass.fish.height = 107
bass.fish.offsetX = 0
bass.fish.offsetY = 0
bass.fish.hitbox = love.physics.newRectangleShape(fish.x + bass.fish.offsetX, fish.y + bass.fish.offsetY, bass.fish.width, bass.fish.height, 0)

return bass
