local pd <const> = playdate
local gfx <const> = pd.graphics

class('CharSlot').extends(gfx.sprite)

function CharSlot:init(char, isActive, x, y)
  CharSlot.super.init(self)

  self:setIgnoresDrawOffset(true)
  self:setSize(40, 35)
  self:moveTo(x, y)

  self.char = char
  self.isActive = isActive

  self:add()
end

function CharSlot:draw()
    gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
    FONT_ROOBERT_20_MEDIUM:drawTextAligned(self.char, 20, 0, kTextAlignment.center)

    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(0, 30, 40, 5)
end

function CharSlot:activate()

end

function CharSlot:deactivate()

end

function CharSlot:setChar(char)
  self.char = char
  self:markDirty()
end