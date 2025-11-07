local path = core.get_modpath("blocks").."/definitions/"

dofile(path.."stations.lua")

dofile(path.."liquid_water.lua")

dofile(path.."rock_dirt.lua")
dofile(path.."rock_sand.lua")
dofile(path.."rock_stone.lua")

dofile(path.."wood_sycamore.lua")

dofile(path.."metal_lignite.lua")

dofile(path.."crop_cotton.lua")
dofile(path.."crop_rye.lua")

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
        attached_node = 1,
		nature = 1
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
    groups = {harvestable_hand = 2, misc = 1},
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

-- =========================================================
-- Campfire (blocks:campfire) with custom inventory UI
-- - Permanent inventory = 3x5
-- - 4 single-item input slots + 1 fuel slot
-- - Keeps your mesh, light, drops, ABM, etc.
-- =========================================================

local S = function(s) return s end
local FLAME_TEX = "campfire_flame.png"

-- ---------- UI builder -------------------------------------------------------
local function campfire_formspec(pos)
  local w, h = 16, 10
  local inv_x, inv_y = 0.4, 0.6
  local inv_cols, inv_rows = 3, 5 -- changed to 3x5
  local panel_x, panel_y = 6.2, 0.2
  local inputs_x, inputs_y = panel_x + 1.1, panel_y + 1.6
  local fuel_x,   fuel_y   = panel_x + 3.2, panel_y + 4.1
  local hotbar_x, hotbar_y = 2.0, 8.2

  return table.concat({
    "formspec_version[6]",
    ("size[%f,%f]"):format(w, h),

    ("box[%f,%f;3.6,8.0;#4a2e0eff]"):format(inv_x-0.1, inv_y-0.3),       -- left panel now narrower
    ("box[%f,%f;8.6,7.6;#696969ff]"):format(panel_x-0.2, panel_y+0.1),   -- right panel

    ("label[%f,%f;%s]"):format(inv_x, inv_y-0.45, minetest.formspec_escape("Permanent inventory")),
    ("label[%f,%f;%s]"):format(panel_x, panel_y, minetest.formspec_escape("Campfire")),

    -- player inventory slice (3x5)
    ("list[current_player;main;%f,%f;%d,%d;8]"):format(inv_x, inv_y, inv_cols, inv_rows),

    ("label[%f,%f;%s]"):format(panel_x+0.6, panel_y+1.0,
      minetest.formspec_escape("Input slots (1 item per slot)")),
    ("list[context;input;%f,%f;4,1;0]"):format(inputs_x, inputs_y),

    ("image[%f,%f;1.0,1.0;%s]"):format(fuel_x-0.1, fuel_y-1.1, FLAME_TEX),
    ("label[%f,%f;%s]"):format(panel_x+0.6, panel_y+3.3, minetest.formspec_escape("Fuel")),
    ("list[context;fuel;%f,%f;1,1;0]"):format(fuel_x, fuel_y),

    ("label[%f,%f;%s]"):format(hotbar_x, hotbar_y-0.55, minetest.formspec_escape("Hotbar")),
    ("list[current_player;main;%f,%f;8,1;0]"):format(hotbar_x, hotbar_y),

    "listring[context;input]",
    "listring[current_player;main]",
    "listring[context;fuel]",
    "listring[current_player;main]",

    "bgcolor[#00000000]"
  })
end

-- Enforce single item per input slot
local function allow_put_input(pos, listname, index, stack)
  local inv  = minetest.get_meta(pos):get_inventory()
  local cur  = inv:get_stack(listname, index)
  if not cur:is_empty() then return 0 end
  return 1
end

-- ---------- Node -------------------------------------------------------------

core.register_node("blocks:campfire", {
  description = "Campfire",
  drawtype = "mesh",
  mesh = "campfire.obj",
  tiles = {"campfire_active_texture.png"},
  inventory_image = "campfire_item.png",
  wield_image = "campfire_item.png",
  use_texture_alpha = "blend",
  light_source = 14,
  paramtype = "light",
  sunlight_propagates = true,
  groups = {harvestable_hand = 4, harvestable_axe = 1},
  visual_offset = {x=0,y=-1,z=0},
  collision_box = { type = "fixed", fixed = {-0.5,-0.5,-0.5, 0.5,-0.1,0.5} },
  selection_box = { type = "fixed", fixed = {-0.5,-0.5,-0.5, 0.5,-0.1,0.5} },
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
  sounds = AW and AW.Audio and AW.Audio.node_sound_wood_defaults() or nil,

  on_construct = function(pos)
    local meta = minetest.get_meta(pos)
    local inv  = meta:get_inventory()
    inv:set_size("input", 4)
    inv:set_size("fuel", 1)
    meta:set_string("infotext", S("Campfire"))
    meta:set_string("formspec", campfire_formspec(pos))
  end,

  on_metadata_inventory_move = function(pos)
    minetest.get_meta(pos):set_string("formspec", campfire_formspec(pos))
  end,
  on_metadata_inventory_put = function(pos)
    minetest.get_meta(pos):set_string("formspec", campfire_formspec(pos))
  end,
  on_metadata_inventory_take = function(pos)
    minetest.get_meta(pos):set_string("formspec", campfire_formspec(pos))
  end,

  allow_metadata_inventory_put = function(pos, listname, index, stack, player)
    if listname == "input" then
      return allow_put_input(pos, listname, index, stack)
    elseif listname == "fuel" then
      return stack:get_count()
    end
    return 0
  end,

  allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
    local inv = minetest.get_meta(pos):get_inventory()
    if to_list == "input" then
      local cur = inv:get_stack(to_list, to_index)
      if not cur:is_empty() then return 0 end
      return math.min(count, 1)
    end
    return count
  end,
})

-- Refresh old nodes if layout changes
minetest.register_lbm({
  name = "blocks:campfire_refresh_formspec",
  nodenames = {"blocks:campfire"},
  run_at_every_load = true,
  action = function(pos)
    minetest.get_meta(pos):set_string("formspec", campfire_formspec(pos))
  end
})

-- Standing damage ABM
core.register_abm({
  label = "Standing damage tick",
  nodenames = {"blocks:campfire"},
  interval = 1,
  chance = 1,
  action = function (pos)
    local objs = minetest.get_objects_inside_radius(pos, 0.5)
    for _, obj in pairs(objs) do
      if obj:get_luaentity() or obj:is_player() then
        if obj.get_hp and obj:get_hp() and obj:get_hp() > 0 then
          obj:set_hp(obj:get_hp() - 1)
        end
      end
    end
  end
})

dofile(path.."plants_sycamoreforest.lua")
