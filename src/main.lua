love = love
--added to stop annoying syntax highlighting hahah

local rod = require("entity/rod")
local keymap = require("keymap")
local particleSystem = require("entity/particles")
local cursor = require("entity/fishing_cursor")


function createFish (name, width, height, offsetX, offsetY, dpiscale)
  local fish = {
    x = 380,
    y = 300,
    width = width,
    height = height,
    offsetX = offsetX,
    offsetY = offsetY,
    -- color = color,
    name = name,
    texture = love.graphics.newImage("textures/"..name..".png", {dpiscale=dpiscale}),
    caught = false,
    
  }
  fish.hitbox = love.physics.newRectangleShape(fish.x + fish.offsetX, fish.y + fish.offsetY, fish.width, fish.height, 0)
  return fish
end

function updateFishBox (myFish)
  myFish.hitbox:release()
  myFish.hitbox = love.physics.newRectangleShape(myFish.x + myFish.offsetX, myFish.y + myFish.offsetY, myFish.width, myFish.height, 0)
end

function fishCaught (myFish)
  myFish.caught = true
end

function fishCheckCollision (myFish, cursor)
  if not myFish.caught then
    local topLeftX, topLeftY, bottomRightX, bottomRightY = myFish.hitbox:computeAABB(0, 0, 0, 1)
    if cursor.x >= topLeftX and cursor.x <= bottomRightX and cursor.y >= topLeftY and cursor.y <= bottomRightY then
      -- print("cursor: " , cursor.x , cursor.y, "myFish: ", topLeftX, myFish.x, topLeftY, myFish.y, bottomRightX, bottomRightY, "(collision!)")
    	return true
    else
      -- print("cursor: " , cursor.x , cursor.y, "myFish: ", topLeftX, myFish.x, topLeftY, myFish.y, bottomRightX, bottomRightY)
      return false
    end
  end
end

function drawFish (myFish)
  love.graphics.draw(myFish.texture, myFish.x + myFish.offsetX, myFish.y + myFish.offsetY)
  -- print("fish draw")
end

function fishDrawImageEdges (myFish)
  -- print("drawing image edges...")
  love.graphics.line(myFish.x, myFish.y, myFish.x + myFish.width, myFish.y)
  love.graphics.line(myFish.x + myFish.width, myFish.y, myFish.x + myFish.width, myFish.y + myFish.height)
  love.graphics.line(myFish.x + myFish.width, myFish.y + myFish.height, myFish.x, myFish.y + myFish.height)
  love.graphics.line(myFish.x, myFish.y + myFish.height, myFish.x, myFish.y)
end

local client = require("websocket").new("192.168.40.51", 8080)
sincechange = 0
powerEnough = 0

function client:onmessage(message)
  n = 1
  data = {}
  for word in string.gmatch(message, '([^,]+)') do
      data[n] = word
      n = n + 1
  end
  cursor.x = cursor.x + (data[1] * 10)
  if cursor.x > 696 then cursor.x = 696 end
  if cursor.x < 0 then cursor.x = 0 end
  print(cursor.x, cursor.y)
  if tonumber(data[2]) < -0.55 and rod.isup == false then
    rod.isup = true
    sincechange = 0
  else
    sincechange = sincechange + 1
  end
  if tonumber(data[2]) > -0.45 and rod.isup == true then
    rod.isup = false
    sincechange = 0
  else
    sincechange = sincechange + 1
  end
  -- print(rod.isup, sincechange)
end

function client:onopen()
  -- print("connected!")
end

--accept keypresses and pass them to the keymap function table
love.keypressed = function(pressed_key)
  if keymap[pressed_key] then
      keymap[pressed_key]()
  end
end

