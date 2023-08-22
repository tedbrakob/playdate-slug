local pd <const> = playdate
local gfx <const> = pd.graphics

class('Score').extends(gfx.sprite)

function Score:init(score, x, y)
  self.value = score

  self:updateText()

  self:setCenter(1, 0)
  self:moveTo(x, y)
  self:add()
end

function Score:updateText()
  local w = FONT_ROOBERT_11_MEDIUM:getTextWidth(self.value)
  local h = FONT_ROOBERT_11_MEDIUM:getHeight(self.value)

  local image = gfx.image.new(w, h)

  gfx.pushContext(image)
    gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
    FONT_ROOBERT_11_MEDIUM:drawTextAligned(self.value, w, 0, kTextAlignment.right)
  gfx.popContext()

  self:setImage(image)
end

function Score:updateValue(value)
  self.value = value
  self:updateText()
end