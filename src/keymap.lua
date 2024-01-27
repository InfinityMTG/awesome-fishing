cursor = require("entity/fishing_cursor")

local keymap = {
  right = function()
    cursor.x = cursor.x + 5
  end,
  left = function()
    cursor.x = cursor.x - 5
  end,
  up = function()
    cursor.y = cursor.y - 5
  end,
  down = function()
    cursor.y = cursor.y + 5
  end,
}

return keymap
