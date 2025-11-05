-- aw_ui/init.lua — full build with image+color fallback and per-area slot sizing

local MODNAME = minetest.get_current_modname()
local MODPATH = minetest.get_modpath(MODNAME)
local FS_VER  = 6

------------------------------------------------------------------
-- THEME / TEXTURES (optional)
------------------------------------------------------------------
local function file_exists(rel)
  local f = io.open(MODPATH .. "/textures/" .. rel, "rb")
  if f then f:close(); return true end
  return false
end

-- 9-slice panel textures (optional)
local TEX = {
  left_panel   = "aw_ui_left_panel.png",
  right_panel  = "aw_ui_right_panel.png",
  hotbar_panel = "aw_ui_hotbar_panel.png",
  slot         = "aw_ui_slot.png",        -- optional slot frame
  slot_hover   = "aw_ui_slot_hover.png",  -- optional hovered frame
}
local HAS = {
  left   = file_exists(TEX.left_panel),
  right  = file_exists(TEX.right_panel),
  hotbar = file_exists(TEX.hotbar_panel),
  slot   = file_exists(TEX.slot),
  slot_h = file_exists(TEX.slot_hover),
}

-- 9-slice panel border in pixels of the PNG (adjust to your art)
local PANEL_BORDER = 16

-- Slot skin "middle" rect (PNG pixels). Tweak once to match your slot frame art.
local SLOT_MID_X = 4
local SLOT_MID_Y = 4
local SLOT_MID_W = 12
local SLOT_MID_H = 12

