minetest.register_biome({
    name = "ocean",
    -- Surface layer (beach / ocean floor)
    node_top = "blocks:sand",       -- top block at sea floor
    depth_top = 3,                   -- thickness of top layer
    node_filler = "blocks:dirt", -- layer below top
    depth_filler = 3,

    -- Water nodes
    node_water_top = "blocks:water_source",  -- surface water
    depth_water_top = 10,                   -- thickness of water layer
    node_river_water = "blocks:water_source",-- river water if rivers cross ocean

    -- Height range
    y_min = -31000,  -- ocean bottom
    y_max = 2,       -- sea level

    -- Climate settings (heat/humidity)
    heat_point = 50,
    humidity_point = 70,
})