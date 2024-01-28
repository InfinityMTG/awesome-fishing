waterParticle = love.graphics.newImage("textures/water_particle.png", {dpiscale = 1})
particleSystem = love.graphics.newParticleSystem(waterParticle, 100)
particleSystem:setParticleLifetime(0, 0.7)
particleSystem:setSizeVariation(0.5)
particleSystem:setLinearAcceleration(-200, 0, 200, -400)
particleSystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.
return particleSystem
