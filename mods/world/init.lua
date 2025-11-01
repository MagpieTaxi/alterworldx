core.register_alias("mapgen_stone", "blocks:stone")
core.register_alias("mapgen_water_source", "blocks:dirt")

--decorations
core.register_decoration({ --tallgrass
	name = "tallgrass",
	deco_type = "simple",
	place_on = {'blocks:grass_block'},
	sidelen = 2,
	fill_ratio = 0.1,  -- controls density
    biomes = {"sycamore_forest"},
    y_min = 1,
    y_max = 100,
    decoration = "blocks:grass",
    param2 = 0,
    param2_max = 3,  -- random orientation
})
core.register_decoration({ --tallgrass
	name = "litter_pebble",
	deco_type = "simple",
	place_on = {'blocks:grass_block'},
	sidelen = 2,
	fill_ratio = 0.02,  -- controls density
    biomes = {"sycamore_forest"},
    y_min = 1,
    y_max = 100,
    decoration = "blocks:pebble",
    param2 = 0,
    param2_max = 3,  -- random orientation
})
core.register_decoration({ --tallgrass
	name = "litter_twig",
	deco_type = "simple",
	place_on = {'blocks:grass_block'},
	sidelen = 2,
	fill_ratio = 0.02,  -- controls density
    biomes = {"sycamore_forest"},
    y_min = 1,
    y_max = 100,
    decoration = "blocks:stick",
    param2 = 0,
    param2_max = 3,  -- random orientation
})

local dark_oak_schematic = {
	size = {x=8,y=8,z=8},
	data = {{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_branches"},{name = "blocks:sycamore_branches"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_log"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_branches"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_branches"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_log"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_branches"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_branches"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_branches"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_log"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_branches"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_branches"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_branches"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_branches"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},},
}
core.register_decoration({
	name = "tree_sycamore",
	deco_type = "schematic",
	place_on = {'blocks:grass_block'},
	sidelen = 2,
	fill_ratio = 0.02,  -- controls density
    biomes = {"sycamore_forest"},
	schematic = dark_oak_schematic,
    flags = "place_center_x, place_center_z, force_placement",
    y_min = 1,
    y_max = 100,
	rotation = "random"
})

core.register_biome({
	name = "sycamore_forest",
	node_top = "blocks:grass_block",
	depth_top = 1,
	node_filler = "blocks:dirt",
	depth_filler = 3,
	y_max = 1000,
	y_min = -3,
	heat_point = 50,
    humidity_point = 50,
})

