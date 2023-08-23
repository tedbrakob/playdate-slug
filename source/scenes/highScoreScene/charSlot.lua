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
  self.blinkerOn = true

  self:add()
end

function CharSlot:draw()
  gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
  FONT_ROOBERT_20_MEDIUM:drawTextAligned(self.char, 20, 0, kTextAlignment.center)

  if self.blinkerOn then
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(0, 30, 40, 5)
  end
end

function CharSlot:activate()
  self.blinker = gfx.animation.blinker.new(400, 350, true)
  self.blinker:start()
end

function CharSlot:deactivate()
  if self.blinker ~= nil then
    self.blinker:stop()
    self.blinker = nil
    self.blinkerOn = true
    self:markDirty()
    return
  end

  self.blinkerOn = true
end

function CharSlot:setChar(char)
  self.char = char
  self:markDirty()
end

function CharSlot:update()
  if self.blinker == nil then
    return
  end

  if self.blinker.on == self.blinkerOn then
    return
  end

  self.blinkerOn = self.blinker.on
  self:markDirty()
end