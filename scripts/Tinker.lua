local Tinker = {}
Tinker.IsEnabled = Menu.AddOption({ "Hero Specific","Tinker" }, "Enabled", "")
Tinker.Version = Menu.AddOption({ "Hero Specific","Tinker" }, "Version", "- Bug fixes", 1,1,1)
Menu.SetValueName(Tinker.Version, 1, "4.3.3")
Tinker.DMGCalculator = Menu.AddOption({ "Hero Specific","Tinker", "Extra" }, "DMG Calculator", "", 1, 3)
Menu.SetValueName(Tinker.DMGCalculator, 1, "Off")
Menu.SetValueName(Tinker.DMGCalculator, 2, "Enabled - Bar")
Menu.SetValueName(Tinker.DMGCalculator, 3, "Enabled - Mouse")
Tinker.KillIndicator = Menu.AddOption({ "Hero Specific","Tinker", "Extra" }, "Kill Indicator", "")
Tinker.FailRockets = Menu.AddOption({ "Hero Specific","Tinker", "Extra", "Fail Switch" }, "Fail Rockets", "")
Tinker.FailRearm = Menu.AddOption({ "Hero Specific","Tinker", "Extra", "Fail Switch" }, "Fail Rearm", "")

Tinker.ExtraSoul = Menu.AddOption({ "Hero Specific","Tinker", "Extra", "Items" }, "Soul Ring", "Cast Soul Ring before each ability")
Tinker.ExtraSoulT = Menu.AddOption({ "Hero Specific","Tinker", "Extra", "Items" }, "Soul Ring Threshold", "", 150, 500, 50)
Tinker.ExtraBottle = Menu.AddOption({ "Hero Specific","Tinker", "Extra", "Items" }, "Bottle", "Drink bottle on yourself before each ability")

Tinker.FailRearmAI = Menu.AddOption({ "Hero Specific","Tinker", "Extra", "Fail Switch" }, "Fail Rearm - check abilities / items", "")
Tinker.KillSteal = Menu.AddOption({ "Hero Specific","Tinker", "Extra" }, "Steal Kill by Spells", "")
Tinker.FontDMG = Renderer.LoadFont("Tahoma", 16, Enum.FontWeight.BOLD)
Tinker.FontKill = Renderer.LoadFont("Tahoma", 30, Enum.FontWeight.BOLD)

-- Local options
Tinker.OrdersCount = 10 -- Edit for more orders
Tinker.SpellCount = 15 -- Edit for more spells
Tinker.NextTime = 0
Tinker.CurrentTime = 0
Tinker.Hero = nil
Tinker.LastCastAbility = nil
Tinker.NearestEnemyHero = nil
Tinker.NearestEnemyHeroPos = nil
Tinker.ManaPoint = 0
Tinker.TotalMagicDamage = 0
Tinker.TotalMagicFactor = 0
Tinker.TotalPureDamage = 0
Tinker.TotalManaCost = 0
Tinker.TotalDamage = 0
Tinker.StopAnimation = false

Tinker.Items = {}
Tinker.Items[1] =  "Off"
-- Available items
Tinker.Items[2] =  "Ghost"
Tinker.Items[3] =  "Soul Ring"
Tinker.Items[4] =  "Hex"
Tinker.Items[5] =  "Veil"
Tinker.Items[6] =  "Ethereal"
Tinker.Items[7] =  "Orchid"
Tinker.Items[8] =  "Blood"
Tinker.Items[9] =  "Rod"
Tinker.Items[10] =  "Bottle"
Tinker.Items[11] =  "Dagon"
Tinker.Items[12] =  "Shiva"
Tinker.Items[13] =  "Boots to Mouse"
Tinker.Items[14] =  "Boots to Base"
Tinker.Items[15] =  "Eul's on Enemy"
Tinker.Items[16] =  "Eul's on Self"
Tinker.Items[17] =  "Blink to Mouse"
Tinker.Items[18] =  "Blink to Base"
Tinker.Items[19] =  "Lotus"
Tinker.Items[20] =  "Medallion of Courage"
Tinker.Items[21] =  "Solar Crest"
Tinker.Items[22] =  "Delay (0.1s)"
-- Hero Skills
Tinker.Items[23] =  "Laser"
Tinker.Items[24] =  "Rockets"
Tinker.Items[25] =  "March"
Tinker.Items[26] =  "Rearm"
Tinker.Items[27] =  "Safe Blink"

Tinker.ItemsLength = 27

-- Initialize

Tinker.Orders = {}

