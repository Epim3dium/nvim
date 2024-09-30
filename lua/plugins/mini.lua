local minialignsetup, minialign = pcall(require,'mini.align')
if not minialignsetup then return end
minialign.setup{}

local miniaisetup, miniai = pcall(require, 'mini.ai')
if not miniaisetup then return end
miniai.setup{}

local minisurroundsetup, minisurround = pcall(require, 'mini.surround')
if not minisurroundsetup then return end
minisurround.setup{}