local fish = require("entity/fish")

local examplefish = {}
examplefish.fish = fish
examplefish.texture = love.graphics.newImage("textures/examplefish.png")
examplefish.fish.width = 111
examplefish.fish.height = 60
examplefish.fish.offsetX = 23
examplefish.fish.offsetY = 14
examplefish.fish.hitbox = love.physics.newRectangleShape(examplefish.fish.x + examplefish.fish.offsetX, examplefish.fish.y + examplefish.fish.offsetY, 111, 60, 0)

return examplefish
