rod = require("entity/rod")

local keymap = {
  right = function()
    rod.x = rod.x + 20
  end,
  left = function()
    rod.x = rod.x - 20
  end,
}

return keymap
