core.register_node("blocks:sand", {
	description = "Sand",
	tiles = {"altersand.png"},
	groups = {harvestable_shovel = 1},
	digtime = 2,
	sounds = AW.Audio.node_sound_sand_defaults()
})
core.register_node("blocks:sandstone",{
	description = "Sandstone",
	tiles = {"sandstone.png"},
	groups = {harvestable_pickaxe = 1},
	sounds = AW.Audio.node_sound_stone_defaults()
})