Tinker.SafePos =
{
	Vector(-7305, -5016, 384),
	Vector(-7328, -4768, 384),
	Vector(-7264, -4505, 384),
	Vector(-7136, -4384, 384),
	Vector(-7072, -1120, 384),
	Vector(-7072, -672, 384),
	Vector(-7200, -288, 384),
	Vector(-6880, 288, 384),
	Vector(-6944, 1568, 384),
	Vector(-6688, 3488, 384),
	Vector(-6752, 3616, 384),
	Vector(-6816, 3744, 384),
	Vector(-6816, 4448, 384),
	Vector(-5152, 5088, 384),
	Vector(-3936, 5536, 384),
	Vector(-5152, 6624, 384),
	Vector(-3680, 6624, 384),
	Vector(-2720, 6752, 384),
	Vector(-2720, 5536, 384),
	Vector(-1632, 6688, 384),
	Vector(-1056, 6752, 384),
	Vector(-736, 6816, 384),
	Vector(-992, 5536, 384),
	Vector(-1568, 5536, 384),
	Vector(608, 7008, 384),
	Vector(1632, 6752, 256),
	Vector(2336, 7136, 384),
	Vector(1568, 3040, 384),
	Vector(1824, 3296, 384),
	Vector(-2976, 480, 384),
	Vector(736, 1056, 256),
	Vector(928, 1248, 256),
	Vector(928, 1696, 256),
	Vector(2784, 992, 256),
	Vector(-2656, -1440, 256),
	Vector(-2016, -2464, 256),
	Vector(-2394, -3110, 256),
	Vector(-1568, -3232, 256),
	Vector(-2336, -4704, 256),
	Vector(-416, -7072, 384),
	Vector(2336, -5664, 384),
	Vector(2464, -5728, 384),
	Vector(2848, -5664, 384),
	Vector(2400, -6817, 384),
	Vector(3040, -6624, 384),
	Vector(4256, -6624, 384),
	Vector(4192, -6880, 384),
	Vector(5024, -5408, 384),
	Vector(5856, -6240, 384),
	Vector(6304, -6112, 384),
	Vector(6944, -5472, 384),
	Vector(7328, -5024, 384),
	Vector(7200, -3296, 384),
	Vector(7200, -2272, 384),
	Vector(6944, -992, 384),
	Vector(6816, -224, 384),
	Vector(7200, 480, 384),
	Vector(7584, 2080, 256),
	Vector(7456, 2784, 384),
	Vector(5344, 2528, 384),
	Vector(7200, 5536, 384),
	Vector(4192, 6944, 384),
	Vector(5472, 6752, 384),
	Vector(-6041, -6883, 384),
	Vector(-5728, -6816, 384),
	Vector(-5408, -7008, 384),
	Vector(-5088, -7072, 384),
	Vector(-4832, -7072, 384),
	Vector(-3744, -7200, 384)
}

local list = "List:"
local tempi = 1
for k,v in pairs(Tinker.Items) do
	list = list .. "\r\n" .. tempi .. " - " .. v
	tempi = tempi + 1
end

-- Explaining
-- 100	=	Enabled
-- 200	=	Key
-- 300	=	Delay Reset
-- 400	=	MP Threshold
-- 500	=	Range
for i = 1, Tinker.OrdersCount do 
	Tinker.Orders[i] = {}
	local temp = i
	if i < 10 then temp = "0" .. i end
	Tinker.Orders[i][100] = Menu.AddOption({ "Hero Specific","Tinker", "Orders", "Order #" .. temp }, temp .. ". Enabled", "" )
	Tinker.Orders[i][200] = Menu.AddKeyOption({ "Hero Specific","Tinker", "Orders", "Order #" .. temp }, temp .. ". Key", Enum.ButtonCode.KEY_PAD_0 )
	Tinker.Orders[i][300] = Menu.AddOption({ "Hero Specific","Tinker", "Orders", "Order #" .. temp }, temp .. ". Reset", "", 1, 10, 1)
	Tinker.Orders[i][400] = Menu.AddOption({ "Hero Specific","Tinker", "Orders", "Order #" .. temp }, temp .. ". MP Threshold", "", 0, 2000, 100)
	Tinker.Orders[i][500] = Menu.AddOption({ "Hero Specific","Tinker", "Orders", "Order #" .. temp }, temp .. ". Nearest to mouse", "If 0 - option will not taken into account", 0, 3000, 100)

	for l = 1, Tinker.SpellCount do	
		local stemp = ""
		if l < 10 then stemp = "0" end
		Tinker.Orders[i][l] =  Menu.AddOption({ "Hero Specific","Tinker", "Orders", "Order #" .. temp }, temp .. ". Spell cast #" .. stemp .. l, list, 1, Tinker.ItemsLength )
		for k, v in pairs(Tinker.Items) do
			Menu.SetValueName(Tinker.Orders[i][l], k, v)
		end
	end
	
end

-- Start
Tinker.ComboCurrentCast = {}
Tinker.ComboLastCastTime = {}
Tinker.Enabled = false
Tinker.FailTimeRearm = 0

function Tinker.OnGameStart()
	Tinker.ComboCurrentCast = {}
	Tinker.ComboLastCastTime = {}
	Tinker.Enabled = false
	Tinker.FailTimeRearm = 0
	Tinker.NextTime = 0
	Tinker.CurrentTime = 0
	Tinker.Hero = nil
	Tinker.LastCastAbility = nil
	Tinker.NearestEnemyHero = nil
	Tinker.NearestEnemyHeroPos = nil
	Tinker.ManaPoint = 0
	Tinker.TotalMagicDamage = 0
	Tinker.TotalMagicFactor = 0
	Tinker.TotalPureDamage = 0
	Tinker.TotalManaCost = 0
	Tinker.TotalDamage = 0
	Tinker.StopAnimation = false
end

function Tinker.OnUpdate()
	Tinker.Enabled = false
	Tinker.CurrentTime = GameRules.GetGameTime()
	if not Engine.IsInGame() then return end
	if not GameRules.GetGameState() == 5 then return end
	if not Menu.IsEnabled(Tinker.IsEnabled) then return end
	if Tinker.CurrentTime <= Tinker.NextTime then return end
	if Tinker.StopAnimation then Player.HoldPosition(Players.GetLocal(), Tinker.Hero, false) Tinker.StopAnimation = false end
	if Tinker.Hero == nil then Tinker.Hero = Heroes.GetLocal() end
	if NPC.GetUnitName(Tinker.Hero) ~= "npc_dota_hero_tinker" then return end
	if NPC.HasModifier(Tinker.Hero, "modifier_teleporting") then return end
	if not Entity.IsAlive(Tinker.Hero) then return end
	Tinker.Enabled = true
	Tinker.ManaPoint = NPC.GetMana(Tinker.Hero)
	-- Orders
	for i = 1, Tinker.OrdersCount do
		if Menu.IsKeyDown(Tinker.Orders[i][200])  and Menu.IsEnabled(Tinker.Orders[i][100]) and not Input.IsInputCaptured() then
			
			-- Check last cast time
			if (Tinker.ComboLastCastTime[i] ~= nil) then 
				if (Tinker.CurrentTime - Tinker.ComboLastCastTime[i]) > Menu.GetValue(Tinker.Orders[i][300]) then
					Tinker.ComboCurrentCast[i] = 0 
					Tinker.LastCastAbility = nil
				end
			end
			
			-- Current Cast Time
			Tinker.ComboLastCastTime[i] = Tinker.CurrentTime
			
			if Tinker.ManaPoint <= Menu.GetValue(Tinker.Orders[i][400]) then return end
			if NPC.IsChannellingAbility(Tinker.Hero) then return end
			if NPC.IsSilenced(Tinker.Hero) then return end
			if NPC.IsStunned(Tinker.Hero) then return end
			if Tinker.LastCastAbility ~= nil then 
				if Ability.IsChannelling(Tinker.LastCastAbility) 
				or Ability.IsInAbilityPhase(Tinker.LastCastAbility) 
				then return end 
			end
			
			Tinker.PreComboWombo(i)
			
			return
		end
	end
	
	-- Kill steal
	if Menu.IsEnabled(Tinker.KillSteal) then
		Tinker.StealCheck()
	end
