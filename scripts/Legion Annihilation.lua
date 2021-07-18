--Author: spiregor
local LegionCommander = {}

LegionCommander.optionKey = Menu.AddKeyOption({"Hero Specific","Legion Commander","Legion Annihilation"},"Combo Key",Enum.ButtonCode.KEY_D)
LegionCommander.optionEnable = Menu.AddOption({"Hero Specific","Legion Commander","Legion Annihilation"},"Enabled","Enable Or Disable Legion Combo Script")
LegionCommander.optionTypeMode = Menu.AddOption({"Hero Specific","Legion Commander","Legion Annihilation"},"Use combo with: ","Dagger Or Invisible Sword")
LegionCommander.optionPoABefore = Menu.AddOption({"Hero Specific","Legion Commander","Legion Annihilation"},"Use Press of Attak before invisibility","Enable of Disable")
--// Menu Linkens Breaker //--
LegionCommander.optionLinkensBreakerAbyssal = Menu.AddOption({"Hero Specific","Legion Commander","Legion Annihilation","Linkens Breaker"},"Abyssal Blade","Enable Or Disable")
LegionCommander.optionLinkensBreakerOrchid = Menu.AddOption({"Hero Specific","Legion Commander","Legion Annihilation","Linkens Breaker"},"Orchid Malevolence","Enable Or Disable")
LegionCommander.optionLinkensBreakerBlood = Menu.AddOption({"Hero Specific","Legion Commander","Legion Annihilation","Linkens Breaker"},"BloodThorn","Enable Or Disable")
LegionCommander.optionLinkensBreakerEuls = Menu.AddOption({"Hero Specific","Legion Commander","Legion Annihilation","Linkens Breaker"},"Eul's Scepter","Enable Or Disable")
LegionCommander.optionLinkensBreakerRoA = Menu.AddOption({"Hero Specific","Legion Commander","Legion Annihilation","Linkens Breaker"},"Rod of Atos","Enable Or Disable")
LegionCommander.optionLinkensBreakerHex = Menu.AddOption({"Hero Specific","Legion Commander","Legion Annihilation","Linkens Breaker"},"Scythe of Vyse","Enable Or Disable")
LegionCommander.optionLinkensBreakerForceStaff = Menu.AddOption({"Hero Specific","Legion Commander","Legion Annihilation","Linkens Breaker"},"Force Staff","Enable Or Disable")
LegionCommander.optionLinkensBreakerHalberd = Menu.AddOption({"Hero Specific","Legion Commander","Legion Annihilation","Linkens Breaker"},"Heaven's Halberd","Enable Or Disable")
LegionCommander.optionLinkensBreakerDiffusal = Menu.AddOption({"Hero Specific","Legion Commander","Legion Annihilation","Linkens Breaker"},"Diffusal Blade","Enable Or Disable")
--//----------------------//
LegionCommander.optionBKB = Menu.AddOption({"Hero Specific","Legion Commander","Legion Annihilation","Items"},"Black King Bar","Enable Or Disable")

LegionCommander.sleepers = {}

	Menu.SetValueName(LegionCommander.optionTypeMode, 1, "Dagger")
	Menu.SetValueName(LegionCommander.optionTypeMode, 0, "Invisible Sword")
	
	
	
LegionCommander.ItemsLinkensBreaker =
{
Abyssal = "item_abyssal_blade",
Halberd = "item_heavens_halberd"
}	
function LegionCommander.OnUpdate()
    if not LegionCommander.SleepCheck(0.1, "updaterate") then return end
    if not Menu.IsEnabled(LegionCommander.optionEnable) then return true end

	if Menu.IsKeyDown(LegionCommander.optionKey)then
    LegionCommander.Combo()
	end
end

function LegionCommander.Combo()
if not Menu.IsKeyDown(LegionCommander.optionKey) then return end
    
	local myHero = Heroes.GetLocal()
    if NPC.GetUnitName(myHero) ~= "npc_dota_hero_legion_commander" then return end
    
	local hero = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
	local heroPos = Entity.GetAbsOrigin(hero)
	local myMana = NPC.GetMana(myHero)
	
	if not hero  then return end
--Skills	
	local PressTheAttack = NPC.GetAbility(myHero, "legion_commander_press_the_attack")
    local Duel = NPC.GetAbility(myHero, "legion_commander_duel")
