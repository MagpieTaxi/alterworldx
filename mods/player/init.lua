--player facing direction functions
local function getDirTexture(dir)
	local yaw_deg = math.deg(dir)
    yaw_deg = (yaw_deg + 360) % 360

    if yaw_deg >= 45 and yaw_deg < 135 then
        return "player_right.png"
    elseif yaw_deg >= 135 and yaw_deg < 225 then
        return "player_back.png"
    elseif yaw_deg >= 225 and yaw_deg < 315 then
        return "player_left.png"
    else
        return "player_front.png"
    end
end

core.register_on_joinplayer(function(plr)
	plr:set_properties({
		visual = "sprite",
        textures = {"player.png"},
        visual_size = {x = 1, y = 2},
        collisionbox = {-0.3, -1, -0.3, 0.3, .8, 0.3},
		eye_height = .5,
        physical = true,
        pointable = true,
	})
	plr:set_physics_override({
		
	})
end)

core.register_globalstep(function(dt)
	local plrs = core.get_connected_players()
	for _, observer in ipairs(plrs) do
		for _, target in ipairs(plrs) do
			if true then
				local vec = target:get_pos() - observer:get_pos()
				local angle = math.atan(vec.z, vec.x)

				local tex = getDirTexture(angle)

				target:set_properties({
					textures = { tex }
				})
			end
		end
	end
end)