local pd <const> = playdate
local snd = pd.sound

class('Sounds').extends()

function Sounds:beep()
  s = snd.synth.new(snd.kWaveSine)
  s:playNote(600, .4, .1)
end

function Sounds:crash()
  s = snd.synth.new(snd.kWaveNoise)

  s:setAttack(0)
  s:setDecay(1)
  s:setSustain(.5)
  s:setRelease(1)

  s:playNote("D4", .25, .3)
end

function Sounds:tick()
  s = snd.synth.new(snd.kWaveNoise)

  s:setAttack(.025)

  s:playNote(100, .1, .05)
end
