core.register_node("blocks:sycamore_log",{
	description = "Sycamore Log",
	tiles = {"sycamore_log_top.png","sycamore_log_top.png","sycamore_log.png"},
	groups = {harvestable_axe = 1},
	digtime = 10,
	sounds = AW.Audio.node_sound_wood_defaults()
})

core.register_node("blocks:sycamore_planks",{
	description = "Sycamore Planks",
	tiles = {"sycamore_planks.png"},
	groups = {harvestable_axe = 1},
	digtime = 10,
	sounds = AW.Audio.node_sound_wood_defaults()
})
core.register_node("blocks:sycamore_slab",{
	description = "Sycamore Slab",
	tiles = {"sycamore_planks.png"},
	groups = {harvestable_axe = 1},
	digtime = 10,
	sounds = AW.Audio.node_sound_wood_defaults(),


})

core.register_node("blocks:sycamore_leaves",{
	description = "Sycamore Leaves",
	tiles = {"sycamore_leaves.png"},
	groups = {harvestable_cutters = 1, harvestable_hand = 2},
	sounds = AW.Audio.node_sound_leaves_defaults()
})

core.register_node("blocks:sycamore_branches",{
	description = "Sycamore Branches",
	tiles = {"sycamore_leaves_branched.png"},
	groups = {harvestable_cutters = 1, harvestable_hand = 2},
	sounds = AW.Audio.node_sound_leaves_defaults()
})