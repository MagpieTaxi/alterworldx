-- aw_ui/init.lua — compact text-tab build
-- Creative: Search top (no label) + smaller text tabs + 7×5 compact item buttons
-- Click = 1, Shift-click = full stack, hidden trash slot off-screen (listring wired)
-- Survival: 2×2 crafting with centered output

local FS_VER = 6

-- ---------- Layout (compacted) ----------
local SIZE_W, SIZE_H   = 13.4, 9.6
local SLOT_SPACING     = 0.10   -- tighter list spacing

-- Left inventory panel
local LEFT_X, LEFT_Y, LEFT_W, LEFT_H = 0.3, 0.5, 5.0, 7.7
local LEFT_COLS, LEFT_ROWS = 4, 5
local LEFT_START_ZEROBASED = 9

-- Right context (kept wide so nothing overhangs)
local CTX_X, CTX_Y, CTX_W, CTX_H = 5.7, 0.5, 8.3, 7.7

-- Hotbar inside window
local HOTBAR_BG_X, HOTBAR_BG_Y, HOTBAR_BG_W, HOTBAR_BG_H = 0.6, 8.05, 12.0, 1.25
local HOTBAR_X, HOTBAR_Y = 1.7, 8.35

-- Search (top, no label) — nudged left & a touch shorter
local SEARCH_Y = CTX_Y + 0.38
local SEARCH_X = CTX_X + 0.35
local SEARCH_W = CTX_W - (SEARCH_X - CTX_X) - 2.3

-- Tabs (smaller & closer)
local TABS_X, TABS_Y = CTX_X + 0.35, SEARCH_Y + 0.85
local TAB_W, TAB_H, TAB_PAD = 1.55, 0.80, 0.22

-- Creative grid (7×5) — smaller cells, tighter placement
local CRE_COLS, CRE_ROWS = 7, 5
local CRE_SLOTS_PER_PAGE = CRE_COLS * CRE_ROWS
local CRE_CELL_W, CRE_CELL_H = 0.86, 0.86
local CRE_GRID_X, CRE_GRID_Y = CTX_X + 0.35, TABS_Y + 0.85

-- Pager tighter at bottom
local PAGEX, PAGEY = CTX_X + 0.35, CTX_Y + CTX_H - 1.05

-- ---------- Player state ----------
local PAGES, SEARCH_TXT, ACTIVE_TAB, PAGE_CACHE, ALL_LIST = {}, {}, {}, {}, nil
local AW_CATEGORY = {}
local DET_TRASH_NAME = {}

-- ---------- API for category overrides ----------
aw_ui = rawget(_G, "aw_ui") or {}
function aw_ui.set_category(item, cat)
  if cat == "blocks" or cat == "nature" or cat == "misc" then
    AW_CATEGORY[item] = cat
  end
end

-- ---------- Helpers ----------
local function is_creative(name)
  return minetest.is_creative_enabled and minetest.is_creative_enabled(name)
end

local function should_hide(def)
  if not def then return true end
  if (def.description or "") == "" then return true end
  return (def.groups and def.groups.not_in_creative_inventory) == 1
end

local function build_all()
  if ALL_LIST then return end
  ALL_LIST = {}
  for name, def in pairs(minetest.registered_items) do
    if name ~= "" and not should_hide(def) then table.insert(ALL_LIST, name) end
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
    if tab=="all" or category_for(item,def)==tab then
      if q=="" or item:lower():find(q,1,true) or (def.description or ""):lower():find(q,1,true) then
        table.insert(out,item)
      end
    end
  end
  return out
end

