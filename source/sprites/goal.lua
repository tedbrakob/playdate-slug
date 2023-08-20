local pd <const> = playdate
local gfx <const> = pd.graphics

class('Goal').extends(gfx.sprite)

function Goal:init(size, playGridRect)
  self.size = size
  self.playGridRect = playGridRect

  local image = gfx.image.new(size, size)

  gfx.pushContext(image)
    gfx.setColor(gfx.kColorBlack)
    gfx.fillRect(1, 1, size - 2, size - 2)
  gfx.popContext()

  self:setImage(image)
  self:setCollideRect(0, 0, self:getSize())

  self:add()
  self:move()
end

function Goal:move()
  local x = 0
  local y = 0
  local moved = false

  while moved == false do
    x = math.random(0, self.playGridRect.w - self.size)
    y = math.random(0, self.playGridRect.h - self.size)

    local sprites = gfx.sprite.querySpritesAtPoint(self:alignToGrid(x, y))

    for _, sprite in ipairs(sprites) do
      if sprite:isa(Head) or sprite:isa(Body) then
        goto continue
      end
    end
    moved = true;
    self:moveTo(self:alignToGrid(x, y))

    ::continue::
  end
end

function Goal:alignToGrid(x, y)
  return self.playGridRect.x + ((x - (x % self.size)) + self.size / 2),
      self.playGridRect.y + ((y - (y % self.size)) + self.size / 2)
end
