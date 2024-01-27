waterParticle = love.graphics.newImage("textures/water_particle.png")
particleSystem = love.graphics.newParticleSystem(waterParticle, 100)
particleSystem:setParticleLifetime(0, 1)
particleSystem:setSizeVariation(0.5)
particleSystem:setLinearAcceleration(-100, 0, 100, -200)
particleSystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.
return particleSystem
