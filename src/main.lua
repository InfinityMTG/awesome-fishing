love = love
-- added to stop annoying syntax highlighting hahah

-- the fishing rod
local rod = require("entity/rod")
-- the keymap
local keymap = require("keymap")
-- the particles emitted when a fish is fishable
local particleSystem = require("entity/particles")
-- the cursor used to select a fish
local cursor = require("entity/fishing_cursor")

local fishMovement = {"sin", "cos", "tan"}

local fishNames = {"bass", "goldfish", "catfish"}

-- fish stuff
------

win = false 

local fishCount = 6
-- constructor for a fish; x and y are optional parameters
function createFish(name, width, height, offsetX, offsetY, dpiscale, direction, movement, x, y)
    -- if x has not been specified then set a default value, same with y
    if not x then
        x = 680
    end
    if not y then
        y = 300
    end
    local fish = {
        x = x,
        y = y,
        width = width,
        height = height,
        offsetX = offsetX,
        offsetY = offsetY,
        -- color = color,
        name = name,
        variation = 1,
        texture = love.graphics.newImage("textures/" .. name .. ".png", {
            dpiscale = dpiscale
        }),
        direction = direction,
        movement = movement,
        caught = false

    }
    -- construct a hitbox from the previous data, kind of janky formatting
    fish.hitbox = love.physics.newRectangleShape(fish.x + fish.offsetX, fish.y + fish.offsetY, fish.width, fish.height,
        0)
    return fish
end

-- updates the fish's hitbox (might have issues)
function updateFishBox(myFish)
    myFish.hitbox:release()
    myFish.hitbox = love.physics.newRectangleShape(myFish.x + myFish.offsetX, myFish.y + myFish.offsetY, myFish.width,
        myFish.height, 0)
    return myFish.hitbox
end

fishDrawer = {}
-- marks a fish as caught
function fishCaught(myFish)
    if myFish.caught then
        return
    end
    if (checkDrawer(myFish)) then
        return
    end
    myFish.caught = true

    for i, v in pairs(womens) do
        if myFish.name == string.lower(womens[i].name) and womens[i].prefered == myFish.variation then
            goToWoman(womens[i], myFish)
            return
        end
    end
    myFish.y = 620
    myFish.x = math.random(50, 700)
    table.insert(fishDrawer, myFish)
end
slidingFish = {}
function goToWoman(myWoman, myFish)
    table.insert(slidingFish, myFish)
    myWoman.love = myWoman.love + 50
    myWoman.currentTexture = 2
    -- woman reactions
    if woman1.love >= 100 and woman2.love >= 100 and woman3.love >= 100 then
      win = true
    end
end

function checkDrawer(myFish)
  return false
    -- for j, x in pairs(activefish) do
    --     for i, v in pairs(womens) do
    --         if x.name == string.lower(womens[i].name) and womens[i].prefered == x.variation then
    --             goToWoman(womens[i], x)
    --             break

    --         end
    --     end
    -- end
end
-- checks collision against a cursor object passed (might have issues)
function fishCheckCollision(myFish, myCursor)
    if not myFish.caught then
        local topLeftX, topLeftY, bottomRightX, bottomRightY = myFish.hitbox:computeAABB(0, 0, 0, 1)
        if myCursor.x >= topLeftX and myCursor.x <= bottomRightX and myCursor.y >= topLeftY and myCursor.y <=
            bottomRightY then
            -- print("myCursor: " , myCursor.x , myCursor.y, "myFish: ", topLeftX, myFish.x, topLeftY, myFish.y, bottomRightX, bottomRightY, "(collision!)")
            return true
        else
            -- print("myCursor: " , myCursor.x , myCursor.y, "myFish: ", topLeftX, myFish.x, topLeftY, myFish.y, bottomRightX, bottomRightY)
            return false
        end
    end
end

-- draws the fish using the texture, x, y and offsets. currently also draws edges to the sprite
function drawFish(myFish)
    love.graphics.draw(myFish.texture, myFish.x + myFish.offsetX, myFish.y + myFish.offsetY)
    -- fishDrawImageEdges(myFish)
    -- print("fish draw")
end

-- takes a fish and draws the bounding box of the sprite according to the x, y, width, height and offsets. this may not necessarily correspond to actual collision
function fishDrawImageEdges(myFish)
    love.graphics.line(myFish.x, myFish.y, myFish.x + myFish.width, myFish.y)
    love.graphics.line(myFish.x + myFish.width, myFish.y, myFish.x + myFish.width, myFish.y + myFish.height)
    love.graphics.line(myFish.x + myFish.width, myFish.y + myFish.height, myFish.x, myFish.y + myFish.height)
    love.graphics.line(myFish.x, myFish.y + myFish.height, myFish.x, myFish.y)