end

function Tinker.PreComboWombo(order)
	-- Initialize cast order
	if ( Tinker.ComboCurrentCast[order] == nil ) then Tinker.ComboCurrentCast[order] = 0 end
	if ( Tinker.ComboCurrentCast[order] == (Tinker.SpellCount + 1) ) then Tinker.ComboCurrentCast[order] = 0
	else Tinker.ComboCurrentCast[order] = Tinker.ComboCurrentCast[order] + 1 end

	for i = 1, Tinker.SpellCount do
		if (i == Tinker.ComboCurrentCast[order]) then
			-- Cast Ability's
			local cast = Menu.GetValue(Tinker.Orders[order][i])
			local range = Menu.GetValue(Tinker.Orders[order][500])
			if cast == 1 then return end
			Tinker.ComboCast(cast, range)
		end
	end
end

function Tinker.StealCheck()
	local abilityLaser = NPC.GetAbilityByIndex(Tinker.Hero, 0)
    local abilityRockets = NPC.GetAbilityByIndex(Tinker.Hero, 1)
	local dmgLaser, dmgRockets = 0, 0
	local uniqRangeBonus = NPC.GetAbilityByIndex(Tinker.Hero, 10)	
	local uniqDamageBonus = NPC.GetAbilityByIndex(Tinker.Hero, 11)	

	if Ability.GetLevel(abilityLaser) > 0 then dmgLaser = Ability.GetLevelSpecialValueFor(abilityLaser, "laser_damage") end
	if Ability.GetLevel(abilityRockets) > 0 then dmgRockets = Ability.GetDamage(abilityRockets) end

	local totaldmg = dmgLaser + dmgRockets
	
	local abilityLens = NPC.GetItem(Tinker.Hero, "item_aether_lens", true)
		
	local laserRadius = 650
	local rocketsRadius = 2500
	
	if abilityLens then 
		laserRadius = laserRadius + 220
		rocketsRadius = rocketsRadius + 220
	end

	if Ability.GetLevel(uniqRangeBonus) == 1 then
		laserRadius = laserRadius + 75
		rocketsRadius = rocketsRadius + 75
	end
	
	if Ability.GetLevel(uniqDamageBonus) == 1 then
		totaldmg = totaldmg + 100
	end
	
	-- Auto Steal Laser + Rocket's
	for d, npc in pairs(Entity.GetHeroesInRadius(Tinker.Hero, laserRadius, Enum.TeamType.TEAM_ENEMY)) do	
		if Entity.IsHero(npc) 
			and not NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) 
			and not Entity.IsDormant(npc) 
			and Ability.IsReady(abilityLaser)
			and Ability.IsCastable(abilityLaser, Tinker.ManaPoint) 
		then
			local ttlDMG = NPC.GetMagicalArmorDamageMultiplier(npc) * totaldmg
			
			if Entity.GetHealth(npc) < ttlDMG then
				Ability.CastTarget(abilityLaser, npc)
				Tinker.LastCastAbility = abilityLaser
			end

			if Entity.GetHealth(npc) < ttlDMG and Entity.IsAlive(npc) and Ability.IsCastable(abilityRockets, Tinker.ManaPoint) and Ability.IsReady(abilityRockets)  then
				Ability.CastNoTarget(abilityRockets) 
				Tinker.LastCastAbility = abilityRockets
			end
		end
	end
	
	-- Auto Steal by Rockets
	for d, npc in pairs(Entity.GetHeroesInRadius(Tinker.Hero, rocketsRadius, Enum.TeamType.TEAM_ENEMY)) do	
		if Entity.IsHero(npc) and not NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not Entity.IsDormant(npc) then
			local ttlDMG = NPC.GetMagicalArmorDamageMultiplier(npc) * dmgRockets
			
			if Entity.GetHealth(npc) < ttlDMG and Ability.IsCastable(abilityRockets, Tinker.ManaPoint) and Ability.IsReady(abilityRockets) then
				Ability.CastNoTarget(abilityRockets) 
				Tinker.LastCastAbility = abilityRockets
			end
		end
	end
end

