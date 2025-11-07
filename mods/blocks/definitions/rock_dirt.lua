core.register_node("blocks:dirt", {
	description = "Dirt",
	tiles = {"dirt.png"},
	groups = {harvestable_shovel = 1},
	digtime = 5,
	sounds = AW.Audio.node_sound_dirt_defaults(),

	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		if clicker:is_player() and itemstack:get_name() == "tools:rudimentary_mattock" then
			core.set_node(pos, {name = "blocks:tilled_dirt"})
		else
			core.item_place_node(itemstack, clicker, pointed_thing)
		end
	end
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
core.register_node("blocks:tilled_dirt",{
	description = "Tilled Dirt",
	tiles = {"tilled_dirt.png","dirt.png","dirt.png"},
	groups = {harvestable_shovel = 1},
	digtime = 6,
	sounds = AW.Audio.node_sound_dirt_defaults(),
	drop = "blocks:dirt"
})
core.register_node("blocks:grass_block",{
	description = "Grass Block",
	tiles = {"grass_top.png","dirt.png","grass_side.png"},
	groups = {harvestable_shovel = 1},
	digtime = 6,
	sounds = AW.Audio.node_sound_dirt_defaults(),
	drop = "blocks:dirt",

	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		if clicker:is_player() and itemstack:get_name() == "tools:rudimentary_mattock" then
			core.set_node(pos, {name = "blocks:tilled_dirt"})
		else
			core.item_place_node(itemstack, clicker, pointed_thing)
		end
	end
})
core.register_node("blocks:gravel", {
	description = "Gravel",
	tiles = {"gravel.png"},
	groups = {harvestable_shovel = 1},
	digtime = 2,
	sounds = AW.Audio.node_sound_gravel_defaults()
})