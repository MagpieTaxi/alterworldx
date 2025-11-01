core.register_node("blocks:dirt", {
	description = "Dirt",
	tiles = {"dirt.png"},
	groups = {harvestable_shovel = 1},
	digtime = 5
})

core.register_node("blocks:grass_block",{
	description = "Grass Block",
	tiles = {"grass_top.png","dirt.png","grass_side.png"},
	groups = {harvestable_shovel = 1},
	digtime = 6
})

core.register_node("blocks:grass",{
	description = "Grass",
	drawtype = "plantlike",
	waving = 1,
	tiles = {"tallgrass.png"},
	digtime = 0.1,

	paramtype = "light",
    sunlight_propagates = true,  -- allows light through
    walkable = false,            -- no collision
    buildable_to = true,         -- you can place something over it
    floodable = true,            -- destroyed by water

	groups = {
		harvestable_hand = 3,
        flammable = 2,
        attached_node = 1
    },

    selection_box = {
        type = "fixed",
        fixed = {-0.3, -0.5, -0.3, 0.3, 0.3, 0.3}
    },

	drop = {
		max_items = 1,
		items = {
			{
				rarity = 3,
				items = {"items:plant_fiber"}
			}
		}
	}
})
core.register_node("blocks:pebble",{
	description = "Pebble",
	drawtype = "mesh",
	mesh = "rock1.obj",
	tiles = {"stone.png"},
	inventory_image = "pebble_item.png",
    wield_image = "pebble_item.png",
	paramtype = "light",            -- For light propagation if needed
    sunlight_propagates = true,
	paramtype2 = "facedir",
    groups = {harvestable_hand = 3},
	visual_offset = {x=0,y=-1,z=0},
    collision_box = {
		type = "fixed",
		fixed = {-0.19,-0.5,-0.13, 0.19,-0.36,0.13}
	},  -- Adjust to fit the model
    selection_box = {
        type = "fixed",
        fixed = {-0.19,-0.5,-0.13, 0.19,-0.36,0.13},
    },

	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local node = minetest.get_node(pos)
		node.param2 = math.random(0,3)  -- 0, 1, 2, or 3 → multiples of 90°
		minetest.set_node(pos, node)
	end,
})
core.register_node("blocks:stick",{
	description = "Stick",
	drawtype = "mesh",
	mesh = "stick1.obj",
	tiles = {"sycamore_planks.png"},
	inventory_image = "stick_item.png",
    wield_image = "stick_item.png",
	paramtype = "light",            -- For light propagation if needed
    sunlight_propagates = true,
	paramtype2 = "facedir",
    groups = {harvestable_hand = 2},
	visual_offset = {x=0,y=-1,z=0},
    collision_box = {
		type = "fixed",
		fixed = {-0.375,-0.5,-0.375, 0.375,-0.36,0.375}
	},  -- Adjust to fit the model
    selection_box = {
        type = "fixed",
        fixed = {-0.375,-0.5,-0.375, 0.375,-0.36,0.375},
    },

	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local node = minetest.get_node(pos)
		node.param2 = math.random(0,3)  -- 0, 1, 2, or 3 → multiples of 90°
		minetest.set_node(pos, node)
	end,
})

core.register_node("blocks:stone",{
	description = "Stone",
	tiles = {"stone.png"},
	groups = {harvestable_pickaxe = 1}
})

core.register_node("blocks:sycamore_log",{
	description = "Sycamore Log",
	tiles = {"sycamore_log_top.png","sycamore_log_top.png","sycamore_log.png"},
	groups = {harvestable_axe = 1},
	digtime = 10
})

core.register_node("blocks:sycamore_leaves",{
	description = "Sycamore Leaves",
	tiles = {"sycamore_leaves.png"},
	groups = {harvestable_cutters = 1, harvestable_hand = 2},
})

core.register_node("blocks:sycamore_branches",{
	description = "Sycamore Branches",
	tiles = {"sycamore_leaves_branched.png"},
	groups = {harvestable_cutters = 1, harvestable_hand = 2},
})