local pd <const> = playdate
local gfx <const> = pd.graphics

class('GameScene').extends(gfx.sprite)

function GameScene:init()
  self.scale = 14
  self.speed = 4

  self:restart()
end

function GameScene:restart()
  self.frame = Frame(self.scale)
  self.playGridRect = self.frame:getPlayGridRect()

  self.player = Head(self.playGridRect.w / 2, self.playGridRect.h / 2, self.speed, self.scale, self.playGridRect)
  self.score = self.player:getScore()

  self.scoreSprite = Score(self.score, self.playGridRect.x + self.playGridRect.w, 0)
  Goal(self.scale, self.playGridRect)

  self:add()
end

function GameScene:update()
  local newScore = self.player:getScore()

  if self.score ~= newScore then
    self.score = newScore
    self.scoreSprite:updateValue(newScore)
  end
end
