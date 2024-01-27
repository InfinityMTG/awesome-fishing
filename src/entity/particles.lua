waterParticle = love.graphics.newImage("textures/water_particle.png")
particleSystem = love.graphics.newParticleSystem(waterParticle, 20)
particleSystem:setParticleLifetime(0.1, 0.9)
particleSystem:setEmissionRate(4)
particleSystem:setSizeVariation(1)
particleSystem:setLinearAcceleration(-20, -20, 20, 20)
particleSystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.

return particleSystem