function Tinker.OnDraw()
	if not Menu.IsEnabled(Tinker.DMGCalculator) then return true end
	if not Engine.IsInGame() then Tinker.Hero = nil return end
	if Tinker.Hero == nil then return end
	if NPC.GetUnitName(Tinker.Hero) ~= "npc_dota_hero_tinker" then return end
	CalculateTotalDMG()
	if Tinker.TotalDamage == 0 then return end
	
	if Menu.GetValue(Tinker.DMGCalculator) == 2 then
		Renderer.SetDrawColor(0, 0, 0, 255)
		Renderer.DrawFilledRect(0, 250, 120, 30)
		Renderer.SetDrawColor(255, 255, 255, 255)
		Renderer.DrawTextCenteredX(Tinker.FontDMG, 60, 257, "damage: " .. math.floor(Tinker.TotalDamage), 1)
	end
	
	if Menu.GetValue(Tinker.DMGCalculator) == 3 then
		local x, y = Input.GetCursorPos()
		Renderer.SetDrawColor(0, 0, 0, 70)
		Renderer.DrawFilledRect(x - 60, y - 35, 120, 30)
		Renderer.SetDrawColor(255, 255, 255, 255)
		Renderer.DrawTextCenteredX(Tinker.FontDMG, x, y - 28, "damage: " .. math.floor(Tinker.TotalDamage), 1)
	end
	
	
	
	if not Menu.IsEnabled(Tinker.KillIndicator) then return true end

	local fullDMG = math.floor(Tinker.ManaPoint / Tinker.TotalManaCost) * Tinker.TotalDamage
	
	for i = 1, Heroes.Count() do
		local hero = Heroes.Get(i)
		if	not Entity.IsSameTeam(Tinker.Hero, hero) 
			and Entity.IsAlive(hero)
			and not Entity.IsDormant(hero)
			then
			local hp = Entity.GetHealth(hero)
			local dmg = fullDMG * NPC.GetMagicalArmorDamageMultiplier(hero)
			if dmg > hp then
				local pos = Entity.GetAbsOrigin(hero)
				local x, y, visible = Renderer.WorldToScreen(pos)
				if visible then
					Renderer.SetDrawColor(255, 0, 0, 255)
					Renderer.DrawTextCentered(Tinker.FontKill, x, (y + 20), "*")
				end
			end
		end
	end
	
end

function Tinker.OnPrepareUnitOrders(orders)
	if not Tinker.Enabled then return true end
	
	if	orders.ability ~= nil 
		and Entity.IsAbility(orders.ability) 
	then
		if orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET then
			if Menu.IsEnabled(Tinker.FailRockets) then
				if Ability.GetName(orders.ability) == "tinker_heat_seeking_missile"
				then
					local c = #Entity.GetHeroesInRadius(Tinker.Hero, Ability.GetCastRange(orders.ability), Enum.TeamType.TEAM_ENEMY)
					if c == 0 then	return false end
				end
			end
			
			if Menu.IsEnabled(Tinker.FailRearm) then
				if Ability.GetName(orders.ability) == "tinker_rearm"
				then
					if GameRules.GetGameTime() < Tinker.FailTimeRearm then return false end
					local abilityRearm = NPC.GetAbility(Tinker.Hero, 'tinker_rearm')
					if Ability.IsChannelling(abilityRearm) then
						return false
					else
						Tinker.FailTimeRearm = Ability.GetCastPoint(orders.ability) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) + GameRules.GetGameTime() + 0.1
					end

					if Menu.IsEnabled(Tinker.FailRearmAI) then
						local ret = false
						for i = 0, 5 do 
							local item = NPC.GetItemByIndex(Tinker.Hero, i)
							local ab = NPC.GetAbilityByIndex(Tinker.Hero, i)
							
							if ab ~= nil and Ability.GetCooldown(ab) > 0 then
								ret = true
							end
							
							if item ~= nil and Ability.GetCooldown(item) > 0 then
								ret = true
							end
						end
						
						if not ret then return ret end
					end
				end
				
				-- Tinker.ExtraSoul
				-- Tinker.ExtraBottle
			end
		end
		
		
		if Menu.IsEnabled(Tinker.ExtraSoul) then
			local sr = NPC.GetItem(Tinker.Hero, "item_soul_ring", true)
			if	sr ~= nil 
				and Ability.IsCastable(sr, Tinker.ManaPoint)
				and Entity.GetHealth(Tinker.Hero) > Menu.GetValue(Tinker.ExtraSoulT)
			then
				Ability.CastNoTarget(sr)
			end
		end
		
		if Menu.IsEnabled(Tinker.ExtraBottle) then
			local bott = NPC.GetItem(Tinker.Hero, "item_bottle", true)
			if	bott ~= nil 
				and Ability.IsCastable(bott, Tinker.ManaPoint)
				and (Entity.GetHealth(Tinker.Hero) < Entity.GetMaxHealth(Tinker.Hero) or Tinker.ManaPoint < NPC.GetMaxMana(Tinker.Hero))
				and not NPC.HasModifier(Tinker.Hero, "modifier_bottle_regeneration")
			then
				Ability.CastNoTarget(bott)
			end
		end
	end
	
	
	return true
end

