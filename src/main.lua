love = love
--added to stop annoying syntax highlighting hahah

local rod = require("entity/rod")
local keymap = require("keymap")
local particleSystem = require("entity/particles")
local cursor = require("entity/fishing_cursor")
--table containing all possible fish
local fish = {
  examplefish = require("entity/fish/examplefish"),
  -- eel = require("entity/fish/eel"),
  -- bass = require("entity/fish/bass"),
  -- goldfish = require("entity/fish/goldfish"),
  -- catfish = require("entity/fish/catfish"),
}

--accept keypresses and pass them to the keymap function table
love.keypressed = function(pressed_key)
  if keymap[pressed_key] then
      keymap[pressed_key]()
  end
end

--run on load
function love.load()
  Start = love.timer.getTime()
  love.window.setTitle("awesome fishing")
  love.graphics.setBackgroundColor(53/255, 81/255, 92/255, 1)
 end

--currently drawn objects
function love.draw()
  --if fish.hidden is true, draw as a silhouette
  local x
  local y
  if fish["examplefish"].fish.hidden == true then
    x = 0
    y = 0.35
  else
    x = 1
    y = 1
  end
  love.graphics.setColor(x,x,x,y)
  love.graphics.draw(fish["examplefish"].texture, fish["examplefish"].fish.x, fish["examplefish"].fish.y)

  --red tint
  love.graphics.setColor(0.5, 0, 0, 1)
  love.graphics.draw(cursor.texture, cursor.x, cursor.y)

  --black
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.line(rod.x + 246, rod.y + 1, cursor.x + 32, cursor.y + 16)

  --full color sprites
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
  particleSystem:update(dt)
<<<<<<< HEAD
  -- print(fish["examplefish"].fish.x , fish["examplefish"].fish.y)
  -- print(cursor.x , cursor.y)
  if fish["examplefish"].fish.checkCollision() then
    print("damn u a real shrigma") 	
    cursor.touching_fish = true
  else 
    cursor.touching_fish = false
  end

end
=======
>>>>>>> c931c4eb6ac09446ec599a8f05393be6b6599b22

  rod.x = 295 + ((cursor.x - 480) * 2)
end
