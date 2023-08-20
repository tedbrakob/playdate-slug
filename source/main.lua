import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"

import "scenes/gameScene"
import "globals"

local pd <const> = playdate
local gfx <const> = pd.graphics

math.randomseed(playdate.getSecondsSinceEpoch())
GameScene()

function pd.update()
  gfx.sprite.update()
end