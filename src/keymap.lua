cursor = require("entity/fishing_cursor")

local keymap = {
  right = function()
    cursor.x = cursor.x + 10
  end,
  left = function()
    cursor.x = cursor.x - 10
  end,
  up = function()
    cursor.y = cursor.y - 10
  end,
  down = function()
    cursor.y = cursor.y + 10
  end,
}

return keymap
