minetest.register_tool("new_swords:admin_sword", {
                   -- (modname:swordname)
    description = "Admin Sword", -- the name that will appear in the creative inventory.
    inventory_image = "admin_sword.png", -- the picture of it, will be found in the "textures" folder.
    tool_capabilities = {
	full_punch_interval = 0.5,
        max_drop_level=1,
        groupcaps={
            snappy={times={[1]=1.00, [2]=0.50, [3]=0.10},
uses=50, maxlevel=3},
		},
		damage_groups = {fleshy=9},
	},
	sound = {breaks = "default_tool_breaks"}, -- the sound it will play when broken, will be found in the "sounds" folder, but in this case it will be found in the "default" mod in minetest_game mods.
	groups = {sword = 1, not_in_creative_inventory=1},
})

minetest.register_tool("new_swords:platinum_sword", {
    description = "Platinum Sword",
    inventory_image = "platinum_sword.png",
    tool_capabilities = {
	full_punch_interval = 0.8,
        max_drop_level=1,
        groupcaps={
		snappy={times={[1]=1.20, [2]=0.80, [3]=0.20},
uses=45, maxlevel=3},
		},
		damage_groups = {fleshy=7},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})

minetest.register_tool("new_swords:obsidian_sword", {
    description = "Obsidian Sword",
    inventory_image = "obsidian_sword.png",
    tool_capabilities = {
	full_punch_interval = 0.9,
        max_drop_level=1,
        groupcaps={
            snappy={times={[1]=1.50, [2]=0.65, [3]=0.25},
uses=40, maxlevel=3},
		},
		damage_groups = {fleshy=9},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})

minetest.register_tool("new_swords:ruby_sword", {
    description = "Ruby Sword",
    inventory_image = "ruby_sword.png",
    tool_capabilities = {
	full_punch_interval = 0.5,
        max_drop_level=0,
        groupcaps={
            snappy={times={[1]=1.00, [2]=0.50, [3]=0.10},
uses=50, maxlevel=3},
		},
		damage_groups = {fleshy=9},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})

minetest.register_tool("new_swords:glass_sword", {
	description = "Glass Sword",
	inventory_image = "glass_sword.png",
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})

minetest.register_tool("new_swords:amber_sword", {
    description = "Amber Sword",
    inventory_image = "amber_sword.png",
    tool_capabilities = {
	full_punch_interval = 0.5,
        max_drop_level=0,
        groupcaps={
            snappy={times={[1]=1.00, [2]=0.50, [3]=0.10},
uses=50, maxlevel=3},
		},
		damage_groups = {fleshy=9},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})

minetest.register_tool("new_swords:emerald_sword", {
    description = "Emerald Sword",
    inventory_image = "emerald_sword.png",
    tool_capabilities = {
	full_punch_interval = 0.5,
        max_drop_level=0,
        groupcaps={
            snappy={times={[1]=1.00, [2]=0.50, [3]=0.10},
uses=50, maxlevel=3},
		},
		damage_groups = {fleshy=9},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})

minetest.register_tool("new_swords:fire_sword", {
	description = "Fire Sword",
	inventory_image = "fire_sword.png",
	sound = {breaks = "default_tool_breaks"},

	on_use = function(itemstack, user, pointed_thing)
		local sound_pos = pointed_thing.above or user:get_pos()
		minetest.sound_play("fire_flint_and_steel",
			{pos = sound_pos, gain = 0.5, max_hear_distance = 8}, true)
		local player_name = user:get_player_name()
		if pointed_thing.type == "node" then
			local node_under = minetest.get_node(pointed_thing.under).name
			local nodedef = minetest.registered_nodes[node_under]
			if not nodedef then
				return
			end
			if minetest.is_protected(pointed_thing.under, player_name) then
				minetest.chat_send_player(player_name, "This area is protected")
				return
			end
			if nodedef.on_ignite then
				nodedef.on_ignite(pointed_thing.under, user)
			elseif minetest.get_item_group(node_under, "flammable") >= 1
					and minetest.get_node(pointed_thing.above).name == "air" then
				minetest.set_node(pointed_thing.above, {name = "fire:basic_flame"})
			end
		end
		if not (creative and creative.is_enabled_for
				and creative.is_enabled_for(player_name)) then
			-- Wear tool
			local wdef = itemstack:get_definition()
			itemstack:add_wear(1000)

			-- Tool break sound
			if itemstack:get_count() == 0 and wdef.sound and wdef.sound.breaks then
				minetest.sound_play(wdef.sound.breaks,
					{pos = sound_pos, gain = 0.5}, true)
			end
			return itemstack
		end
	end
})
