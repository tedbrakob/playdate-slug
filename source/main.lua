import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/animation"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/keyboard"

import "scenes/gameOverScene"
import "scenes/gameScene"
import "scenes/highScoreScene/HighScoreScene"
import "scenes/highScoreScene/charSlot"
import "scenes/sceneManager"

import "sound/sounds"

import "sprites/snake/body"
import "sprites/snake/head"
import "sprites/frame"
import "sprites/goal"
import "sprites/score"

import "deque"
import "highScoresTable"

import "globals"

local pd <const> = playdate
local gfx <const> = pd.graphics

math.randomseed(playdate.getSecondsSinceEpoch())

HighScoresTable.readFromDatastore()
SCENE_MANAGER:switchScene(GameScene)

function pd.update()
  -- enable for high score table debugging
  -- if pd.buttonIsPressed(pd.kButtonUp) and pd.buttonIsPressed(pd.kButtonA) and pd.buttonIsPressed(pd.kButtonB) then
  --   HighScoresTable.reset()
  -- end

  gfx.sprite.update()
  gfx.animation.blinker.updateAll()
end