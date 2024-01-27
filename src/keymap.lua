cursor = require("entity/fishing_cursor")

local keymap = {
  right = function()
    cursor.x = cursor.x + 20
  end,
  left = function()
    cursor.x = cursor.x - 20
  end,
}

return keymap
