rod = require("entity/rod")

local keymap = {
  right = function()
    rod.x = rod.x + 5
  end,
  left = function()
    rod.x = rod.x - 5
  end,
}

return keymap