end

-- woman stuff
------
function createWoman(name, y, texture)
    local font = love.graphics.newFont(24)
    -- regular text
    local text = love.graphics.newText(font, name)
    local conf = {
        dpiscale = 10
    }
    local woman = {
        text = text,
        x = 810,
        y = y,
        currentTexture = 1,
        textures = {love.graphics.newImage("textures/woman/" .. texture .. "1.png", conf),
                    love.graphics.newImage("textures/woman/" .. texture .. "2.png", conf),
                    love.graphics.newImage("textures/woman/" .. texture .. "3.png", conf)},
        love = 0,
        prefered = 1,
        name = name
    }
    return woman
end

function drawWoman(woman)
    love.graphics.setColor(1, 0.9, 0.9, 1)
    love.graphics.rectangle("fill", woman.x - 25, woman.y - 40, 150, 190)
    -- love.graphics.setColor(0.5,0.5,0.5,1)
    -- love.graphics.rectangle("fill", woman.x,woman.y, 100,100)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(woman.textures[1], woman.x - 5, woman.y - 20)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.draw(woman.text, woman.x - 5, woman.y - 30)
    love.graphics.rectangle("fill", woman.x, woman.y + 110, 100, 20)
    love.graphics.setColor(1, 0.2, 0.2, 1)
    love.graphics.rectangle("fill", woman.x, woman.y + 110, woman.love, 20)
    love.graphics.setColor(1, 1, 1, 1)
  
end

-- websocket networking
------

-- define the server, says it takes 3 arguments but it seems to work fine with 2
local client = require("websocket").new("192.168.11.44", 8080)
sincechange = 0
powerEnough = 0

-- event to execute upon receiving a message from the server
function client:onmessage(message)
    -- counter for data index
    n = 1
    -- x (roll), y (pitch), z (yaw) formatted into data[1], data[2] and data[3]
    -- data is a value from 0 to -1 (i think)
    -- in the case of x, if the phone is flat on a surface it should be around 0 meanwhile if it is straight up it should be about -1
    data = {}
    for word in string.gmatch(message, '([^,]+)') do
        data[n] = word
        n = n + 1
    end

    -- change the cursors position, adding x * 10 to the current cursor x coordinate
    cursor.x = cursor.x + (data[1] * 10)
    -- ...and then check to make sure it isn't offscreen
    if cursor.x > 696 then
        cursor.x = 696
    end
    if cursor.x < 0 then
        cursor.x = 0
    end

    -- print(cursor.x, cursor.y)
    -- if the rod is in the "down" position but exceeds -0.55, then it will be switched to the up position
    if tonumber(data[2]) < -0.55 and rod.isup == false then
        rod.isup = true
        sincechange = 0
    else
        -- if not, it adds one to the counter of how many messages since the last switch
        sincechange = sincechange + 1
    end
    -- likewise, do the same for if the rod is in the up position, and exceeds -0.45
    if tonumber(data[2]) > -0.45 and rod.isup == true then
        rod.isup = false
        sincechange = 0
    else
        -- yeah
        sincechange = sincechange + 1
    end
    -- print(rod.isup, sincechange)
end

-- display a message upon connecting to the server
function client:onopen()
    print("connected!")
end

-- system stuff
------

-- accept keypresses and pass them to the keymap function table
love.keypressed = function(pressed_key)
    if keymap[pressed_key] then
        keymap[pressed_key]()
    end
end

-- run on load
function love.load()
  --init stuff
  powerMeter = 0
  Start = love.timer.getTime()
  love.window.setTitle("awesome fishing")
  love.graphics.setBackgroundColor(53/255, 81/255, 92/255, 1)
  local font = love.graphics.getFont()
  powerlevelText = love.graphics.newText(font, "POWER LEVEL")
  --creates three women objects assigning them 1 through 3
  woman1 = createWoman("Goldfish",80,"goldfish")
  woman2 = createWoman("Catfish",280,"catfish")
  woman3 = createWoman("Bass",480,"bass")
  womens = {woman1, woman2, woman3}
  --creates 2 fish objects and stores them within a table
  activefish = {
    createFish("bass", 138, 105, 0, 0, 10, 1, "sin", 900),
    createFish("catfish", 138, 105, 0, 0, 10, -1, "cos"),
    createFish("goldfish", 138, 105, 0, 0, 10, 1, "tan"),
    createFish("boot",100,100,0,0,5, 0, "sin",100)
  }
  winImg = love.graphics.newImage("textures/win.png")
 end

