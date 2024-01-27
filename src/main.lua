love = love
--added to stop annoying syntax highlighting hahah

local rod = require("entity/rod")
local keymap = require("keymap")
local particleSystem = require("entity/particles")
local cursor = require("entity/fishing_cursor")
local fish = {
  examplefish = require("entity/examplefish")
}

function love.load()
  start = love.timer.getTime()
  love.window.setTitle("awesome fishing")
  love.graphics.setBackgroundColor(53/255, 81/255, 92/255, 1)
 end

function love.draw()
  if fish["examplefish"].fish.hidden == true then
    x = 0
  else
    x = 1
  end
  love.graphics.setColor(x,x,x,0.35)
  love.graphics.draw(fish["examplefish"].texture, fish["examplefish"].fish.x, fish["examplefish"].fish.y)
  love.graphics.setColor(0.5, 0, 0, 1)
  love.graphics.draw(cursor.texture, cursor.x, cursor.y)
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.line(rod.x + 246, rod.y + 1, cursor.x + 32, cursor.y + 16)
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(particleSystem, cursor.x + 32, cursor.y + 16)
  love.graphics.draw(rod.texture, rod.x, rod.y)
  
  
end

function love.update(dt)
  if cursor.touching_fish then
    particleSystem:setEmissionRate(30)
    else
      particleSystem:setEmissionRate(0)
  end
  rod.x = 295 + ((cursor.x - 480) * 2)
  particleSystem:update(dt)
  -- print(fish["examplefish"].fish.x , fish["examplefish"].fish.y)
  -- print(cursor.x , cursor.y)
  if fish["examplefish"].fish.checkCollision() then
    print("damn u a real shrigma") 	
    cursor.touching_fish = true
  else 
    cursor.touching_fish = false
  end

end

love.keypressed = function(pressed_key)
  if keymap[pressed_key] then
      keymap[pressed_key]()
  end
end

-- function sig_fig(n)
--   return tonumber(string.format("%.3f", n))
--   -- change the 3 in 3f to set the amount of sig figs.
-- end
