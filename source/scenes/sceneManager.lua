import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('SceneManager').extends()

function SceneManager:switchScene(scene, ...)
  self.newScene = scene
  local args = { ... }
  self.sceneArgs = args

  self:loadNewScene()
end

function SceneManager:loadNewScene()
  self:cleanupScene()
  self.newScene(table.unpack(self.sceneArgs))
end

function SceneManager:cleanupScene()
  gfx.sprite.removeAll()
  self:removeAllTimers()
  gfx.setDrawOffset(0, 0)
end

function SceneManager:removeAllTimers()
  local allTimers = pd.timer.allTimers()
  for _, timer in ipairs(allTimers) do
    timer:remove()
  end
end