-- currently drawn objects
function love.draw()
  if win then
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(winImg,-150,0)
    return
  end
    -- TODO: WRITE FOR LOOP TO GO THROUGH ACTIVE FISH  
    -- solved?

    love.graphics.setColor(1, 1, 1, 0.3)
    love.graphics.draw(love.graphics.newImage("textures/pond.png"))
    -- end

    -- red tint
    love.graphics.setColor(0.5, 0, 0, 1)
    love.graphics.draw(cursor.texture, cursor.x, cursor.y)

    -- black
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.line(rod.x + 246, rod.y + 1, cursor.x + 32, cursor.y + 16)

    for i, f in pairs(activefish) do
        if f.caught then
            love.graphics.setColor(1, 1, 1, 1)
        else
            love.graphics.setColor(0, 0.3, 0, 0.35)
        end
        drawFish(f)
    end
  
    -- full color sprites
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(love.graphics.newImage("textures/frame.png"), 0, 0)

    love.graphics.setColor(1, 1, 1, 1)
    drawWoman(woman1)
    drawWoman(woman2)
    drawWoman(woman3)

    love.graphics.draw(particleSystem, cursor.x + 32, cursor.y + 16)
    love.graphics.draw(rod.texture, rod.x, rod.y)
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.draw(powerlevelText, 10, 10)
    love.graphics.rectangle("fill", 20, 50, 60, powerEnough)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("line", 20, 50, 60, 200)



end

rng = 0

function love.update(dt)
  if win then
    
    return
  end
    client:update()
    if (#activefish < fishCount) then
      math.randomseed(os.time() + rng)
      rng = rng + math.random(-10, 10)
      randomMovement = math.random(1, 3)
      math.randomseed(os.time() + rng)
      rng = rng + math.random(-10, 10)
      randomName = math.random(1, 3)
      randomOffsetX = math.random(-300, 300)
      randomDirection = math.random(0, 1)
      if randomDirection == 0 then
        randomDirection = -1
      end
    	table.insert(activefish, createFish(fishNames[randomName], 138, 105, 0, 0, 10, randomDirection, fishMovement[randomMovement], 380 + randomOffsetX))
    end 
    
    for i, v in pairs(slidingFish) do
        v.x = v.x + 4
        if v.x > 1000 then
            table.remove(slidingFish, i)
            table.remove(activefish, i)
        end
    end
    -- display particles if the cursor is touching a fish
    if cursor.touching_fish then
        particleSystem:setEmissionRate(30)
    else
      particleSystem:setEmissionRate(0)
  end
  particleSystem:update(dt)
  --probably broken logic, currently unresolved. help.
  n = false
  for i, f in pairs(activefish) do
    if fishCheckCollision(f, cursor) then
      -- print("damn u a real shrigma") 	
      cursor.touching_fish = true
      n = true
    end
  end
  if n == false then
    cursor.touching_fish = false
  end
  --move the rod at an offset from the target for the illusion of depth
  rod.x = 295 + ((cursor.x - 480) * 2)
  for i, f in pairs(activefish) do
    if not f.caught and f.name ~= "boot" then
      if f.movement == "sin" then
        f.x = f.x - (0.5 * f.direction)
        if f.x < -200 then
          f.x = 860
        end
        if f.x > 960 then
          f.x = -180
        end
        f.y = 280 + 20 * math.sin((f.x / 2) % (math.pi * 2))
      end
      if f.movement == "cos" then
        f.x = f.x - (0.75 * f.direction)
        if f.x < -200 then
          f.x = 860
        end
        if f.x > 960 then
          f.x = -180
        end
        f.y = 280 + 10 * math.cos((f.x / 3) % (math.pi * 2))
      end
      if f.movement == "tan" then
        f.x = f.x - (f.direction * 0.2)
        if f.x < -200 then
          f.x = 860
        end
        if f.x > 960 then
          f.x = -180
        end
        f.y = 280 + 20 * math.tan((f.x / 40) % (math.pi * 2))
        if f.y < -150 then
          f.y = 620
        end
      end
    end
  end
  for i, f in pairs(activefish) do
    if not f.caught then
      f.hitbox = updateFishBox(f)
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
        for i,f in pairs(activefish) do
          if f.hitbox:testPoint(0, 0, 0, cursor.x, cursor.y) and not f.caught then
            print("win")
            fishCaught(f)
            powerEnough = 0
            break
          end
        end
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

-- misc
------
function sig_fig(n)
    return tonumber(string.format("%.3f", n))
    -- change the 3 in 3f to set the amount of sig figs.
end