--run on load
function love.load()
  powerMeter = 0
  Start = love.timer.getTime()
  love.window.setTitle("awesome fishing")
  love.graphics.setBackgroundColor(53/255, 81/255, 92/255, 1)
  local font = love.graphics.getFont()
  --regular text
  powerlevelText = love.graphics.newText(font, "POWER LEVEL")
  woman1 = createWoman("Goldfish",80,"goldfish")
  woman2 = createWoman("Catfish",280,"catfish")
  woman3 = createWoman("Bass",480,"bass")
  activefish = {
    createFish("bass", 100, 107, 0, 0, 30),
    createFish("examplefish", 111, 60, 23, 14, 1)
  }
  -- print(#activefish)
 end

--currently drawn objects
function love.draw()
  --TODO: WRITE FOR LOOP TO GO THROUGH ACTIVE FISH  

  --if fish.hidden is true, draw as a silhouette
  -- for i, f in pairs(activefish) do
  --   if not f.caught then
  --   	love.graphics.setColor(0, 0.1, 0, 0.35)
  --     love.graphics.draw(f.texture, f.fish.x, f.fish.y)
  --   end
  love.graphics.setColor(1,1,1,1)
  love.graphics.draw(love.graphics.newImage("textures/pond.jpg"))
  -- end
  for i,f in pairs(activefish) do
    if f.caught then
      love.graphics.setColor(1, 1, 1, 1)
    else
      love.graphics.setColor(0, 0.3, 0, 0.35)
    end
    drawFish(f)
  end  

  --red tint
  love.graphics.setColor(0.5, 0, 0, 1)
  love.graphics.draw(cursor.texture, cursor.x, cursor.y)

  --black
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.line(rod.x + 246, rod.y + 1, cursor.x + 32, cursor.y + 16)

  -- for i, f in pairs(activefish) do
  --   f.fish.drawImageEdges()
    -- print(f.fish.x + f.fish.width)
  -- end
  --outlines around fish and its bounding box, respectively
  -- fish["examplefish"].fish.drawImageEdges();
  
  -- love.graphics.line(fish["examplefish"].fish.x, fish["examplefish"].fish.y, fish["examplefish"].fish.x + 111, fish["examplefish"].fish.y)

  --full color sprites
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(particleSystem, cursor.x + 32, cursor.y + 16)
  love.graphics.draw(rod.texture, rod.x, rod.y)
  love.graphics.draw(love.graphics.newImage("textures/frame.png"), 0, 0)
  love.graphics.setColor(1,0,0,1)
  love.graphics.draw (powerlevelText, 10, 10)
  love.graphics.rectangle("fill", 20,50, 60,powerEnough)
  love.graphics.setColor(0,0,0,1)
  love.graphics.rectangle("line", 20,50, 60,200)
  drawWoman(woman1)
  drawWoman(woman2)
  drawWoman(woman3)

  -- if fish["examplefish"].fish.caught then
  --   love.graphics.setColor(1,1,1,1)
  --   love.graphics.draw(fish["examplefish"].texture, fish["examplefish"].fish.x, fish["examplefish"].fish.y)
  -- end
end

function love.update(dt)
  client:update()
  if cursor.touching_fish then
    particleSystem:setEmissionRate(30)
    else
      particleSystem:setEmissionRate(0)
  end
  particleSystem:update(dt)
  -- print(fish["examplefish"].fish.x , fish["examplefish"].fish.y)
  -- print(cursor.x , cursor.y)
  -- if fish["examplefish"].fish.checkCollision() then
  for i,f in pairs(activefish) do
    if fishCheckCollision(f, cursor) then
      -- print("damn u a real shrigma") 	
      cursor.touching_fish = true
    else 
      cursor.touching_fish = false
    end
  end
  rod.x = 295 + ((cursor.x - 480) * 2)
  for i, f in pairs(activefish) do
    if not f.caught then
      -- f.fish.x = f.fish.x + 0.1
    end
  end
  -- fish.fish.hitbox:computeAABB(fish.fish.x + 0.5, 0, 0, 1)
  for i, f in pairs(activefish) do
    if not f.caught then
      updateFishBox(f)
      -- f.hitbox:release()
      -- f.hitbox = love.physics.newRectangleShape(f.fish.x + f.fish.offsetX, f.fish.y + f.fish.offsetY, f.fish.width, f.fish.height, 0)
    end
  end

  powerMeter = 50 - math.abs(sincechange - 50)
  if cursor.touching_fish then
    if powerMeter > 50 then
      powerMeter = 50
    end
    if powerMeter < 0 then 
      powerMeter = 0
    end
    powerMeter = powerMeter * 4
    if powerMeter > 10 then
      powerEnough = powerEnough + 1
    else
      powerEnough = powerEnough - 1
    end
    if powerEnough > 200 then
      powerEnough = 200
      if cursor.touching_fish == true then
        -- print("win")
        for i,f in pairs(activefish) do
          if f.hitbox:testPoint(0, 0, 0, cursor.x, cursor.y) then
            fishCaught(f)
          end
        end
        
        -- fish["examplefish"].fish.caught = true
        -- fish["examplefish"].fish.x = 380
        powerEnough = 0
      end
    end
    if powerEnough <= 0 then
      powerEnough = 0
    end
  elseif powerEnough > 0 then 
    powerEnough = powerEnough - 1
  end
  collectgarbage()
end

function createWoman(name,y,texture)
  local font = love.graphics.newFont(24)
  --regular text
   local text = love.graphics.newText(font, name)
   local conf = {dpiscale = 12}
  local woman = {
    text = text,
    x = 810,
    y = y,
    textures = {love.graphics.newImage("textures/woman/"..texture .. "1.png",conf),love.graphics.newImage("textures/woman/"..texture .. "2.png",conf),love.graphics.newImage("textures/woman/"..texture .. "3.png",conf)},
    love = 50
  }
  return woman
end

function drawWoman(woman)
  love.graphics.setColor(1, 0.77, 0.62,1)
  love.graphics.rectangle("fill",woman.x-25,woman.y-40,150,190)
  -- love.graphics.setColor(0.5,0.5,0.5,1)
  -- love.graphics.rectangle("fill", woman.x,woman.y, 100,100)
  love.graphics.setColor(0,0,0,1)
  love.graphics.draw(woman.text, woman.x-5, woman.y-30)
  love.graphics.rectangle("fill",woman.x,woman.y+110,100,20)
  love.graphics.setColor(1,0.2,0.2,1)
  love.graphics.rectangle("fill",woman.x,woman.y+110,woman.love,20)
  love.graphics.setColor(1,1,1,1)
  love.graphics.draw(woman.textures[1],woman.x+5,woman.y-20)
end

function sig_fig(n)
  return tonumber(string.format("%.2f", n))
  -- change the 3 in 3f to set the amount of sig figs.
end