local function compute_page(name)
  local list = filtered(ACTIVE_TAB[name] or "all", SEARCH_TXT[name] or "")
  local page = PAGES[name] or 0
  local maxp = math.max(0, math.ceil(#list / CRE_SLOTS_PER_PAGE) - 1)
  if page > maxp then page = maxp; PAGES[name]=page end

  local start = page * CRE_SLOTS_PER_PAGE + 1
  local page_items = {}
  for i=0, CRE_SLOTS_PER_PAGE-1 do
    local idx = start + i
    if list[idx] then page_items[#page_items+1] = list[idx] end
  end

  PAGE_CACHE[name] = page_items
  return page_items, page, maxp, #list
end

-- ---------- Hidden trash ----------
local function ensure_trash(player)
  local pname = player:get_player_name()
  local det = "aw_ui:trash:"..pname
  DET_TRASH_NAME[pname] = det

  if not minetest.get_inventory({type="detached",name=det}) then
    minetest.create_detached_inventory(det,{
      allow_put=function(_,_,_,s) return s:get_count() end,
      on_put=function(inv,l,i) inv:set_stack(l,i,"") end,
      allow_move=function() return 0 end,
      allow_take=function() return 0 end,
    })
  end
  local inv = minetest.get_inventory({type="detached",name=det})
  inv:set_size("main",1)
  inv:set_stack("main",1,"")
end

-- ---------- Giving items ----------
local function add_to_hotbar_first(player, stack)
  local inv = player:get_inventory()
  for i=1,9 do
    local slot = inv:get_stack("main",i)
    if slot:is_empty() then inv:set_stack("main",i,stack) return end
    if slot:get_name()==stack:get_name() then
      local leftover = slot:add_item(stack)
      inv:set_stack("main",i,slot)
      if leftover:is_empty() then return else stack = leftover end
    end
  end
  inv:add_item("main",stack)
end

local function give(player, item, count)
  local max = (minetest.registered_items[item].stack_max or 99)
  if count > max then count = max end
  add_to_hotbar_first(player, ItemStack(item.." "..count))
end

-- ---------- Survival UI ----------
local function survival(player)
  local cx,cy = CTX_X+1.0, CTX_Y+1.7
  local ax,ay = cx+2.7, cy+0.90
  local ox,oy = ax+0.25, cy+0.45

  return table.concat({
    ("box[%f,%f;%f,%f;#777777DD]"):format(CTX_X,CTX_Y,CTX_W,CTX_H),
    ("label[%f,%f;Crafting]"):format(CTX_X+0.45,CTX_Y+0.48),
    ("list[current_player;craft;%f,%f;2,2;0]"):format(cx,cy),
    ("label[%f,%f;→]"):format(ax,ay),
    ("list[current_player;craftpreview;%f,%f;1,1;0]"):format(ox,oy),
    "listring[current_player;main]",
    "listring[current_player;craft]",
    "listring[current_player;main]",
  })
end

-- ---------- Creative UI (compact) ----------
local function creative(player)
  local name = player:get_player_name()
  ensure_trash(player)
  local items,page,maxp,total = compute_page(name)
  local tab = ACTIVE_TAB[name] or "all"

  local fs = {
    ("box[%f,%f;%f,%f;#777777DD]"):format(CTX_X,CTX_Y,CTX_W,CTX_H),
    ("label[%f,%f;Creative Inventory]"):format(CTX_X+0.45,CTX_Y+0.20),

    -- Search (no label)
    ("field[%f,%f;%f,0.65;aw_srch;;%s]"):format(
      SEARCH_X,SEARCH_Y,SEARCH_W,minetest.formspec_escape(SEARCH_TXT[name] or "")
    ),
    "field_close_on_enter[aw_srch;true]",
    ("button[%f,%f;1.0,0.65;aw_srch_go;Go]"):format(SEARCH_X+SEARCH_W+0.18,SEARCH_Y),
  }

  -- Tabs row (smaller)
  local tx = TABS_X
  local function tab_btn(id,label,active)
    local style = active and "#6666FFFF" or "#444444CC"
    table.insert(fs,("style[%s;bgcolor=%s]"):format(id,style))
    table.insert(fs,("button[%f,%f;%f,%f;%s;%s]"):format(tx,TABS_Y,TAB_W,TAB_H,id,label))
    tx = tx + TAB_W + TAB_PAD
  end
  tab_btn("aw_tb_all","All",tab=="all")
  tab_btn("aw_tb_blocks","Blocks",tab=="blocks")
  tab_btn("aw_tb_nat","Nature",tab=="nature")
  tab_btn("aw_tb_misc","Misc",tab=="misc")

  -- Item buttons (compact cells)
  local col,row=0,0
  for i,item in ipairs(items) do
    local x = CRE_GRID_X + col*CRE_CELL_W
    local y = CRE_GRID_Y + row*CRE_CELL_H
    table.insert(fs,("item_image_button[%f,%f;%f,%f;%s;aw_g_%d;]"):format(x,y,CRE_CELL_W,CRE_CELL_H,item,i))
    col=col+1
    if col>=CRE_COLS then col=0 row=row+1 if row>=CRE_ROWS then break end end
  end

  -- Paging (smaller buttons)
  table.insert(fs,("button[%f,%f;0.9,0.65;aw_prev;«]"):format(PAGEX,PAGEY))
  table.insert(fs,("button[%f,%f;0.9,0.65;aw_next;»]"):format(PAGEX+1.35,PAGEY))
  table.insert(fs,("label[%f,%f;Page %d / %d  (%d items)]")
    :format(PAGEX+2.9,PAGEY+0.12,page+1,math.max(1,maxp+1),total))

  if page<=0 then table.insert(fs,"style[aw_prev;disabled=true]") end
  if page>=maxp then table.insert(fs,"style[aw_next;disabled=true]") end

  -- Hidden trash list (off-screen) + listring path
  table.insert(fs,("list[detached:%s;main;-100,-100;1,1;0]"):format(DET_TRASH_NAME[name]))
  table.insert(fs,"listring[current_player;main]")
  table.insert(fs,("listring[detached:%s;main]"):format(DET_TRASH_NAME[name]))
  table.insert(fs,"listring[current_player;main]")

  return table.concat(fs)
end

-- ---------- Base ----------
local function base()
  return table.concat({
    ("formspec_version[%d]size[%f,%f]"):format(FS_VER,SIZE_W,SIZE_H),
    ("style_type[list;spacing=%f]"):format(SLOT_SPACING),

    -- Left inventories
    ("box[%f,%f;%f,%f;#4D2B00DD]"):format(LEFT_X,LEFT_Y,LEFT_W,LEFT_H),
    ("list[current_player;main;%f,%f;%d,%d;%d]")
      :format(LEFT_X+0.35,LEFT_Y+0.35,LEFT_COLS,LEFT_ROWS,LEFT_START_ZEROBASED),

    -- Hotbar
    ("box[%f,%f;%f,%f;#222222BB]"):format(HOTBAR_BG_X,HOTBAR_BG_Y,HOTBAR_BG_W,HOTBAR_BG_H),
    ("list[current_player;main;%f,%f;9,1;0]"):format(HOTBAR_X,HOTBAR_Y),

    "listcolors[#00000000;#55555566;#FFFFFF22;#888888CC;#FFFFFF]",
    "bgcolor[#00000000]",
  })
end

local function formspec(player)
  local n=player:get_player_name()
  local inv = player:get_inventory()
  if inv:get_size("main")<32 then inv:set_size("main",32) end
  inv:set_size("craft",4)
  inv:set_size("craftpreview",1)

  local fs = { base() }
  if is_creative(n) then table.insert(fs, creative(player))
  else table.insert(fs, survival(player)) end
  return table.concat(fs)
end

local function apply_formspec(p) p:set_inventory_formspec(formspec(p)) end

-- ---------- Join / Respawn ----------
minetest.register_on_joinplayer(function(p)
  local n=p:get_player_name()
  PAGES[n], SEARCH_TXT[n], ACTIVE_TAB[n], PAGE_CACHE[n] = 0,"","all",{}
  ensure_trash(p)
  apply_formspec(p)
end)

minetest.register_on_respawnplayer(function(p)
  minetest.after(0,apply_formspec,p)
end)

-- manual test
minetest.register_chatcommand("awinv",{func=function(n)
  local p=minetest.get_player_by_name(n)
  if p then minetest.show_formspec(n,"aw_ui",formspec(p)) end
end})

-- ---------- Events ----------
minetest.register_on_player_receive_fields(function(player, formname, fields)
  local n = player:get_player_name()

  -- tabs
  if fields.aw_tb_all or fields.aw_tb_blocks or fields.aw_tb_nat or fields.aw_tb_misc then
    if fields.aw_tb_all then ACTIVE_TAB[n]="all"
    elseif fields.aw_tb_blocks then ACTIVE_TAB[n]="blocks"
    elseif fields.aw_tb_nat then ACTIVE_TAB[n]="nature"
    elseif fields.aw_tb_misc then ACTIVE_TAB[n]="misc" end
    PAGES[n]=0
    apply_formspec(player) return
  end

  -- search
  if (fields.aw_srch_go and fields.aw_srch)
  or (fields.key_enter_field=="aw_srch" and fields.aw_srch) then
    SEARCH_TXT[n]=fields.aw_srch
    PAGES[n]=0
    apply_formspec(player) return
  end

  -- paging
  if fields.aw_prev then PAGES[n]=math.max(0,(PAGES[n] or 0)-1) apply_formspec(player) return end
  if fields.aw_next then PAGES[n]=(PAGES[n] or 0)+1 apply_formspec(player) return end

  -- give item buttons (click=1, Shift=stack)
  compute_page(n) -- update PAGE_CACHE
  for i=1,CRE_SLOTS_PER_PAGE do
    if fields["aw_g_"..i] then
      local item = PAGE_CACHE[n][i]
      if item then
        local shift = (fields.key_shift==true or fields.key_shift=="true")
        local max = (minetest.registered_items[item].stack_max or 99)
        give(player, item, shift and max or 1)
      end
      return
    end
  end
end)
