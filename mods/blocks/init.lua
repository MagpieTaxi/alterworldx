--water
minetest.register_node("blocks:water_source", {
    description = "Water",
    drawtype = "liquid",
    tiles = {"water.png"},
	use_texture_alpha = "blend",
    paramtype = "light",
    walkable = false,
	pointable = false,
    buildable_to = true,
    liquidtype = "source",
    liquid_alternative_flowing = "blocks:water_flowing",
    liquid_alternative_source = "blocks:water_source",
    liquid_viscosity = 1,
    post_effect_color = {a = 80, r = 30, g = 60, b = 255},
    groups = {water = 3, liquid = 3},
	sounds = AW.Audio.node_sound_water_defaults()
})
minetest.register_node("blocks:water_flowing", {
    drawtype = "flowingliquid",
    tiles = {"water.png"},
    special_tiles = {
        {name = "water.png", backface_culling = false},
        {name = "water.png", backface_culling = true},
    },
	use_texture_alpha = "blend",
    paramtype = "light",
    paramtype2 = "flowingliquid",
    walkable = false,
	pointable = false,
    buildable_to = true,
    liquidtype = "flowing",
    liquid_alternative_flowing = "blocks:water_flowing",
    liquid_alternative_source = "blocks:water_source",
    liquid_viscosity = 1,
    post_effect_color = {a = 80, r = 30, g = 60, b = 255},
    groups = {water = 3, liquid = 3, not_in_creative_inventory = 1},
	sounds = AW.Audio.node_sound_water_defaults()
})

--basic blocks
core.register_node("blocks:dirt", {
	description = "Dirt",
	tiles = {"dirt.png"},
	groups = {harvestable_shovel = 1},
	digtime = 5,
	sounds = AW.Audio.node_sound_dirt_defaults()
})
core.register_node("blocks:coarse_dirt",{
	description = "Coarse Dirt",
	tiles = {"coarse_dirt.png"},
	groups = {harvestable_shovel = 1},
	digtime = 5,
	sounds = AW.Audio.node_sound_dirt_defaults(),
	drop = {
		max_items = 1,
		items = {
			{rarity = 10, items = {"blocks:dirt","blocks:pebble"}},
			{items = {"blocks:coarse_dirt"}}
		}
	}
})
core.register_node("blocks:grass_block",{
	description = "Grass Block",
	tiles = {"grass_top.png","dirt.png","grass_side.png"},
	groups = {harvestable_shovel = 1},
	digtime = 6,
	sounds = AW.Audio.node_sound_dirt_defaults()
})

core.register_node("blocks:stone",{
	description = "Stone",
	tiles = {"stone.png"},
	groups = {harvestable_pickaxe = 1},
	sounds = AW.Audio.node_sound_stone_defaults()
})
core.register_node("blocks:sand", {
	description = "Sand",
	tiles = {"altersand.png"},
	groups = {harvestable_shovel = 1},
	digtime = 2,
	sounds = AW.Audio.node_sound_sand_defaults()
})
core.register_node("blocks:gravel", {
	description = "Gravel",
	tiles = {"gravel.png"},
	groups = {harvestable_shovel = 1},
	digtime = 2,
	sounds = AW.Audio.node_sound_gravel_defaults()
})
core.register_node("blocks:sycamore_log",{
	description = "Sycamore Log",
	tiles = {"sycamore_log_top.png","sycamore_log_top.png","sycamore_log.png"},
	groups = {harvestable_axe = 1},
	digtime = 10,
	sounds = AW.Audio.node_sound_wood_defaults()
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

---- Non-solid blocks
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
	},
	sounds = AW.Audio.node_sound_leaves_defaults()
})
core.register_node("blocks:rose",{
		description = "Rose",
	drawtype = "plantlike",
	waving = 1,
	tiles = {"rose.png"},
	digtime = 0,

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
	sounds = AW.Audio.node_sound_leaves_defaults()
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
	sounds = AW.Audio.node_sound_stone_defaults()
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
	sounds = AW.Audio.node_sound_wood_defaults()
})
--valuables
core.register_node("blocks:lignite_ore",{
	description = "Lignite Ore",
	tiles = {"lignite_ore.png"},
	groups = {harvestable_pickaxe = 1},
	drop = {
		max_items = 3,
		items = {
			{rarity = 1, items = {"items:lignite"}},
			{rarity = 2, items = {"items:lignite"}},
			{rarity = 2, items = {"items:lignite"}},
			{rarity = 5, items = {"items:lignite"}},
		}
	},
	sounds = AW.Audio.node_sound_stone_defaults()
})
core.register_node("blocks:lignite_block",{
	description = "Lignite Block",
	tiles = {"lignite_block.png"},
	groups = {harvestable_pickaxe = 1},
	sounds = AW.Audio.node_sound_stone_defaults()
})
--stations
core.register_node("blocks:campfire",{
	description = "Campfire",
	drawtype = "mesh",
	mesh = "campfire.obj",
	tiles = {"campfire_active_texture.png"},
	inventory_image = "campfire_item.png",
    wield_image = "campfire_item.png",
	use_texture_alpha = "blend",
	light_source = 14,
	paramtype = "light",            -- For light propagation if needed
    sunlight_propagates = true,
    groups = {harvestable_hand = 4, harvestable_axe = 1},
	visual_offset = {x=0,y=-1,z=0},
    collision_box = {
		type = "fixed",
		fixed = {-0.5,-0.5,-0.5, 0.5,-0.1,0.5}
	},  -- Adjust to fit the model
    selection_box = {
        type = "fixed",
        fixed = {-0.5,-0.5,-0.5, 0.5,-0.1,0.5},
    },
	drop = {
		max_items = 3,
		items = {
			{rarity=1, items={"items:lignite"}},
			{rarity=2, items={"items:lignite"}},
			{rarity=2, items={"blocks:stick"}},
			{rarity=3, items={"blocks:stick"}},
			{rarity=4, items={"blocks:sycamore_log"}},
		}
	},
	sounds = AW.Audio.node_sound_wood_defaults()
})
core.register_abm({
	label = "Standing damage tick",
	nodenames = {"blocks:campfire"},
	interval = 1,
	chance = 1,
	action = function (pos)
		local objs = minetest.get_objects_inside_radius(pos, 0.5)
		for _, obj in pairs(objs) do
			if obj:get_luaentity() or obj:is_player() then
				if obj:get_hp() and obj:get_hp() > 0 then
					obj:set_hp(obj:get_hp() - 1)
				end
			end
		end
	end
})