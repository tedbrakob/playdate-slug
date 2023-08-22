local pd <const> = playdate
local gfx <const> = pd.graphics

class('GameOverScene').extends(gfx.sprite)

function GameOverScene:init(score)
  self.score = score

  HIGH_SCORES.addRecord(self.score)

  local image = gfx.image.new(pd.display.getSize())

  gfx.pushContext(image)
    gfx.setColor(gfx.kColorBlack)
    gfx.fillRect(0, 0, pd.display.getSize())
    gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
    
    FONT_ROOBERT_20_MEDIUM:drawTextAligned(self.score, 200, 80, kTextAlignment.center)
    FONT_ROOBERT_20_MEDIUM:drawTextAligned("Press Ⓐ to restart", 200, 200, kTextAlignment.center)
  gfx.popContext()

  self:setImage(image)
  self:setCenter(0, 0)

  self:add()
end

function GameOverScene:update()
  if (pd.buttonIsPressed(pd.kButtonA)) then
    SCENE_MANAGER:switchScene(GameScene)
  end
end