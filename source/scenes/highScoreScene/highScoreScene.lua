local pd <const> = playdate
local gfx <const> = pd.graphics

class('HighScoreScene').extends(gfx.sprite)

--[[
  copy and edit keyboard from sdk corelibs for maxlength 3 and caps only
]]
function HighScoreScene:init(score)
  self.name = HighScoresTable.readLastUsedName()

  self.score = score
  self.currentIndex = 1

  -- keyboard left edge
  local w = 222
  self.xCenter = w / 2

  self:setSize(pd.display.getSize())
  self:setCenter(0, 0)
  self:setZIndex(-100)

  self.charSlots = {
    CharSlot(self.name:sub(1, 1), true, self.xCenter - 60, 175),
    CharSlot(self.name:sub(2, 2), true, self.xCenter, 175),
    CharSlot(self.name:sub(3, 3), true, self.xCenter + 60, 175)
  }

  self:add()

  pd.keyboard.show()
  self.currentCharSlot = 1
  self.charSlots[self.currentCharSlot]:activate()

  function pd.keyboard.textChangedCallback()
    local backspace = false
    if #pd.keyboard.text < #self.name then
      backspace = true
    end

    self.charSlots[self.currentCharSlot]:deactivate()
    self.name = pd.keyboard.text

    if #self.name > 3 then
      self.name = self.name:sub(1, 2) .. self.name:sub(#self.name, #self.name)
      pd.keyboard.text = self.name
    end

    self.currentCharSlot = math.min(#self.name + 1, 3)
    self.charSlots[self.currentCharSlot]:activate()

    if backspace or #self.name == 0 then
      self:updateCharSlot(#self.name + 1)
    else
      self:updateCharSlot(#self.name)
    end
  end

  function pd.keyboard.keyboardWillHideCallback(confirmed)
    if confirmed ~= true then
      return
    end
  
    HighScoresTable.addRecord(self.score, self.name)
    SCENE_MANAGER:switchScene(GameScene)
  end
end

function HighScoreScene:updateCharSlot(i)
  self.charSlots[i]:setChar(self.name:sub(i, i))
end

function HighScoreScene:draw()
  gfx.setColor(gfx.kColorBlack)
  gfx.fillRect(0, 0, pd.display.getSize())

  gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
  FONT_ROOBERT_20_MEDIUM:drawTextAligned("High Score!", self.xCenter, 40, kTextAlignment.center)
  FONT_ROOBERT_20_MEDIUM:drawTextAligned(self.score, self.xCenter, 100, kTextAlignment.center)
end