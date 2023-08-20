local pd <const> = playdate
local gfx <const> = pd.graphics

class('Body').extends(gfx.sprite)

function Body:init(x, y, size)
  self.size = size
  self.position = {
    x = x,
    y = y,
  }

  local image = gfx.image.new(size, size)

  gfx.pushContext(image)
    gfx.setColor(gfx.kColorBlack)
    gfx.fillRect(2, 2, size - 4, size - 4)
  gfx.popContext()

  self:setImage(image)
  self:moveTo(self.position.x, self.position.y)
  self:add()
  self:setCollideRect(0, 0, size, size)
end