function CalculateTotalDMG()
	if Tinker.Hero == nil then return end
	
	Tinker.TotalPureDamage = 0
	Tinker.TotalMagicDamage = 0
	Tinker.TotalMagicFactor = 0
	Tinker.TotalManaCost = 0
	local xfactor = 1

	local laser = NPC.GetAbilityByIndex(Tinker.Hero, 0)
    local rocket = NPC.GetAbilityByIndex(Tinker.Hero, 1)
    local rearm = NPC.GetAbility(Tinker.Hero, 'tinker_rearm')
	local uniqLaserBonus = NPC.GetAbilityByIndex(Tinker.Hero, 11)	
	local uniqDamageBonus = NPC.GetAbilityByIndex(Tinker.Hero, 7)	
		
	xfactor = xfactor + ((Hero.GetIntellectTotal(Tinker.Hero) / 16) / 100)
	
	if Ability.GetLevel(uniqDamageBonus) == 1 then
		xfactor = xfactor + 0.04
	end
	
	Tinker.TotalMagicFactor = xfactor
	
	local tempVeil = NPC.GetItem(Tinker.Hero, "item_veil_of_discord", true)
	if tempVeil
	then 
		Tinker.TotalMagicFactor = Tinker.TotalMagicFactor + 0.25 
		Tinker.TotalManaCost = Tinker.TotalManaCost + Ability.GetManaCost(tempVeil)
	end
	
	if NPC.GetItem(Tinker.Hero, "item_aether_lens", true)
	then 
		Tinker.TotalMagicFactor = Tinker.TotalMagicFactor + 0.05 
	end
	
	
	local tempEthereal = NPC.GetItem(Tinker.Hero, "item_ethereal_blade", true)
	if tempEthereal
	then 
		Tinker.TotalMagicFactor = Tinker.TotalMagicFactor + 0.4 
		Tinker.TotalMagicDamage = Tinker.TotalMagicDamage + (75 + (Hero.GetIntellectTotal(Tinker.Hero) * 2))
		Tinker.TotalManaCost = Tinker.TotalManaCost + Ability.GetManaCost(tempEthereal)
	end

	local tempShivas = NPC.GetItem(Tinker.Hero, "item_shivas_guard", true)
	if	tempShivas
	then 
		Tinker.TotalMagicDamage = Tinker.TotalMagicDamage + Ability.GetLevelSpecialValueFor(tempShivas, "blast_damage")
		Tinker.TotalManaCost = Tinker.TotalManaCost + Ability.GetManaCost(tempShivas)
	end

	for i = 0, 5 do
		local dagon = NPC.GetItem(Tinker.Hero, "item_dagon_" .. i, true)
		if i == 0 then dagon = NPC.GetItem(Tinker.Hero, "item_dagon", true) end
        if dagon then
			Tinker.TotalMagicDamage = Tinker.TotalMagicDamage + Ability.GetLevelSpecialValueFor(dagon, "damage")
			Tinker.TotalManaCost = Tinker.TotalManaCost + Ability.GetManaCost(dagon)
		end
    end	
		
	if Ability.GetLevel(laser) > 0 then Tinker.TotalPureDamage = Tinker.TotalPureDamage + Ability.GetLevelSpecialValueFor(laser, "laser_damage") end
	if Ability.GetLevel(uniqLaserBonus) == 1 then
		Tinker.TotalPureDamage = Tinker.TotalPureDamage + 100
	end

	if Ability.GetLevel(rocket) > 0 then Tinker.TotalMagicDamage = Tinker.TotalMagicDamage + Ability.GetDamage(rocket) end
		
	Tinker.TotalManaCost = Tinker.TotalManaCost + Ability.GetManaCost(laser)
	Tinker.TotalManaCost = Tinker.TotalManaCost + Ability.GetManaCost(rocket)
	Tinker.TotalManaCost = Tinker.TotalManaCost + Ability.GetManaCost(rearm)
	
	Tinker.TotalDamage = (Tinker.TotalMagicDamage * Tinker.TotalMagicFactor) + Tinker.TotalPureDamage
end

function Tinker.ComboCast(cast, range)
	if range ~= 0 then
		Tinker.NearestEnemyHero = Input.GetNearestHeroToCursor(Entity.GetTeamNum(Tinker.Hero), Enum.TeamType.TEAM_ENEMY)	
		if Tinker.NearestEnemyHero == nil then return end
		if	not Tinker.NearestEnemyHero
			or (not NPC.IsPositionInRange(Tinker.NearestEnemyHero, Input.GetWorldCursorPos(), range, 0) and range ~= 0) then
			return
		end
		Tinker.NearestEnemyHeroPos = Entity.GetAbsOrigin(Tinker.NearestEnemyHero)
	end
	
	if cast == 2 then 
		Ghost()
	return end
	
	if cast == 3 then 
		Soul()
	return end
	
	if cast == 4 then 
		Hex()
	return end
	
	if cast == 5 then 
		Veil()
	return end
	
	if cast == 6 then 
		Ethereal()
	return end
	
	if cast == 7 then 
		Orchid()
	return end
	
	if cast == 8 then 
		Blood()
	return end
	
	if cast == 9 then 
		Rod()
	return end
	
	if cast == 10 then 
		Bottle()
	return end
	
	if cast == 11 then 
		Dagon()
	return end
	
	if cast == 12 then 
		Shiva()
	return end
	
	if cast == 13 then 
		BootsMouse()
	return end
	
	if cast == 14 then 
		BootsBase()
	return end
	
	if cast == 15 then 
		EulsEnemy()
	return end
	
	if cast == 16 then 
		EulsSelf()
	return end
	
	if cast == 17 then 
		BlinkToMouse()
	return end
	
	if cast == 18 then 
		BlinkToBase()
	return end
	
	if cast == 19 then 
		Lotus()
	return end
	
	if cast == 20 then 
		Courage()
	return end
	
	if cast == 21 then 
		Solar()
	return end
	
	if cast == 22 then 
		Delay()
	return end
	
	if cast == (Tinker.ItemsLength - 4) then 
		Laser()
	return end
	
	if cast == (Tinker.ItemsLength - 3) then 
		Rockets()
	return end
	
	if cast == (Tinker.ItemsLength - 2) then 
		March()
	return end
	
	if cast == (Tinker.ItemsLength - 1) then 
		Rearm()
	return end

	if cast == Tinker.ItemsLength then 
		SafeTP()
	return end

end

-- Abilities

function Delay()
	Tinker.NextTime = Tinker.CurrentTime + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
end

function Solar()
    local abilitySolar = NPC.GetItem(Tinker.Hero, "item_solar_crest", true)
	if	abilitySolar 
		and Ability.IsCastable(abilitySolar, Tinker.ManaPoint)
		and Tinker.NearestEnemyHero
		and not NPC.HasState(Tinker.NearestEnemyHero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE)
		and NPC.IsEntityInRange(Tinker.NearestEnemyHero, Tinker.Hero, Ability.GetCastRange(abilitySolar)) 
		and Tinker.LastCastAbility ~= abilitySolar
	then 
		Ability.CastTarget(abilitySolar, Tinker.NearestEnemyHero)
		Tinker.LastCastAbility = abilitySolar
		Tinker.NextTime = Tinker.CurrentTime + Ability.GetCastPoint(abilitySolar) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
	return end
end