--Items
	local Dagger  = NPC.GetItem(myHero, "item_blink", true)
	local ShadowBlade  = NPC.GetItem(myHero, "item_invis_sword", true)
	local SilverEdge  = NPC.GetItem(myHero, "item_silver_edge", true)
	local BladeMail  = NPC.GetItem(myHero, "item_blade_mail", true)
	local LotusOrb  = NPC.GetItem(myHero, "item_lotus_orb", true)
	local Mjollnir  = NPC.GetItem(myHero, "item_mjollnir", true)
	local BKB  = NPC.GetItem(myHero, "item_black_king_bar", true)
	local Medallion  = NPC.GetItem(myHero, "item_medallion_of_courage", true)
	local SolarCrest  = NPC.GetItem(myHero, "item_solar_crest", true)
	local Orchid  = NPC.GetItem(myHero, "item_orchid", true)
	local BloodThorn  = NPC.GetItem(myHero, "item_bloodthorn", true)
	local Abyssal  = NPC.GetItem(myHero, "item_abyssal_blade", true)
	local Armlet = NPC.GetItem(myHero, "item_armlet", true)
	local Euls = NPC.GetItem( myHero, "item_cyclone", true)
	local RoA = NPC.GetItem( myHero, "item_rod_of_atos", true)
	local Hex = NPC.GetItem(myHero, "item_sheepstick", true)
	local ForceStaff = NPC.GetItem(myHero, "item_force_staff", true)
	local Halberd = NPC.GetItem(myHero, "item_heavens_halberd", true)
	local Diffus = NPC.GetItem(myHero, "item_diffusal_blade", true)
	if not Diffus then
		for i = 2, 2 do
			Diffus = NPC.GetItem(myHero, "item_diffusal_blade_" .. i, true)
			if Diffus then break end
		end
	end	 
	
	if Menu.IsEnabled(LegionCommander.optionEnable) and Duel and Ability.IsCastable(Duel, myMana) then
	--Dagger MOD	
		if Menu.IsEnabled(LegionCommander.optionTypeMode) then
		--Log.Write(tostring(Menu.GetValue(LegionCommander.optionTypeMode)))
			if Dagger and Ability.IsCastable(Dagger, 0) and NPC.IsEntityInRange(hero, myHero, 1200 + NPC.GetCastRangeBonus(myHero)) then
		        if Mjollnir and Ability.IsCastable(Mjollnir, myMana) then Ability.CastTarget(Mjollnir, myHero) return end
				if PressTheAttack and Ability.IsCastable(PressTheAttack, myMana) then Ability.CastTarget(PressTheAttack, myHero) return end
				if LotusOrb and Ability.IsCastable(LotusOrb, myMana) then Ability.CastTarget(LotusOrb, myHero) return end
				if BladeMail and Ability.IsCastable(BladeMail, myMana) then Ability.CastNoTarget(BladeMail) return end
				if Dagger and Ability.IsCastable(Dagger, 0) then Ability.CastPosition(Dagger, heroPos) return end
		    end	
			
			if NPC.IsEntityInRange(hero, myHero, 200) then
				
				if NPC.IsLinkensProtected(hero)then
					if Menu.IsEnabled(LegionCommander.optionLinkensBreakerAbyssal)
					and Abyssal and Ability.IsCastable(Abyssal, myMana) and NPC.IsLinkensProtected(hero) then Ability.CastTarget(Abyssal, hero); return end
					if Menu.IsEnabled(LegionCommander.optionLinkensBreakerOrchid)
					and Orchid and Ability.IsCastable(Orchid, myMana) and NPC.IsLinkensProtected(hero) then Ability.CastTarget(Orchid, hero); return end
					if Menu.IsEnabled(LegionCommander.optionLinkensBreakerBlood)
					and BloodThorn and Ability.IsCastable(BloodThorn, myMana) and NPC.IsLinkensProtected(hero) then Ability.CastTarget(BloodThorn, hero); return end
					if Menu.IsEnabled(LegionCommander.optionLinkensBreakerEuls)
					and Euls and Ability.IsCastable(Euls, myMana) and NPC.IsLinkensProtected(hero) then Ability.CastTarget(Euls, hero); return end
					if Menu.IsEnabled(LegionCommander.optionLinkensBreakerRoA)
					and RoA and Ability.IsCastable(RoA, myMana) and NPC.IsLinkensProtected(hero) then Ability.CastTarget(RoA, hero); return end
					if Menu.IsEnabled(LegionCommander.optionLinkensBreakerHex)
					and Hex and Ability.IsCastable(Hex, myMana) and NPC.IsLinkensProtected(hero) then Ability.CastTarget(Hex, hero); return end
					if Menu.IsEnabled(LegionCommander.optionLinkensBreakerForceStaff)
					and ForceStaff and Ability.IsCastable(ForceStaff, myMana) and NPC.IsLinkensProtected(hero) then Ability.CastTarget(ForceStaff, hero); return end
					if Menu.IsEnabled(LegionCommander.optionLinkensBreakerHalberd)
					and Halberd and Ability.IsCastable(Halberd, myMana) and NPC.IsLinkensProtected(hero) then Ability.CastTarget(Halberd, hero); return end
					if Menu.IsEnabled(LegionCommander.optionLinkensBreakerDiffusal)
					and Diffus and Ability.IsCastable(Diffus, myMana) and NPC.IsLinkensProtected(hero) then Ability.CastTarget(Diffus, hero); return end
				end
				if not NPC.IsLinkensProtected(hero) then
				if Mjollnir and Ability.IsCastable(Mjollnir, myMana) then Ability.CastTarget(Mjollnir, myHero) return end
				 if PressTheAttack and Ability.IsCastable(PressTheAttack, myMana) then Ability.CastTarget(PressTheAttack, myHero) return end
				 if LotusOrb and Ability.IsCastable(LotusOrb, myMana) then Ability.CastTarget(LotusOrb, myHero) return end
				if BladeMail and Ability.IsCastable(BladeMail, myMana) then Ability.CastNoTarget(BladeMail) return end
				 if Medallion and Ability.IsCastable(Medallion, 0) then Ability.CastTarget(Medallion,hero) return end
			     if SolarCrest and Ability.IsCastable(SolarCrest, 0) then Ability.CastTarget(SolarCrest,hero) return end
				 if Orchid and Ability.IsCastable(Orchid, myMana) then Ability.CastTarget(Orchid,hero) return end
				 if BloodThorn and Ability.IsCastable(BloodThorn, myMana) then Ability.CastTarget(BloodThorn,hero)return end
				 if Armlet and not Ability.GetToggleState(Armlet) then Ability.Toggle(Armlet, true) LegionCommander.Sleep(0.1, "updaterate") end
				 if Menu.IsEnabled(LegionCommander.optionBKB)
				 and BKB and Ability.IsCastable(BKB, 0) then Ability.CastNoTarget(BKB) return end
			 	 if Duel and Ability.IsCastable(Duel, myMana) then Ability.CastTarget(Duel,hero) return end
				end
			end
		end
	--//Invisible MOD//--	
		if not Menu.IsEnabled(LegionCommander.optionTypeMode) then 
			if (ShadowBlade or SilverEdge) and Duel and Ability.IsCastable(Duel, myMana) then
		
				if Menu.IsEnabled(LegionCommander.optionPoABefore) and
				PressTheAttack and Ability.IsCastable(PressTheAttack, myMana) then Ability.CastTarget(PressTheAttack, myHero) return end
				if ShadowBlade and Ability.IsCastable(ShadowBlade, myMana) then Ability.CastNoTarget(ShadowBlade) return end
				if SilverEdge  and Ability.IsCastable(SilverEdge , myMana) then Ability.CastNoTarget(SilverEdge) return end
	        
				if NPC.HasModifier(myHero, "modifier_item_invisibility_edge_windwalk") or NPC.HasModifier(myHero, "modifier_item_silver_edge_windwalk") then 
				Player.AttackTarget( Players.GetLocal(), myHero , hero , false ) return end
		    end
			
			if NPC.IsLinkensProtected(hero) and NPC.IsEntityInRange(hero, myHero, 370) then
				if Menu.IsEnabled(LegionCommander.optionLinkensBreakerAbyssal)
				and Abyssal and Ability.IsCastable(Abyssal, myMana) and NPC.IsLinkensProtected(hero) then Ability.CastTarget(Abyssal, hero); return end
				--LegionCommander.CheckItemsLinkensBreaker(myHero,hero,myMana)
				if Menu.IsEnabled(LegionCommander.optionLinkensBreakerOrchid)
				and Orchid and Ability.IsCastable(Orchid, myMana) and NPC.IsLinkensProtected(hero) then Ability.CastTarget(Orchid, hero); return end
				if Menu.IsEnabled(LegionCommander.optionLinkensBreakerBlood)
				and BloodThorn and Ability.IsCastable(BloodThorn, myMana) and NPC.IsLinkensProtected(hero) then Ability.CastTarget(BloodThorn, hero); return end
				if Menu.IsEnabled(LegionCommander.optionLinkensBreakerEuls)
				and Euls and Ability.IsCastable(Euls, myMana) and NPC.IsLinkensProtected(hero) then Ability.CastTarget(Euls, hero); return end
				if Menu.IsEnabled(LegionCommander.optionLinkensBreakerRoA)
				and RoA and Ability.IsCastable(RoA, myMana) and NPC.IsLinkensProtected(hero) then Ability.CastTarget(RoA, hero); return end
				if Menu.IsEnabled(LegionCommander.optionLinkensBreakerHex)
				and Hex and Ability.IsCastable(Hex, myMana) and NPC.IsLinkensProtected(hero) then Ability.CastTarget(Hex, hero); return end
				if Menu.IsEnabled(LegionCommander.optionLinkensBreakerForceStaff)
				and ForceStaff and Ability.IsCastable(ForceStaff, myMana) and NPC.IsLinkensProtected(hero) then Ability.CastTarget(ForceStaff, hero); return end
				if Menu.IsEnabled(LegionCommander.optionLinkensBreakerHalberd)
				and Halberd and Ability.IsCastable(Halberd, myMana) and NPC.IsLinkensProtected(hero) then Ability.CastTarget(Halberd, hero); return end
				if Menu.IsEnabled(LegionCommander.optionLinkensBreakerDiffusal)
				and Diffus and Ability.IsCastable(Diffus, myMana) and NPC.IsLinkensProtected(hero) then Ability.CastTarget(Diffus, hero); return end
			end
	        
			if NPC.IsEntityInRange(hero, myHero, 200) and not NPC.IsLinkensProtected(hero) and (not NPC.HasModifier(myHero, "modifier_item_invisibility_edge_windwalk") or not NPC.HasModifier(myHero, "modifier_item_silver_edge_windwalk") )  then
			 if PressTheAttack and Ability.IsCastable(PressTheAttack, myMana) then Ability.CastTarget(PressTheAttack, myHero) return end
			 if Mjollnir and Ability.IsCastable(Mjollnir, myMana) then Ability.CastTarget(Mjollnir, myHero) return end
			 if LotusOrb and Ability.IsCastable(LotusOrb, myMana) then Ability.CastTarget(LotusOrb, myHero) return end
			 if BladeMail and Ability.IsCastable(BladeMail, myMana) then Ability.CastNoTarget(BladeMail) return end
			 if Medallion and Ability.IsCastable(Medallion, 0) then Ability.CastTarget(Medallion,hero) return end
			 if SolarCrest and Ability.IsCastable(SolarCrest, 0) then Ability.CastTarget(SolarCrest,hero) return end
			 if Orchid and Ability.IsCastable(Orchid, myMana) then Ability.CastTarget(Orchid,hero) return end
			 if BloodThorn and Ability.IsCastable(BloodThorn, myMana) then Ability.CastTarget(BloodThorn,hero) return end
			 if Armlet and not Ability.GetToggleState(Armlet) then Ability.Toggle(Armlet, true) LegionCommander.Sleep(0.1, "updaterate") end
			 if Menu.IsEnabled(LegionCommander.optionBKB)
			 and BKB and Ability.IsCastable(BKB, 0) then Ability.CastNoTarget(BKB) return end
			 if Duel and Ability.IsCastable(Duel, myMana) then Ability.CastTarget(Duel,hero) return end
		    end
		end
	end	
end

--[[function LegionCommander.CheckItemsLinkensBreaker(myHero,hero,myMana)
    for key, val in pairs(LegionCommander.ItemsLinkensBreaker) do
	 if Menu.IsEnabled(LegionCommander.optionLinkensBreaker..key) then
	 	key = NPC.GetItem(myHero, val, true)
		if key and Ability.IsCastable(key, myMana) and NPC.IsLinkensProtected(hero) then Ability.CastTarget(key, hero); return end
	 end
	end
end]]


function LegionCommander.SleepCheck(delay, id)
	if not LegionCommander.sleepers[id] or (os.clock() - LegionCommander.sleepers[id]) > delay then
		return true
	end
	return false
end

function LegionCommander.Sleep(delay, id)
	if not LegionCommander.sleepers[id] or LegionCommander.sleepers[id] < os.clock() + delay then
		LegionCommander.sleepers[id] = os.clock() + delay
	end
end

return LegionCommander