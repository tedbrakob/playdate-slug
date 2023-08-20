import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "scenes/gameOverScene"
import "scenes/gameScene"
import "scenes/sceneManager"

import "sound/sounds"

import "sprites/snake/body"
import "sprites/snake/head"
import "sprites/frame"
import "sprites/goal"
import "sprites/score"

import "deque"

import "globals"

local pd <const> = playdate
local gfx <const> = pd.graphics

math.randomseed(playdate.getSecondsSinceEpoch())
SCENE_MANAGER:switchScene(GameScene)

function pd.update()
  gfx.sprite.update()
end