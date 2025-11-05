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

	on_construct = function(pos)
        local timer = minetest.get_node_timer(pos)
        timer:start(0.5) -- every 1 second
    end,

    -- Keep timer running even if the map block reloads
    on_timer = function(pos, elapsed)
        -- Apply damage
        local objs = minetest.get_objects_inside_radius(pos, 1)
        for _, obj in ipairs(objs) do
            if obj:is_player() or obj:get_luaentity() then
                local hp = obj:get_hp()
                if hp and hp > 0 then
                    obj:set_hp(hp - 1)
                end
            end
        end

        -- Continue looping
        return true
    end,

	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local formspec = aw_ui.formspec(clicker,"campfire")
		core.show_formspec(clicker:get_player_name(), "blocks:campfire", formspec)
	end,

	sounds = AW.Audio.node_sound_wood_defaults()
})