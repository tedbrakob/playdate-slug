import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"

import "scenes/game"

local pd <const> = playdate
local gfx <const> = pd.graphics

math.randomseed(playdate.getSecondsSinceEpoch())
Game()

function pd.update()
  gfx.sprite.update()
end