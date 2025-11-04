minetest.register_ore({
    ore_type       = "scatter",
    ore            = "blocks:lignite_ore",
    wherein        = {"blocks:stone"},
    clust_scarcity = 12*12*12,
    clust_num_ores = 24,
    clust_size     = 6,
    y_min          = -64,
    y_max          = 31000,
    biomes         = {"all"},
})