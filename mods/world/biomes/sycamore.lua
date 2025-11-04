core.register_biome({
	name = "sycamore_forest",
	node_top = "blocks:grass_block",
	depth_top = 1,
	node_filler = "blocks:dirt",
	depth_filler = 3,
	y_max = 1000,
	y_min = -2,
	heat_point = 50,
    humidity_point = 50,
})

--ores
minetest.register_ore({
    ore_type       = "blob",
    ore            = "blocks:gravel",
    wherein        = {"blocks:stone"}, -- host material
    clust_scarcity = 16 * 16 * 16,     -- how rare blobs are
    clust_size     = 8,                -- approximate blob radius
    y_max          = 31000,            -- highest Y it can spawn
    y_min          = -64,              -- lowest Y it can spawn

    noise_threshold = 0.0,             -- lower = larger blobs
    noise_params = {
        offset  = 0,
        scale   = 1,
        spread  = {x = 5, y = 5, z = 5}, -- how blobby/smooth they are
        seed    = 1,                 -- random seed
        octaves = 1,
        persist = 0.0,
    },

	biomes = {"sycamore_forest"}
})
minetest.register_ore({
    ore_type       = "scatter",              -- small, scattered patches
    ore            = "blocks:coarse_dirt",  -- block to generate
    wherein        = {"blocks:dirt","blocks:grass_block"},        -- blocks it replaces
    clust_scarcity = 16*16*16,              -- higher = rarer
    clust_num_ores = 6,                     -- how many nodes per patch
    clust_size     = 3,                      -- size of each patch
    y_min          = 1,                      -- minimum height
    y_max          = 50,                     -- maximum height
    biomes         = {"grasslands", "plains"}, -- optional: restrict to surface biomes
})

--decorations
core.register_decoration({ --tallgrass
	name = "tallgrass",
	deco_type = "simple",
	place_on = {'blocks:grass_block'},
	sidelen = 2,
	fill_ratio = 0.1,
    biomes = {"sycamore_forest"},
    y_min = 1,
    y_max = 100,
    decoration = "blocks:grass",
    param2 = 0,
    param2_max = 3,
})
core.register_decoration({ --roses
	name = "roses",
	deco_type = "simple",
	place_on = {'blocks:grass_block'},
	sidelen = 12,
	fill_ratio = 0.02,
    biomes = {"sycamore_forest"},
    y_min = 1,
    y_max = 100,
    decoration = "blocks:rose",
    param2 = 0,
    param2_max = 3,
})
core.register_decoration({ --pebbles
	name = "litter_pebble",
	deco_type = "simple",
	place_on = {'blocks:grass_block'},
	sidelen = 2,
	fill_ratio = 0.02, 
    biomes = {"sycamore_forest"},
    y_min = 1,
    y_max = 100,
    decoration = "blocks:pebble",
    param2 = 0,
    param2_max = 3,
})
core.register_decoration({ --twigs
	name = "litter_twig",
	deco_type = "simple",
	place_on = {'blocks:grass_block'},
	sidelen = 2,
	fill_ratio = 0.02,
    biomes = {"sycamore_forest"},
    y_min = 1,
    y_max = 100,
    decoration = "blocks:stick",
    param2 = 0,
    param2_max = 3,
})

--trees
local dark_oak_schematic = {
	size = {x=8,y=8,z=8},
	data = {{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_branches"},{name = "blocks:sycamore_branches"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_log"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_branches"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_branches"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_log"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_branches"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_branches"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_branches"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_log"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_log"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_branches"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_branches"},{name = "blocks:sycamore_log"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_branches"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_branches"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "blocks:sycamore_leaves"},{name = "blocks:sycamore_leaves"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},{name = "ignore"},},
}
core.register_decoration({
	name = "tree_sycamore",
	deco_type = "schematic",
	place_on = {'blocks:grass_block'},
	sidelen = 2,
	fill_ratio = 0.02,
    biomes = {"sycamore_forest"},
	schematic = dark_oak_schematic,
    flags = "place_center_x, place_center_z, force_placement",
    y_min = 1,
    y_max = 100,
	rotation = "random"
})