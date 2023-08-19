import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"

import "sprites/snake/head"
import "sprites/goal"
import "sprites/frame"
import "sprites/score"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Game').extends(gfx.sprite)

function Game:init()
  self.scale = 12
  self.speed = 4

  self:restart()
end

function Game:restart()
  gfx.sprite.removeAll()

  self.frame = Frame(self.scale)
  self.playGridRect = self.frame:getPlayGridRect()

  self.player = Head(self.playGridRect.w / 2, self.playGridRect.h / 2, self.speed, self.scale, self.playGridRect)
  self.score = self.player:getScore()

  self.scoreSprite = Score(self.score, self.playGridRect.x + self.playGridRect.w, 2)
  Goal(self.scale, self.playGridRect)

  self:add()
end

function Game:update()
  if (pd.buttonIsPressed(pd.kButtonA) and pd.buttonIsPressed(pd.kButtonB)) then
    if self.player.gameOver then
      self:restart()
    end
  end

  local newScore = self.player:getScore()

  if self.score ~= newScore then
    self.score = newScore
    self.scoreSprite:updateValue(newScore)
  end
end