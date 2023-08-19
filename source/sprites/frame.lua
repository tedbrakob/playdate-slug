import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"

local pd <const> = playdate
local gfx <const> = pd.graphics

local dw, dh = pd.display.getSize()

class('Frame').extends(gfx.sprite)

function Frame:init(scale)
  self.scale = scale
  self.playGridRect = self:getPlayGridRect()

  local image = gfx.image.new(pd.display.getSize())
  gfx.pushContext(image)
    gfx.setColor(gfx.kColorBlack)
    gfx.fillRect(0, 0, dw, dh)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(self.playGridRect.x - 1, self.playGridRect.y - 1, self.playGridRect.w + 2, self.playGridRect.h + 2)
    gfx.setColor(gfx.kColorBlack)

    gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
    gfx.drawText("SLUG", self.playGridRect.x, 2)
    gfx.setImageDrawMode(gfx.kDrawModeCopy)
  gfx.popContext()

  self:setImage(image)
  self:setCenter(0, 0)
  self:setZIndex(-100)
  self:add()
end

function Frame:getBorderWidths()
  local topBorderWidth = 20
  local minBorderWidth = 5

  local effectiveTopBorderWidth = topBorderWidth + 1
  local effectiveMinBorderWidth = minBorderWidth + 1

  local gridWidth = dw - (effectiveMinBorderWidth * 2)
  local extraXBorderNeeded = gridWidth % self.scale

  local leftBorderWidth = math.floor(effectiveMinBorderWidth + (extraXBorderNeeded / 2))
  local rightBorderWidth = ((2 * effectiveMinBorderWidth) + extraXBorderNeeded) - leftBorderWidth

  local gridHeight = (dh - effectiveTopBorderWidth) - effectiveMinBorderWidth
  local extraYBorderNeeded = gridHeight % self.scale

  local bottomBorderWidth = effectiveMinBorderWidth + extraYBorderNeeded

  return effectiveTopBorderWidth, rightBorderWidth, bottomBorderWidth, leftBorderWidth
end

function Frame:getPlayGridRect()
  local topBorderWidth, rightBorderWidth, bottomBorderWidth, leftBorderWidth = self:getBorderWidths()

  local x = rightBorderWidth + 1
  local y = topBorderWidth + 1

  local w = dw - (rightBorderWidth + leftBorderWidth)
  local h = dh - (topBorderWidth + bottomBorderWidth)

  return {
    x = x,
    y = y,
    w = w,
    h = h
  }
end