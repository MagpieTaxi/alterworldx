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