function Courage()
    local abilityCourage = NPC.GetItem(Tinker.Hero, "item_medallion_of_courage", true)
	if	abilityCourage 
		and Ability.IsCastable(abilityCourage, Tinker.ManaPoint)
		and Tinker.NearestEnemyHero
		and not NPC.HasState(Tinker.NearestEnemyHero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE)
		and NPC.IsEntityInRange(Tinker.NearestEnemyHero, Tinker.Hero, Ability.GetCastRange(abilityCourage)) 
		and Tinker.LastCastAbility ~= abilityCourage
	then 
		Ability.CastTarget(abilityCourage, Tinker.NearestEnemyHero) 
		Tinker.LastCastAbility = abilityCourage
		Tinker.NextTime = Tinker.CurrentTime + Ability.GetCastPoint(abilityCourage) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
	return end
end

function Lotus()
    local abilityLotus = NPC.GetItem(Tinker.Hero, "item_lotus_orb", true)
	if	abilityLotus 
		and Ability.IsCastable(abilityLotus, Tinker.ManaPoint)
		and Tinker.LastCastAbility ~= abilityLotus
	then 
		Ability.CastTarget(abilityLotus, Tinker.Hero) 
		Tinker.LastCastAbility = abilityLotus
		Tinker.NextTime = Tinker.CurrentTime + Ability.GetCastPoint(abilityLotus) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
	return end
end

function EulsSelf()
    local abilityEul = NPC.GetItem(Tinker.Hero, "item_cyclone", true)
	if	abilityEul 
		and Ability.IsCastable(abilityEul, Tinker.ManaPoint)
		and Tinker.LastCastAbility ~= abilityEul
	then 
		Ability.CastTarget(abilityEul, Tinker.Hero) 
		Tinker.LastCastAbility = abilityEul
		Tinker.NextTime = Tinker.CurrentTime + Ability.GetCastPoint(abilityEul) + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
	return end
end

function EulsEnemy()
    local abilityEul = NPC.GetItem(Tinker.Hero, "item_cyclone", true)
	if	abilityEul 
		and Ability.IsCastable(abilityEul, Tinker.ManaPoint)
		and Tinker.NearestEnemyHero
		and not NPC.HasState(Tinker.NearestEnemyHero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE)
		and NPC.IsEntityInRange(Tinker.NearestEnemyHero, Tinker.Hero, Ability.GetCastRange(abilityEul)) 
		and Tinker.LastCastAbility ~= abilityEul
	then 
		Ability.CastTarget(abilityEul, Tinker.NearestEnemyHero) 
		Tinker.LastCastAbility = abilityEul
		Tinker.NextTime = Tinker.CurrentTime + Ability.GetCastPoint(abilityEul) + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
	return end
end

function BootsBase()
	for i = 0, 2 do
        local abilityBootsMouse = NPC.GetItem(Tinker.Hero, "item_travel_boots_" .. i, true)
		if i == 0 then abilityBootsMouse = NPC.GetItem(Tinker.Hero, "item_travel_boots", true) end

		if	abilityBootsMouse 
			and Ability.IsCastable(abilityBootsMouse, Tinker.ManaPoint)
			and Tinker.LastCastAbility ~= abilityBootsMouse
		then 
			for i = 1, NPCs.Count() do 
				local npc = NPCs.Get(i)

				if Entity.IsSameTeam(Tinker.Hero, npc) and NPC.IsStructure(npc) then
					local name = NPC.GetUnitName(npc)

					if name ~= nil and name == "dota_fountain" then
						Ability.CastPosition(abilityBootsMouse, NPC.GetAbsOrigin(npc)) 
						Tinker.LastCastAbility = abilityBootsMouse
						Tinker.NextTime = Tinker.CurrentTime + Ability.GetCastPoint(abilityBootsMouse) + 1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
					return end
				end
			end

		return end
	end
end

function BootsMouse()
	for i = 0, 2 do
        local abilityBootsMouse = NPC.GetItem(Tinker.Hero, "item_travel_boots_" .. i, true)
		if i == 0 then abilityBootsMouse = NPC.GetItem(Tinker.Hero, "item_travel_boots", true) end

		if	abilityBootsMouse 
			and Ability.IsCastable(abilityBootsMouse, Tinker.ManaPoint)
			and Tinker.LastCastAbility ~= abilityBootsMouse
		then 
			Ability.CastPosition(abilityBootsMouse, Input.GetWorldCursorPos()) 
			Tinker.LastCastAbility = abilityBootsMouse
			Tinker.NextTime = Tinker.CurrentTime + Ability.GetCastPoint(abilityBootsMouse) + 1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
		return end
	end
end

function BlinkToBase()
    local abilityBlink = NPC.GetItem(Tinker.Hero, "item_blink", true)
	if	abilityBlink 
		and Ability.IsCastable(abilityBlink, Tinker.ManaPoint)
		and Tinker.LastCastAbility ~= abilityBlink
	then 
		for i = 1, NPCs.Count() do 
			local npc = NPCs.Get(i)

			if Entity.IsSameTeam(Tinker.Hero, npc) and NPC.IsStructure(npc) then
				local name = NPC.GetUnitName(npc)

				if name ~= nil and name == "dota_fountain" then
					Ability.CastPosition(abilityBlink, NPC.GetAbsOrigin(npc)) 
					Tinker.LastCastAbility = abilityBlink
					Tinker.NextTime = Tinker.CurrentTime + Ability.GetCastPoint(abilityBlink) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
				return end
			end
		end
	return end
end

function BlinkToMouse()
    local abilityBlink = NPC.GetItem(Tinker.Hero, "item_blink", true)
	if	abilityBlink 
		and Ability.IsCastable(abilityBlink, Tinker.ManaPoint)
		and Tinker.LastCastAbility ~= abilityBlink
	then 
		Ability.CastPosition(abilityBlink, Input.GetWorldCursorPos()) 
		Tinker.LastCastAbility = abilityBlink
		Tinker.NextTime = Tinker.CurrentTime + Ability.GetCastPoint(abilityBlink) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) + 0.2
		Tinker.StopAnimation = true
	return end