-- Draw solid color first, then optional 9-slice image (no fullscreen stretch)
local function panel_bg(x, y, w, h, which, color_hex)
  local fs = { ("box[%.2f,%.2f;%.2f,%.2f;%s]"):format(x, y, w, h, color_hex) }
  if which == "left" and HAS.left then
    fs[#fs+1] = ("background9[%.2f,%.2f;%.2f,%.2f;%s;false;%d]")
      :format(x, y, w, h, TEX.left_panel, PANEL_BORDER)
  elseif which == "right" and HAS.right then
    fs[#fs+1] = ("background9[%.2f,%.2f;%.2f,%.2f;%s;false;%d]")
      :format(x, y, w, h, TEX.right_panel, PANEL_BORDER)
  elseif which == "hotbar" and HAS.hotbar then
    fs[#fs+1] = ("background9[%.2f,%.2f;%.2f,%.2f;%s;false;%d]")
      :format(x, y, w, h, TEX.hotbar_panel, PANEL_BORDER)
  end
  return table.concat(fs)
end

-- Slot skin style (or listcolors fallback). Call once per formspec.
local function slot_style_chunk()
  if HAS.slot then
    local mid = ("%d,%d,%d,%d"):format(SLOT_MID_X, SLOT_MID_Y, SLOT_MID_W, SLOT_MID_H)
    local t = {
      ("style_type[list;bgimg=%s;bgimg_middle=%s]"):format(TEX.slot, mid)
    }
    if HAS.slot_h then
      t[#t+1] = ("style_type[list;bgimg_hovered=%s;bgimg_middle=%s]"):format(TEX.slot_hover, mid)
    end
    return table.concat(t)
  else
    -- Transparent slot bg with subtle selection/hover colors
    return "listcolors[#00000000;#55555566;#FFFFFF22;#888888CC;#FFFFFF]"
  end
end

------------------------------------------------------------------
-- LAYOUT tuned to your mockup (slightly larger) + raised hotbar
------------------------------------------------------------------
local SIZE_W, SIZE_H   = 14.2, 9.4
local SLOT_SPACING     = 0.25

-- LEFT panel (3x5 style)
local LEFT_X, LEFT_Y, LEFT_W, LEFT_H = 0.36, 0.38, 4.40, 7
local LEFT_COLS, LEFT_ROWS = 3, 5
local LEFT_START_ZEROBASED = 9

-- RIGHT context panel
local CTX_X, CTX_Y, CTX_W, CTX_H = 5, 0.38, 8.30, 7   -- X closer, W a touch wider

-- HOTBAR (background moved down a bit and made skinnier; slots auto-centered)
-- (The following X/Y/W/H are *defaults*; the helpers below will compute final values)
local HOTBAR_BG_X, HOTBAR_BG_Y, HOTBAR_BG_W, HOTBAR_BG_H = 0.36, 7.60, 12.5, 5
local HOTBAR_X, HOTBAR_Y = 0.90, 9

-- Search stays at top; its width recalculates from CTX_W automatically
local SEARCH_Y = CTX_Y + 0.40
local SEARCH_X = CTX_X + 0.35
local SEARCH_W = CTX_W - (SEARCH_X - CTX_X) - 2.80

-- Tabs (text)
local TABS_X, TABS_Y = CTX_X + 0.35, SEARCH_Y + 0.85
local TAB_W, TAB_H, TAB_PAD = 1.55, 0.80, 0.42

-- Creative grid: keep 7×5 but enlarge each item button a bit
local CRE_COLS, CRE_ROWS = 7, 5
local CRE_SLOTS_PER_PAGE = CRE_COLS * CRE_ROWS
local CRE_CELL_W, CRE_CELL_H = 0.96, 0.96
local CRE_GRID_X, CRE_GRID_Y = CTX_X + 0.35, TABS_Y + 0.85
-- padding between creative slots
local CRE_PAD = 0.08   -- try 0.04–0.10 depending on your look

-- Pager
local PAGEX, PAGEY = CTX_X + 0.35, CTX_Y + CTX_H - 1.05

------------------------------------------------------------------
-- PER-AREA SLOT SIZES  (adjust these to fit over your background art)
------------------------------------------------------------------
local SLOT_SIZE_LEFT   = 1.06  -- Left panel slots
local SLOT_SIZE_HOTBAR = 1.00  -- Hotbar slots
local SLOT_SIZE_CRAFT  = 1.00  -- Craft grid + preview

------------------------------------------------------------------
-- HOTBAR AUTO-GEOMETRY HELPERS (define BEFORE base())
------------------------------------------------------------------
-- Separate hotbar background margins
local HOTBAR_MARGIN_LEFT  = 0.36   -- keep this (you like it)
local HOTBAR_MARGIN_RIGHT = 0.80   -- adjust this one to taste
local HOTBAR_BAR_HEIGHT   = 1.5
local HOTBAR_BAR_GAP      = 0.10

local function calc_hotbar_box()
  local top = math.max(LEFT_Y + LEFT_H, CTX_Y + CTX_H)
  local x   = HOTBAR_MARGIN_LEFT
  local w   = SIZE_W - HOTBAR_MARGIN_LEFT - HOTBAR_MARGIN_RIGHT
  local y   = top + HOTBAR_BAR_GAP
  local h   = HOTBAR_BAR_HEIGHT
  return x, y, w, h
end

local function calc_hotbar_slots()
  local bgx, bgy, bgw, bgh = calc_hotbar_box()
  local total_w = 9 * SLOT_SIZE_HOTBAR + (9 - 1) * SLOT_SPACING
  local x = bgx + (bgw - total_w) / 2
  local y = bgy + (bgh - SLOT_SIZE_HOTBAR) / 2
  return x, y
end

------------------------------------------------------------------
-- STATE
------------------------------------------------------------------
local PAGES, SEARCH_TXT, ACTIVE_TAB, PAGE_CACHE, ALL_LIST = {}, {}, {}, {}, nil
local AW_CATEGORY = {}
local DET_TRASH_NAME = {}

aw_ui = rawget(_G, "aw_ui") or {}
function aw_ui.set_category(item, cat)
  if cat == "blocks" or cat == "nature" or cat == "misc" then
    AW_CATEGORY[item] = cat
  end
end

local function is_creative(name)
  return minetest.is_creative_enabled and minetest.is_creative_enabled(name)
end

------------------------------------------------------------------
-- CATALOG / FILTER
------------------------------------------------------------------
local function should_hide(def)
  if not def then return true end
  if (def.description or "") == "" then return true end
  return (def.groups and def.groups.not_in_creative_inventory) == 1
end

local function build_all()
  if ALL_LIST then return end
  ALL_LIST = {}
  for name, def in pairs(minetest.registered_items) do
    if name ~= "" and not should_hide(def) then ALL_LIST[#ALL_LIST+1] = name end
  end
  table.sort(ALL_LIST)
end

local function category_for(item, def)
  if AW_CATEGORY[item] then return AW_CATEGORY[item] end
  local g = (def and def.groups) or {}
  if def and def.type == "node" then return "blocks" end
  if g.flora==1 or g.tree==1 or g.leaves==1 or g.grass==1 or g.plant==1 then return "nature" end
  return "misc"
end

local function filtered(tab, query)
  build_all()
  local q = (query or ""):lower()
  local out = {}
  for _, item in ipairs(ALL_LIST) do
    local def = minetest.registered_items[item]
    if tab == "all" or category_for(item, def) == tab then
      if q=="" or item:lower():find(q,1,true) or (def.description or ""):lower():find(q,1,true) then
        out[#out+1] = item
      end
    end
  end
  return out
end

local function compute_page(name)
  local list = filtered(ACTIVE_TAB[name] or "all", SEARCH_TXT[name] or "")
  local page = PAGES[name] or 0
  local maxp = math.max(0, math.ceil(#list / CRE_SLOTS_PER_PAGE) - 1)
  if page > maxp then page = maxp; PAGES[name] = page end

  local start = page * CRE_SLOTS_PER_PAGE + 1
  local page_items = {}
  for i=0, CRE_SLOTS_PER_PAGE-1 do
    local idx = start + i
    if list[idx] then page_items[#page_items+1] = list[idx] end
  end
  PAGE_CACHE[name] = page_items
  return page_items, page, maxp, #list
end

------------------------------------------------------------------
-- HIDDEN TRASH
------------------------------------------------------------------
local function ensure_trash(player)
  local pname = player:get_player_name()
  local det = "aw_ui:trash:" .. pname
  DET_TRASH_NAME[pname] = det

  if not minetest.get_inventory({type="detached", name=det}) then
    minetest.create_detached_inventory(det, {
      allow_put = function(_,_,_,s) return s:get_count() end,
      on_put    = function(inv,l,i) inv:set_stack(l,i,"") end,
      allow_move= function() return 0 end,
      allow_take= function() return 0 end,
    })
  end
  local inv = minetest.get_inventory({type="detached", name=det})
  inv:set_size("main", 1)
  inv:set_stack("main", 1, "")
end

------------------------------------------------------------------
-- GIVE HELPERS
------------------------------------------------------------------
local function add_to_hotbar_first(player, stack)
  local inv = player:get_inventory()
  for i = 1, 9 do
    local slot = inv:get_stack("main", i)
    if slot:is_empty() then inv:set_stack("main", i, stack) return end
    if slot:get_name() == stack:get_name() then
      local leftover = slot:add_item(stack)
      inv:set_stack("main", i, slot)
      if leftover:is_empty() then return else stack = leftover end
    end
  end
  inv:add_item("main", stack)
end

local function give(player, item, count)
  local max = (minetest.registered_items[item].stack_max or 99)
  if count > max then count = max end
  add_to_hotbar_first(player, ItemStack(item .. " " .. count))
end

------------------------------------------------------------------
-- SURVIVAL CONTEXT (2x2 crafting, output centered)
------------------------------------------------------------------
local function survival(player)
  local cx, cy = CTX_X + 1.0, CTX_Y + 1.7
  local ax, ay = cx + 2.7, cy + 0.90
  local ox, oy = ax + 0.25, cy + 0.45

  return table.concat({
    panel_bg(CTX_X, CTX_Y, CTX_W, CTX_H, "right", "#777777DD"),

    ("label[%.2f,%.2f;Crafting]"):format(CTX_X + 0.45, CTX_Y + 0.48),
    ("style_type[list;size=%f,%f]"):format(SLOT_SIZE_CRAFT, SLOT_SIZE_CRAFT),
    ("list[current_player;craft;%.2f,%.2f;2,2;0]"):format(cx, cy),
    ("label[%.2f,%.2f;→]"):format(ax, ay),
    ("list[current_player;craftpreview;%.2f,%.2f;1,1;0]"):format(ox, oy),

    "listring[current_player;main]",
    "listring[current_player;craft]",
    "listring[current_player;main]",
  })
end

------------------------------------------------------------------
-- CAMPFIRE CONTEXT (4x1 smelting, fuel slot)
------------------------------------------------------------------

local function campfire(player)
  local CTX_X, CTX_Y, CTX_W, CTX_H = 5, 0.38, 8.30, 7   -- X closer, W a touch wider
  local cx, cy = CTX_X + 1.0, CTX_Y + 1.7
  local ax, ay = cx + 1.2, cy + 0.90
  local ox, oy = cx + 1, cy + 2

  return table.concat({
    panel_bg(CTX_X, CTX_Y, CTX_W, CTX_H, "right", "#777777DD"),

    ("label[%.2f,%.2f;Cooking]"):format(CTX_X + 0.45, CTX_Y + 0.48),
    ("style_type[list;size=%f,%f]"):format(SLOT_SIZE_CRAFT, SLOT_SIZE_CRAFT),
    ("list[current_player;craft;%.2f,%.2f;4,1;0]"):format(cx, cy),
    ("label[%.2f,%.2f;🔥]"):format(ax, ay),
    ("list[current_player;craftpreview;%.2f,%.2f;1,1;0]"):format(ox, oy),

    "listring[current_player;main]",
    "listring[current_player;craft]",
    "listring[current_player;main]",
  })
end

------------------------------------------------------------------
-- CREATIVE CONTEXT (text tabs, search top, 7x5)
------------------------------------------------------------------
local function creative(player)
  local name = player:get_player_name()
  ensure_trash(player)
  local items, page, maxp, total = compute_page(name)
  local tab = ACTIVE_TAB[name] or "all"

  local fs = {
    panel_bg(CTX_X, CTX_Y, CTX_W, CTX_H, "right", "#777777DD"),
    ("label[%.2f,%.2f;Creative Inventory]"):format(CTX_X + 0.45, CTX_Y + 0.20),

    ("field[%.2f,%.2f;%.2f,0.65;aw_srch;;%s]")
      :format(SEARCH_X, SEARCH_Y, SEARCH_W, minetest.formspec_escape(SEARCH_TXT[name] or "")),
    "field_close_on_enter[aw_srch;true]",
    ("button[%.2f,%.2f;1.0,0.65;aw_srch_go;Go]"):format(SEARCH_X + SEARCH_W + 0.18, SEARCH_Y),
  }

  -- Tabs (text)
  local tx = TABS_X
  local function tab_btn(id, label, active)
    local style = active and "#6666FFFF" or "#444444CC"
    fs[#fs+1] = ("style[%s;bgcolor=%s]"):format(id, style)
    fs[#fs+1] = ("button[%.2f,%.2f;%.2f,%.2f;%s;%s]"):format(tx, TABS_Y, TAB_W, TAB_H, id, label)
    tx = tx + TAB_W + TAB_PAD
  end
  tab_btn("aw_tb_all",   "All",    tab == "all")
  tab_btn("aw_tb_blocks","Blocks", tab == "blocks")
  tab_btn("aw_tb_nat",   "Nature", tab == "nature")
  tab_btn("aw_tb_misc",  "Misc",   tab == "misc")

  -- Grid (item buttons)
  local col, row = 0, 0
  for i, item in ipairs(items) do
    local x = CRE_GRID_X + col*(CRE_CELL_W + CRE_PAD)
    local y = CRE_GRID_Y + row*(CRE_CELL_H + CRE_PAD)
    fs[#fs+1] = ("item_image_button[%.2f,%.2f;%.2f,%.2f;%s;aw_g_%d;]")
      :format(x, y, CRE_CELL_W, CRE_CELL_H, item, i)
    col = col + 1
    if col >= CRE_COLS then col = 0; row = row + 1; if row >= CRE_ROWS then break end end
  end

  -- Pager
  fs[#fs+1] = ("button[%.2f,%.2f;0.9,0.65;aw_prev;«]"):format(PAGEX, PAGEY)
  fs[#fs+1] = ("button[%.2f,%.2f;0.9,0.65;aw_next;»]"):format(PAGEX + 1.35, PAGEY)
  fs[#fs+1] = ("label[%.2f,%.2f;Page %d / %d  (%d items)]")
    :format(PAGEX + 2.9, PAGEY + 0.12, page + 1, math.max(1, maxp + 1), total)

  if page <= 0 then fs[#fs+1] = "style[aw_prev;disabled=true]" end
  if page >= maxp then fs[#fs+1] = "style[aw_next;disabled=true]" end

  -- Hidden trash slot + listring
  fs[#fs+1] = ("list[detached:%s;main;-100,-100;1,1;0]"):format(DET_TRASH_NAME[name])
  fs[#fs+1] = "listring[current_player;main]"
  fs[#fs+1] = ("listring[detached:%s;main]"):format(DET_TRASH_NAME[name])
  fs[#fs+1] = "listring[current_player;main]"

  return table.concat(fs)
end

------------------------------------------------------------------
-- BASE FORMSPEC (left panel + hotbar, each with its own slot size)
------------------------------------------------------------------
local function base()
  return table.concat({
    ("formspec_version[%d]size[%.2f,%.2f]"):format(FS_VER, SIZE_W, SIZE_H),

    -- global spacing, then LEFT size
    ("style_type[list;spacing=%.2f]"):format(SLOT_SPACING),
    ("style_type[list;size=%f,%f]"):format(SLOT_SIZE_LEFT, SLOT_SIZE_LEFT),

    panel_bg(LEFT_X, LEFT_Y, LEFT_W, LEFT_H, "left", "#4D2B00DD"),
    slot_style_chunk(),

    -- LEFT panel list
    ("list[current_player;main;%.2f,%.2f;%d,%d;%d]")
      :format(LEFT_X + 0.35, LEFT_Y + 0.35, LEFT_COLS, LEFT_ROWS, LEFT_START_ZEROBASED),

    -- switch to HOTBAR slot size
    ("style_type[list;size=%f,%f]"):format(SLOT_SIZE_HOTBAR, SLOT_SIZE_HOTBAR),

    -- HOTBAR (auto geometry)
    (function()
      local bgx, bgy, bgw, bgh = calc_hotbar_box()
      local hx, hy = calc_hotbar_slots()
      return table.concat({
        panel_bg(bgx, bgy, bgw, bgh, "hotbar", "#222222BB"),
        ("list[current_player;main;%.2f,%.2f;9,1;0]"):format(hx, hy),
      })
    end)(),

    "bgcolor[#00000000]",
  })
end

function aw_ui.formspec(player, ct)
  	local n   = player:get_player_name()
	local inv = player:get_inventory()
	if inv:get_size("main") < 32 then inv:set_size("main", 32) end

	inv:set_size("craft", 4) -- 2×2 = 4
	inv:set_width("craft", 2) -- IMPORTANT for shaped 2×2 recipes

	inv:set_size("craftpreview", 1)

  	local fs = { base() }
	if ct == "campfire" then
		fs[#fs+1] = campfire(player)
	elseif is_creative(n) then
    	fs[#fs+1] = creative(player)
  	else
    	fs[#fs+1] = survival(player)
  	end
  	return table.concat(fs)
end

local function apply_formspec(p) p:set_inventory_formspec(aw_ui.formspec(p)) end

------------------------------------------------------------------
-- LIFECYCLE
------------------------------------------------------------------
minetest.register_on_joinplayer(function(p)
  local n = p:get_player_name()
  PAGES[n], SEARCH_TXT[n], ACTIVE_TAB[n], PAGE_CACHE[n] = 0, "", "all", {}
  ensure_trash(p)
  apply_formspec(p)
end)

minetest.register_on_respawnplayer(function(p)
  minetest.after(0, apply_formspec, p)
end)

minetest.register_chatcommand("awinv", { func = function(n)
  local p = minetest.get_player_by_name(n)
  if p then minetest.show_formspec(n, "aw_ui", aw_ui.formspec(p)) end
end })

------------------------------------------------------------------
-- EVENTS
------------------------------------------------------------------
minetest.register_on_player_receive_fields(function(player, formname, fields)
  local n = player:get_player_name()

  -- Tabs
  if fields.aw_tb_all or fields.aw_tb_blocks or fields.aw_tb_nat or fields.aw_tb_misc then
    if fields.aw_tb_all    then ACTIVE_TAB[n] = "all"
    elseif fields.aw_tb_blocks then ACTIVE_TAB[n] = "blocks"
    elseif fields.aw_tb_nat then ACTIVE_TAB[n] = "nature"
    elseif fields.aw_tb_misc then ACTIVE_TAB[n] = "misc" end
    PAGES[n] = 0
    apply_formspec(player) return
  end

  -- Search
  if (fields.aw_srch_go and fields.aw_srch)
    or (fields.key_enter_field == "aw_srch" and fields.aw_srch) then
    SEARCH_TXT[n] = fields.aw_srch
    PAGES[n] = 0
    apply_formspec(player) return
  end

  -- Paging
  if fields.aw_prev then
    PAGES[n] = math.max(0, (PAGES[n] or 0) - 1)
    apply_formspec(player) return
  elseif fields.aw_next then
    PAGES[n] = (PAGES[n] or 0) + 1
    apply_formspec(player) return
  end

  -- Creative give buttons: click=1, Shift=stack
  compute_page(n) -- refresh PAGE_CACHE
  for i = 1, CRE_SLOTS_PER_PAGE do
    local key = "aw_g_" .. i
    if fields[key] then
      local chosen = PAGE_CACHE[n][i]
      if chosen then
        local def = minetest.registered_items[chosen] or {}
        local full = def.stack_max or 99
        local is_shift = (fields.key_shift == true) or (fields.key_shift == "true")
        give(player, chosen, is_shift and full or 1)
      end
      return
    end
  end
end)
