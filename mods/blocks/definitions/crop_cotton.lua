core.register_node("blocks:cotton_plant",{
	description = "Cotton Plant",
	drawtype = "plantlike",
	waving = 1,
	tiles = {"cotton.png"},
	digtime = 0,

	paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    buildable_to = true,
    floodable = true,

	groups = {
		harvestable_hand = 3,
        flammable = 2,
        attached_node = 1
    },

	drop = {
		max_items = 5,
		items = {
			{rarity = 1, items = {"items:cotton"}},
			{rarity = 2, items = {"items:cotton"}},
			{rarity = 4, items = {"items:cotton"}},
			{rarity = 1.5, items = {"items:cotton_seeds"}},
			{rarity = 2, items = {"items:cotton_seeds"}},
		}
	},

    selection_box = {
        type = "fixed",
        fixed = {-0.3, -0.5, -0.3, 0.3, 0.3, 0.3}
    },
	sounds = AW.Audio.node_sound_leaves_defaults()
})