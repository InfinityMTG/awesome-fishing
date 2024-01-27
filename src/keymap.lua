cursor = require("entity/fishing_cursor")

local keymap = {
  right = function()
    cursor.x = cursor.x + 1
  end,
  left = function()
    cursor.x = cursor.x - 1
  end,
  up = function()
    cursor.y = cursor.y - 1
  end,
  down = function()
    cursor.y = cursor.y + 1
  end,
}

return keymap