end

function Ghost()
    local abilityGhost = NPC.GetItem(Tinker.Hero, "item_ghost", true)
	if	abilityGhost 
		and Ability.IsCastable(abilityGhost, Tinker.ManaPoint)
		and Tinker.LastCastAbility ~= abilityGhost
	then 
		Ability.CastNoTarget(abilityGhost) 
		Tinker.LastCastAbility = abilityGhost
		Tinker.NextTime = Tinker.CurrentTime + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
	return end
end

function Soul()
    local abilitySoul = NPC.GetItem(Tinker.Hero, "item_soul_ring", true)
	if	abilitySoul 
		and Ability.IsCastable(abilitySoul, Tinker.ManaPoint)
		and Tinker.LastCastAbility ~= abilitySoul
	then 
		Ability.CastNoTarget(abilitySoul) 
		Tinker.LastCastAbility = abilitySoul
		Tinker.NextTime = Tinker.CurrentTime + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
		Tinker.StopAnimation = true
	return end
end

function Hex()
    local abilityHex = NPC.GetItem(Tinker.Hero, "item_sheepstick", true)
	if	abilityHex 
		and Ability.IsCastable(abilityHex, Tinker.ManaPoint)
		and Tinker.NearestEnemyHero
		and not NPC.HasState(Tinker.NearestEnemyHero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE)
		and NPC.IsEntityInRange(Tinker.NearestEnemyHero, Tinker.Hero, Ability.GetCastRange(abilityHex)) 
		and Tinker.LastCastAbility ~= abilityHex
	then 
		Ability.CastTarget(abilityHex, Tinker.NearestEnemyHero) 
		Tinker.LastCastAbility = abilityHex
		Tinker.NextTime = Tinker.CurrentTime + Ability.GetCastPoint(abilityHex) + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
		Tinker.StopAnimation = true
	return end
end

function Veil()
    local abilityVeil = NPC.GetItem(Tinker.Hero, "item_veil_of_discord", true)
	if	abilityVeil 
		and Ability.IsCastable(abilityVeil, Tinker.ManaPoint)
		and Tinker.NearestEnemyHero
		and not NPC.HasState(Tinker.NearestEnemyHero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE)
		and NPC.IsEntityInRange(Tinker.NearestEnemyHero, Tinker.Hero, Ability.GetCastRange(abilityVeil)) 
		and Tinker.LastCastAbility ~= abilityVeil
	then 
		Ability.CastPosition(abilityVeil, Tinker.NearestEnemyHeroPos) 
		Tinker.LastCastAbility = abilityVeil
		Tinker.NextTime = Tinker.CurrentTime + Ability.GetCastPoint(abilityVeil) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) + 0.1
		Tinker.StopAnimation = true
	return end
end

function Ethereal()
    local abilityEthereal = NPC.GetItem(Tinker.Hero, "item_ethereal_blade", true)	
	if	abilityEthereal 
		and Ability.IsCastable(abilityEthereal, Tinker.ManaPoint)
		and Tinker.NearestEnemyHero
		and not NPC.HasState(Tinker.NearestEnemyHero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE)
		and NPC.IsEntityInRange(Tinker.NearestEnemyHero, Tinker.Hero, Ability.GetCastRange(abilityEthereal)) 
		and Tinker.LastCastAbility ~= abilityEthereal
	then 
		Ability.CastTarget(abilityEthereal, Tinker.NearestEnemyHero) 
		Tinker.LastCastAbility = abilityEthereal
		Tinker.NextTime = Tinker.CurrentTime + Ability.GetCastPoint(abilityEthereal) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) + 0.2
		Tinker.StopAnimation = true
	return end
end

function Orchid()
    local abilityOrchid = NPC.GetItem(Tinker.Hero, "item_orchid", true)
	if	abilityOrchid 
		and Ability.IsCastable(abilityOrchid, Tinker.ManaPoint)
		and Tinker.NearestEnemyHero
		and not NPC.HasState(Tinker.NearestEnemyHero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE)
		and NPC.IsEntityInRange(Tinker.NearestEnemyHero, Tinker.Hero, Ability.GetCastRange(abilityOrchid)) 
		and Tinker.LastCastAbility ~= abilityOrchid
	then 
		Ability.CastTarget(abilityOrchid, Tinker.NearestEnemyHero) 
		Tinker.LastCastAbility = abilityOrchid
		Tinker.NextTime = Tinker.CurrentTime + Ability.GetCastPoint(abilityOrchid) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
	return end
end

function Blood()
    local abilityBlood = NPC.GetItem(Tinker.Hero, "item_bloodthorn", true)
	if	abilityBlood
		and Ability.IsCastable(abilityBlood, Tinker.ManaPoint)
		and Tinker.NearestEnemyHero
		and not NPC.HasState(Tinker.NearestEnemyHero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE)
		and NPC.IsEntityInRange(Tinker.NearestEnemyHero, Tinker.Hero, Ability.GetCastRange(abilityBlood)) 
		and Tinker.LastCastAbility ~= abilityBlood
	then 
		Ability.CastTarget(abilityBlood, Tinker.NearestEnemyHero) 
		Tinker.LastCastAbility = abilityBlood
		Tinker.NextTime = Tinker.CurrentTime + Ability.GetCastPoint(abilityBlood) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
	return end
end

function Rod()
    local abilityRod = NPC.GetItem(Tinker.Hero, "item_rod_of_atos", true)
	if	abilityRod 
		and Ability.IsCastable(abilityRod, Tinker.ManaPoint)
		and Tinker.NearestEnemyHero
		and not NPC.HasState(Tinker.NearestEnemyHero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE)
		and NPC.IsEntityInRange(Tinker.NearestEnemyHero, Tinker.Hero, Ability.GetCastRange(abilityRod)) 
		and Tinker.LastCastAbility ~= abilityRod
	then 
		Ability.CastTarget(abilityRod, Tinker.NearestEnemyHero) 
		Tinker.LastCastAbility = abilityRod
		Tinker.NextTime = Tinker.CurrentTime + Ability.GetCastPoint(abilityRod) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
	return end
