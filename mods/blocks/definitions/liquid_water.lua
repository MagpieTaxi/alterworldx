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