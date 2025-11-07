core.register_craftitem("items:plant_fiber",{
	description = "Plant Fiber",
	inventory_image = "plant_fiber.png",
	wield_image = "plant_fiber.png"
})
core.register_craftitem("items:lignite",{
		description = "Lignite",
	inventory_image = "lignite.png",
	wield_image = "lignite.png"
})
core.register_craftitem("items:cotton",{
	description = "Cotton",
	inventory_image = "cotton_item.png",
	wield_image = "cotton_item.png"
})
core.register_craftitem("items:cotton_seeds",{
	description = "Cotton Seeds",
	inventory_image = "cotton_seeds.png",
	wield_image = "cotton_seeds.png",
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above ~= nil then
			core.set_node(pointed_thing.above, {name = "blocks:cotton_plant"})
			itemstack:take_item(1)
			return itemstack
		end
		return itemstack
	end
})