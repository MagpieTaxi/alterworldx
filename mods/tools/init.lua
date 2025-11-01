core.register_tool("tools:rudimentary_mattock",{
	description = "Rudimentary Mattock",
	inventory_image = "rudimentary_mattock.png",
    wield_image = "rudimentary_mattock.png",
    range = 4.0,                     -- default reach distance
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level = 1,
        groupcaps = {
            harvestable_pickaxe = {times={[1]=1.0,[2]=5.0,[3]=8.0,[4]=12.0}, uses=48, maxlevel=1},
            harvestable_axe = {times={[1]=1.0,[2]=5.0,[3]=8.0,[4]=12.0}, uses=48, maxlevel=1},
			harvestable_shovel = {times={[1]=1.0,[2]=2.0,[3]=5.0,[4]=12.0},uses=48,maxlevel=1}
        },
        damage_groups = {harvestable_pickaxe = 1,harvestable_axe = 1},
    },
})