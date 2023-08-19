import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"

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
  local w, h = gfx.getTextSize(self.value)
  local image = gfx.image.new(w, h)

  gfx.pushContext(image)
    gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
    gfx.drawTextAligned(self.value, w, 0, kTextAlignment.right)
  gfx.popContext()

  self:setImage(image)
end

function Score:updateValue(value)
  self.value = value
  self:updateText()
end