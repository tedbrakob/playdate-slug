local pd <const> = playdate
local gfx <const> = pd.graphics

class('Head').extends(gfx.sprite)

function Head:init(x, y, speed, size, playGridRect)
  self.initialLength = 1
  self.speedIncreasePerGoal = .1
  self.lengthIncreasePerGoal = 1
  self.maxSpeed = 12

  self.playGridRect = playGridRect
  self.body = Deque()
  self.size = size
  self.score = 0

  self.subPosition = {
    x = x,
    y = y,
  }

  local alignedX, alignedY = self:alignToGrid(x, y)
  self.position = {
    x = alignedX,
    y = alignedY,
  }

  self.speed = speed
  self.direction = 0
  self.lastMovementDirection = 0

  self.addSegments = self.initialLength - 1

  self.gameOver = false

  local image = gfx.image.new(size, size)

  gfx.pushContext(image)
    gfx.setColor(gfx.kColorBlack)
    gfx.fillRect(0, 0, size, size)
  gfx.popContext()

  self:setImage(image)
  self:moveTo(self.position.x, self.position.y)
  self:add()
  self:setCollideRect(0, 0, self:getSize())
end

function Head:alignToGrid(x, y)
  return self.playGridRect.x + ((x - (x % self.size)) + self.size / 2),
      self.playGridRect.y + ((y - (y % self.size)) + self.size / 2)
end

function Head:getScore()
  return self.score
end

function Head:addSegment()
  local tail = self.body:peek()

  local x, y
  if (tail == nil) then
    x, y = self:getPosition()
  else
    x, y = tail:getPosition()
  end

  local segment = Body(x, y, self.size);
  self.body:unshift(segment)
end

function Head:moveBody(x, y)
  local tailSegment = self.body:shift()

  if (tailSegment == nil) then
    return
  end

  tailSegment:moveTo(x, y)
  self.body:push(tailSegment)
end

function Head:setDirectionUp()
  if self.direction ~= 3 and self.lastMovementDirection ~= 3 then
    self.direction = 1
  end
end

function Head:setDirectionRight()
  if self.direction ~= 4 and self.lastMovementDirection ~= 4 then
    self.direction = 2
  end
end

function Head:setDirectionDown()
  if self.direction ~= 1 and self.lastMovementDirection ~= 1 then
    self.direction = 3
  end
end

function Head:setDirectionLeft()
  if self.direction ~= 2 and self.lastMovementDirection ~= 2 then
    self.direction = 4
  end
end

function Head:handleInput()
  if pd.buttonIsPressed(pd.kButtonUp) then
    self:setDirectionUp()
  elseif pd.buttonIsPressed(pd.kButtonRight) then
    self:setDirectionRight()
  elseif pd.buttonIsPressed(pd.kButtonDown) then
    self:setDirectionDown()
  elseif pd.buttonIsPressed(pd.kButtonLeft) then
    self:setDirectionLeft()
  end
end

function Head:updateSubPosition()
  if (self.direction == 1) then
    self.subPosition.y -= self.speed
  elseif (self.direction == 2) then
    self.subPosition.x += self.speed
  elseif (self.direction == 3) then
    self.subPosition.y += self.speed
  elseif (self.direction == 4) then
    self.subPosition.x -= self.speed
  end
end

function Head:updatePosition()
  self.position.x, self.position.y = self:alignToGrid(self.subPosition.x, self.subPosition.y)
end

function Head:spriteUpdateNeeded()
  local alignedNewX, alignedNewY = self:alignToGrid(self.x, self.y)

  if (alignedNewX ~= self.position.x or alignedNewY ~= self.position.y) then
    return true
  end

  return false
end

function Head:outOfBounds()
  local playGridRect = self.playGridRect

  if (
    self.position.x > playGridRect.w + playGridRect.x
        or self.position.x < playGridRect.x
        or self.position.y > playGridRect.h + playGridRect.y
        or self.position.y < playGridRect.y
  ) then
    return true;
  end

  return false
end

function Head:checkSpriteCollisions(x, y)
  local sprites = gfx.sprite.querySpritesAtPoint(x, y)

  for _, sprite in ipairs(sprites) do
    if (sprite:isa(Goal)) then
      SOUNDS:beep()
      self.score += 1
      sprite:move()

      if self.speed < self.maxSpeed then
        self.speed += self.speedIncreasePerGoal
      end

      self.addSegments += self.lengthIncreasePerGoal
    elseif (sprite:isa(Body)) then
      self:crash()
      return
    end
  end
end

function Head:crash()
  SOUNDS:crash()

  if HighScoresTable.isHighScore(self.score) then
    SCENE_MANAGER:switchScene(HighScoreScene, self.score)
  else
    SCENE_MANAGER:switchScene(GameOverScene, self.score)
  end
end

function Head:update()
  if (self.gameOver) then
    return
  end

  self:handleInput()

  if (self.direction == 0) then
    return
  end

  self:updateSubPosition()
  local oldPosition = {
    x = self.position.x,
    y = self.position.y,
  }
  self:updatePosition()

  if self.position.x == oldPosition.x and self.position.y == oldPosition.y then
    return
  end

  self.lastMovementDirection = self.direction
  if self:outOfBounds() then
    self:crash()
    return
  end

  self:checkSpriteCollisions(self.position.x, self.position.y)

  if self.gameOver then
    return
  end

  self:moveTo(self.position.x, self.position.y)

  if (self.addSegments > 0) then
    self.addSegments -= 1
    self:addSegment()
  end

  self:moveBody(oldPosition.x, oldPosition.y)
end

