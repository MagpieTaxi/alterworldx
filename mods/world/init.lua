core.register_alias("mapgen_stone", "blocks:stone")
core.register_alias("mapgen_water_source", "blocks:water_source")

local path = core.get_modpath("world")

dofile(path.."/biomes/generic.lua")
dofile(path.."/biomes/sycamore.lua")
dofile(path.."/biomes/desert.lua")
dofile(path.."/biomes/oceania.lua")