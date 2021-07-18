local DagonHake = {}

DagonHake.IsToggled = Menu.AddOption({"Utility"}, "DagonHake", "")
DagonHake.sleepers = {}
DagonHake.Modifiers = {[0] = "modifier_medusa_stone_gaze_stone",[1] = "modifier_winter_wyvern_winters_curse",[2] = "modifier_item_lotus_orb_active",[3] = "modifier_templar_assassin_refraction_absorb",[4] = "modifier_item_blade_mail_reflect",[5] = "modifier_nyx_assassin_spiked_carapace" }

function DagonHake.OnUpdate()
	local hero = Heroes.GetLocal()
	if not hero or not Menu.IsEnabled(DagonHake.IsToggled) or not DagonHake.SleepCheck(0.1, "updaterate") or not Entity.IsAlive(hero) then return end
	local dagon = NPC.GetItem(hero, "item_dagon", true)
	if not dagon then
		for i = 2, 5 do
			dagon = NPC.GetItem(hero, "item_dagon_" .. i, true)
			if dagon then break end
		end
	end	
	if not dagon or not Ability.IsReady(dagon) or not Ability.IsCastable(dagon, Ability.GetManaCost(dagon)) then return end	
	local target = DagonHake.FindTarget(hero, dagon)
	if not target then return end
	Ability.CastTarget(dagon, target)	
	DagonHake.Sleep(0.1, "updaterate");
end

DagonHake.font = Renderer.LoadFont("Tahoma", 20, Enum.FontWeight.EXTRABOLD)

function DagonHake.FindTarget(me, item)	
	local entities = Heroes.GetAll()
	for index, ent in pairs(entities) do
		local enemyhero = Heroes.Get(index)
		if not Entity.IsSameTeam(me, enemyhero) and not NPC.IsLinkensProtected(enemyhero) and not NPC.IsIllusion(enemyhero) and NPC.IsEntityInRange(me, enemyhero, Ability.GetCastRange(item) + NPC.GetCastRangeBonus(me)) then
			local amplf = 0
			if NPC.GetItem(me, "item_kaya", true) then
				amplf = 0.1
			end
			amplf = amplf + DagonHake.GetAmplifiers(me, enemyhero)
			local dagondmg = Ability.GetLevelSpecialValueFor(item, "damage") + Ability.GetLevelSpecialValueFor(item, "damage") *(Hero.GetIntellectTotal(me)/100 * (0.066891 + amplf))
			local totaldmg = NPC.GetMagicalArmorDamageMultiplier(enemyhero) * dagondmg
			local isValid = DagonHake.CheckForModifiers(enemyhero)
			if Entity.GetHealth(enemyhero) < totaldmg and isValid then return enemyhero end
		end
	end
end

function DagonHake.GetAmplifiers(hero, enemy)
	local amplfs = 0
	if NPC.HasModifier(hero, "modifier_bloodseeker_bloodrage") then
		amplfs = amplfs + Modifier.GetConstantByIndex(NPC.GetModifier(hero, "modifier_bloodseeker_bloodrage"), 1) / 100
	end
	if NPC.HasModifier(enemy, "modifier_bloodseeker_bloodrage") then
		amplfs = amplfs + Modifier.GetConstantByIndex(NPC.GetModifier(enemy, "modifier_bloodseeker_bloodrage"), 1) / 100
	end
	if NPC.HasModifier(enemy, "modifier_chen_penitence") then
		amplfs = amplfs + Modifier.GetConstantByIndex(NPC.GetModifier(enemy, "modifier_chen_penitence"), 1) / 100
	end
	if NPC.HasModifier(enemy, "modifier_shadow_demon_soul_catcher") then
		amplfs = amplfs + Modifier.GetConstantByIndex(NPC.GetModifier(enemy, "modifier_shadow_demon_soul_catcher"), 0) / 100
	end

	if NPC.HasModifier(enemy, "modifier_slardar_sprint") then
		amplfs = amplfs + Modifier.GetConstantByIndex(NPC.GetModifier(enemy, "modifier_slardar_sprint"), 0) / 100
	end

	if NPC.HasModifier(enemy, "modifier_slardar_sprint") then
		amplfs = amplfs + Modifier.GetConstantByIndex(NPC.GetModifier(enemy, "modifier_slardar_sprint"), 0) / 100
	end

	if NPC.HasModifier(enemy, "modifier_item_mask_of_death") then
		amplfs = amplfs + 25 / 100
	end

	if NPC.HasModifier(enemy, "modifier_item_orchid_malevolence") then
		amplfs = amplfs + 30 / 100
	end

	return amplfs
end

function DagonHake.CheckForModifiers(target)
	for i = 0, 5 do
		if NPC.HasModifier(target, DagonHake.Modifiers[i]) then
			return false
		end
	end
	return true
end

function DagonHake.SleepCheck(delay, id)
	if not DagonHake.sleepers[id] or(os.clock() - DagonHake.sleepers[id]) > delay then
		return true
	end
	return false
end

function DagonHake.Sleep(delay, id)
	if not DagonHake.sleepers[id] or DagonHake.sleepers[id] < os.clock() + delay then
		DagonHake.sleepers[id] = os.clock() + delay
	end
end

return DagonHake
