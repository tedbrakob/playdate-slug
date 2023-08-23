local pd <const> = playdate
local ds <const> = pd.datastore
local gfx <const> = pd.graphics

class('HighScoresTable').extends()

local highScoresTableFilename = 'highScoresTable'
local lastUsedNameFilename = 'highScoresTable-lastUsedName'

local defaultName = 'AAA'
local maxLength = 5

function HighScoresTable.reset()
  HighScoresTable.writeToDatastore({})
end

function HighScoresTable.writeToDatastore(hst)
  ds.write(hst, highScoresTableFilename)
  HighScoresTable.updateMenuImage(hst)
end

function HighScoresTable.readFromDatastore()
  local hst = ds.read(highScoresTableFilename)

  if (hst == nil) then
    hst = {}
    HighScoresTable.writeToDatastore(hst)
    HighScoresTable.writeLastUsedName(defaultName)
  end

  HighScoresTable.updateMenuImage(hst)

  return hst
end

function HighScoresTable.isHighScore(score)
  local hst = HighScoresTable.readFromDatastore()

  if #hst < maxLength then
    return true
  elseif score > hst[maxLength].value then
    return true
  else
    return false
  end
end

function HighScoresTable.addRecord(score, name)
  local hst = HighScoresTable.readFromDatastore()

  if #hst < maxLength then
    table.insert(hst, { name = name, value = score })
  elseif score > hst[maxLength].value then
    hst[maxLength] = { name = name, value = score }
  else
    return
  end

  table.sort(hst, function(a, b) return b.value < a.value end)
  HighScoresTable.writeToDatastore(hst)
  HighScoresTable.writeLastUsedName(name)
end

function HighScoresTable.writeLastUsedName(name)
  ds.write({ name }, lastUsedNameFilename)
end

function HighScoresTable.readLastUsedName()
  local name = ds.read(lastUsedNameFilename)

  if name == nil then
    return defaultName
  end

  return name[1]
end

function HighScoresTable.updateMenuImage(hst)
  local image = gfx.image.new(pd.display.getSize())

  gfx.pushContext(image)
    gfx.setColor(gfx.kColorBlack)
    gfx.fillRect(0, 0, pd.display.getSize())

    gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
    FONT_ROOBERT_20_MEDIUM:drawTextAligned("High Scores", 100, 10, kTextAlignment.center)

    if (#hst ~= 0) then
      for i = 1, #hst do
        local y = 70 + (i - 1) * 30
        local score = hst[i]

        FONT_ROOBERT_11_MEDIUM:drawTextAligned(score.name, 30, y, kTextAlignment.left)
        FONT_ROOBERT_11_MEDIUM:drawTextAligned(score.value, 165, y, kTextAlignment.right)
      end
    end

  gfx.popContext()

  pd.setMenuImage(image)
end