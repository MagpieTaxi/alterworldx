-- recipes/init.lua (Luanti / core.*)
-- 2x2 crafting helper (works in inventory 2x2 and in any corner of 3x3),
-- including all rotations & mirrors. Plus your mattock recipe and diagnostics.

----------------------------
-- 2x2 any-corner helper --
----------------------------
local function _copy(m) return {{m[1][1],m[1][2]},{m[2][1],m[2][2]}} end
local function _rot90(m) return {{m[2][1],m[1][1]},{m[2][2],m[1][2]}} end
local function _rot180(m) return _rot90(_rot90(m)) end
local function _rot270(m) return _rot90(_rot180(m)) end
local function _flip_h(m) return {{m[1][2],m[1][1]},{m[2][2],m[2][1]}} end
local function _flip_v(m) return {{m[2][1],m[2][2]},{m[1][1],m[1][2]}} end
local function _key(m) return table.concat({
  m[1][1] or "", "|", m[1][2] or "", "|", m[2][1] or "", "|", m[2][2] or ""
}) end

local function _reg_corner(out, m)
  -- Inventory 2x2 / 3x3 top-left
  core.register_craft({ output = out, recipe = {
    {m[1][1], m[1][2]},
    {m[2][1], m[2][2]},
  }})
  -- 3x3 top-right
  core.register_craft({ output = out, recipe = {
    {"", m[1][1], m[1][2]},
    {"", m[2][1], m[2][2]},
  }})
  -- 3x3 bottom-left
  core.register_craft({ output = out, recipe = {
    {"", "", ""},
    {m[1][1], m[1][2], ""},
    {m[2][1], m[2][2], ""},
  }})
  -- 3x3 bottom-right
  core.register_craft({ output = out, recipe = {
    {"", "", ""},
    {"", m[1][1], m[1][2]},
    {"", m[2][1], m[2][2]},
  }})
end

function register_2x2_any_corner_any_orientation(output, m)
  local seen, variants = {}, {
    _copy(m), _rot90(m), _rot180(m), _rot270(m),
    _flip_h(m), _flip_v(m),
    _flip_h(_rot90(m)), _flip_v(_rot90(m)),
  }
  for _, v in ipairs(variants) do
    local k = _key(v)
    if not seen[k] then
      seen[k] = true
      _reg_corner(output, v)
    end
  end
end

----------------------------
-- Your 2x2 mattock recipe
----------------------------
-- Pattern:
-- Pebble Pebble
-- Stick PlantFiber
register_2x2_any_corner_any_orientation("tools:rudimentary_mattock", {
  {"blocks:pebble", "blocks:pebble"},
  {"blocks:stick", "items:plant_fiber"},
})

-------------------------------------------------
-- (Optional) Temporary shapeless fallback
-- Uncomment ONLY for testing if needed, then remove.
-- core.register_craft({
-- type = "shapeless",
-- output = "tools:rudimentary_mattock",
-- recipe = {"blocks:pebble","blocks:pebble","blocks:stick","items:plant_fiber"}
-- })
-------------------------------------------------

----------------------------
-- Debug chat commands
----------------------------
-- /aw_craft_diag → confirm your inventory craft list is 2x2 (size=4 width=2)
core.register_chatcommand("aw_craft_diag", {
  description = "Show craft list size/width",
  func = function(name)
    local p = core.get_player_by_name(name); if not p then return end
    local inv = p:get_inventory()
    return true, ("craft size=%d width=%d (expect 4 & 2)")
      :format(inv:get_size("craft"), inv:get_width("craft"))
  end
})

-- /aw_ids_ok → verify item IDs exist
core.register_chatcommand("aw_ids_ok", {
  description = "Check mattock recipe IDs",
  func = function(name)
    local ids = {
      "blocks:pebble",
      "blocks:stick",
      "items:plant_fiber",
      "tools:rudimentary_mattock",
    }
    local t = {}
    for _, id in ipairs(ids) do
      t[#t+1] = ("%s:%s"):format(id, core.registered_items[id] and "OK" or "MISSING")
    end
    return true, table.concat(t, " | ")
  end
})

-- /aw_result → what would your current craft grid output?
core.register_chatcommand("aw_result", {
  description = "Show current craft grid result",
  func = function(name)
    local p = core.get_player_by_name(name); if not p then return end
    local inv = p:get_inventory()
    local input = { method="normal", width=inv:get_width("craft"), items={} }
    local list = inv:get_list("craft") or {}
    for i=1,#list do input.items[i] = list[i] end
    local res = core.get_craft_result(input)
    local out = res and res.item
    local msg = (out and not out:is_empty()) and (out:get_name().." "..out:get_count()) or "<none>"
    return true, "craft result = "..msg
  end
})