end

function Bottle()
    local abilityBottle = NPC.GetItem(Tinker.Hero, "item_bottle", true)
    if	abilityBottle 
		and Tinker.LastCastAbility ~= abilityBottle
	then 
		Ability.CastNoTarget(abilityBottle)
		Tinker.LastCastAbility = abilityBottle
		Tinker.NextTime = Tinker.CurrentTime + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
	return end
end

function Dagon()
	for i = 0, 5 do
        local abilityDagon = NPC.GetItem(Tinker.Hero, "item_dagon_" .. i, true)
		if i == 0 then abilityDagon = NPC.GetItem(Tinker.Hero, "item_dagon", true) end

		if	abilityDagon
			and Ability.IsCastable(abilityDagon, Tinker.ManaPoint)
			and Tinker.NearestEnemyHero
			and not NPC.HasState(Tinker.NearestEnemyHero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE)
			and NPC.IsEntityInRange(Tinker.NearestEnemyHero, Tinker.Hero, Ability.GetCastRange(abilityDagon)) 
			and Tinker.LastCastAbility ~= abilityDagon
		then 
			Ability.CastTarget(abilityDagon, Tinker.NearestEnemyHero) 
			Tinker.LastCastAbility = abilityDagon
			Tinker.NextTime = Tinker.CurrentTime + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			Tinker.StopAnimation = true
		return end
	end
end

function Shiva()
	local abilityShiva = NPC.GetItem(Tinker.Hero, "item_shivas_guard", true)
	if	abilityShiva
		and Ability.IsCastable(abilityShiva, Tinker.ManaPoint)
		and Tinker.LastCastAbility ~= abilityShiva
	then 
		Ability.CastNoTarget(abilityShiva) 
		Tinker.LastCastAbility = abilityShiva
		Tinker.NextTime = Tinker.CurrentTime + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
		Tinker.StopAnimation = true
	return end
end

function Laser()
    local abilityLaser = NPC.GetAbilityByIndex(Tinker.Hero, 0)
	if not abilityLaser then return end
	
	if	Ability.IsCastable(abilityLaser, Tinker.ManaPoint)
		and Tinker.NearestEnemyHero
		and not NPC.HasState(Tinker.NearestEnemyHero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE)
		and NPC.IsEntityInRange(Tinker.NearestEnemyHero, Tinker.Hero, Ability.GetCastRange(abilityLaser)) 
		and Tinker.LastCastAbility ~= abilityLaser
	then 
		Ability.CastTarget(abilityLaser, Tinker.NearestEnemyHero) 
		Tinker.LastCastAbility = abilityLaser
		Tinker.NextTime = Tinker.CurrentTime + Ability.GetCastPoint(abilityLaser) + 0.2 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
		Tinker.StopAnimation = true
	return end
end

function Rockets()
    local abilityRockets = NPC.GetAbilityByIndex(Tinker.Hero, 1)
	if not abilityRockets then return end
	
	if	Ability.IsCastable(abilityRockets, Tinker.ManaPoint)
		and Tinker.NearestEnemyHero
		and not NPC.HasState(Tinker.NearestEnemyHero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE)
		and NPC.IsEntityInRange(Tinker.NearestEnemyHero, Tinker.Hero, Ability.GetCastRange(abilityRockets)) 
		and Tinker.LastCastAbility ~= abilityRockets
	then 
		Ability.CastNoTarget(abilityRockets) 
		Tinker.LastCastAbility = abilityRockets
		Tinker.NextTime = Tinker.CurrentTime + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) + 0.1
		Tinker.StopAnimation = true
	return end
end

function March()
    local abilityMarch = NPC.GetAbilityByIndex(Tinker.Hero, 2)
	if not abilityMarch then return end

	if	Ability.IsCastable(abilityMarch, Tinker.ManaPoint)
		and Tinker.LastCastAbility ~= abilityMarch
	then 
		Ability.CastPosition(abilityMarch, NPC.GetAbsOrigin(Tinker.Hero))
		Tinker.LastCastAbility = abilityMarch
		Tinker.NextTime = Tinker.CurrentTime + Ability.GetCastPoint(abilityMarch) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
	return end
end

function Rearm()
    local abilityRearm = NPC.GetAbility(Tinker.Hero, 'tinker_rearm')
	if not abilityRearm then return end
	
    if	Ability.IsCastable(abilityRearm, Tinker.ManaPoint)
		and Tinker.LastCastAbility ~= abilityRearm
	then 
		Ability.CastNoTarget(abilityRearm)
		Tinker.LastCastAbility = abilityRearm
		Tinker.NextTime = Tinker.CurrentTime + 0.5 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
	return end
end

function SafeTP()
    local abilityBlink = NPC.GetItem(Tinker.Hero, "item_blink", true)
	if	abilityBlink 
		and Ability.IsCastable(abilityBlink, Tinker.ManaPoint)
		and Tinker.LastCastAbility ~= abilityBlink
	then 
		local t = false
		for k, v in pairs(Tinker.SafePos) do 
			if	Input.GetWorldCursorPos():Distance(v):Length() < 1200
			then
				t = true
				Ability.CastPosition(abilityBlink, v)
			break end
		end
		
		if not t then Ability.CastPosition(abilityBlink, Input.GetWorldCursorPos()) end
		Tinker.LastCastAbility = abilityBlink
		Tinker.NextTime = Tinker.CurrentTime + Ability.GetCastPoint(abilityBlink) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) + 0.2
		Tinker.StopAnimation = true
	return end
end

-- Additionally

function Length(t)
	count = 0
	for k,v in pairs(t) do
		 count = count + 1
	end
	
	return count
end

return Tinker
