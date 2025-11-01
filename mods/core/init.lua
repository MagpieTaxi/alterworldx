--hand
core.register_item(":",{
	type = "none",
    wield_image = "hand.png",
    wield_scale = {x=1.5, y=1.5, z=0.1}, -- optional
    range = 4.0,                     -- default reach distance
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level = 3,
        groupcaps = {
            harvestable_hand = {times={[1]=0.0,[2]=0.6,[3]=1.5}, uses=0, maxlevel=3}
        },
        damage_groups = {},
    },
})

--guis
