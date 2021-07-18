local Windrunner = {}

Windrunner.optionKey = Menu.AddKeyOption({"Hero Specific","Windrunner"},"Combo Key",Enum.ButtonCode.KEY_D)
Windrunner.optionEnableBlink = Menu.AddOption({"Hero Specific","Windrunner"},"Use Blink","Enable Or Disable ")
Windrunner.optionEnable = Menu.AddOption({"Hero Specific","Windrunner"},"Enabled","Enable Or Disable ")
Windrunner.optionEnableBKB= Menu.AddOption({"Hero Specific","Windrunner"},"Use Black King Bar","Enable Or Disable ")
Windrunner.optionEnableOrchid = Menu.AddOption({"Hero Specific","Windrunner"},"Use Orchid","Enable Or Disable ")
Windrunner.optionEnableMjollnir = Menu.AddOption({"Hero Specific","Windrunner"},"Use Mjollnir","Enable Or Disable ")
Windrunner.optionEnableBlood = Menu.AddOption({"Hero Specific","Windrunner"},"Use BloodThorn","Enable Or Disable ")
Windrunner.optionEnableHex = Menu.AddOption({"Hero Specific","Windrunner"},"Use Hex","Enable Or Disable ")
--DefendWR
Windrunner.optionRadius = Menu.AddOption({ "Hero Specific","Windrunner"}, "Radius Windrun","",0,1200,50)
--Menu skills
Windrunner.optionEnableShackleshot = Menu.AddOption({ "Hero Specific","Windrunner","Skills"},"Use Shackleshot","Enable Or Disable")
Windrunner.optionEnableWindrun = Menu.AddOption({ "Hero Specific","Windrunner","Skills"},"Use Windrun","Enable Or Disable")
--SnowLinken Items
Windrunner.optionEnableForceStaff = Menu.AddOption({ "Hero Specific","Windrunner","SnowLinkenItem"},"Use ForceStaff","Enable Or Disable")
Windrunner.optionEnableDiffusalBlade1 = Menu.AddOption({ "Hero Specific","Windrunner","SnowLinkenItem"},"Use Diffusal Blade 1","Enable Or Disable")
Windrunner.optionEnableDiffusalBlade2 = Menu.AddOption({ "Hero Specific","Windrunner","SnowLinkenItem"},"Use Diffusal Blade 2","Enable Or Disable")
Windrunner.optionEnableHurrican_Pike = Menu.AddOption({ "Hero Specific","Windrunner","SnowLinkenItem"},"Use Hurrican Pike","Enable Or Disable")
Windrunner.optionEnableEuL = Menu.AddOption({ "Hero Specific","Windrunner","SnowLinkenItem"},"Use EuL","Enable Or Disable")
Windrunner.optionEnableDagon = Menu.AddOption({ "Hero Specific","Windrunner","SnowLinkenItem"},"Use Dagon","Enable Or Disable")

function Windrunner.OnUpdate()
 if not Menu.IsEnabled(Windrunner.optionEnable) then return true end	
 local myHero = Heroes.GetLocal()
 if NPC.GetUnitName(myHero) ~= "npc_dota_hero_windrunner" then return end
    local myTeam = Entity.GetTeamNum(myHero)
    if myHero == nill then return end
 local mousePos = Input.GetWorldCursorPos()
 local myMana = NPC.GetMana(myHero)
 local heroPos = Entity.GetAbsOrigin(myHero)
 local hero = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
 local Windrun = NPC.GetAbilityByIndex(myHero, 2)
  for i= 1, Heroes.Count() do
  local enemy = Heroes.Get(i)
  local sameTeam = Entity.GetTeamNum(enemy) == myTeam
  if not sameTeam and not NPC.IsDormant(enemy) and Entity.GetHealth(enemy) > 0 then
  if Windrun and Ability.IsCastable(Windrun, myMana) and not NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE)and NPC.IsEntityInRange(myHero, enemy, Menu.GetValue(Windrunner.optionRadius)) then Ability.CastNoTarget(Windrun) return end
  end
  end
	if Menu.IsKeyDown(Windrunner.optionKey)then
    Windrunner.Combo()
 end
end

function Windrunner.Combo()
  local myHero = Heroes.GetLocal()
  local mousePos = Input.GetWorldCursorPos()
  local myMana = NPC.GetMana(myHero)
  local heroPos = Entity.GetAbsOrigin(myHero)
  local hero = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
local hero = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY) --!
if not hero then return end

--Ability
   local Shackleshot = NPC.GetAbilityByIndex(myHero, 0)
   
   local Windrun = NPC.GetAbilityByIndex(myHero, 2)

   local FocusFire = NPC.GetAbilityByIndex(myHero, 3)
   
   local myMana = NPC.GetMana(myHero)

--Items
   local blink = NPC.GetItem(myHero,"item_blink", true)
   local BKB = NPC.GetItem(myHero,"item_black_king_bar", true)
   local Hex = NPC.GetItem(myHero,"item_sheepstick", true)
   local Orchid = NPC.GetItem(myHero,"item_orchid", true)
   local Blood = NPC.GetItem(myHero,"item_bloodthorn", true)
   local Mjollnir = NPC.GetItem(myHero,"item_mjollnir", true)
   local DiffusalBlade = NPC.GetItem(myHero,"item_diffusal_blade", true)
   local DiffusalBlade2 = NPC.GetItem(myHero,"item_diffusal_blade_2", true)
   local ForceStaff = NPC.GetItem(myHero,"item_force_staff", true)
   local EuL = NPC.GetItem(myHero,"item_cyclone", true)
   local Pike = NPC.GetItem(myHero,"item_hurricane_pike", true)                                           
   
--Radius  
  if blink and Menu.IsEnabled(Windrunner.optionEnableBlink) and Ability.IsCastable(blink, myMana) and Menu.IsEnabled(Windrunner.optionEnableBlink) then Ability.CastPosition(blink, mousePos)  return end
  for i = 0, 5 do
        local dagon = NPC.GetItem(myHero, "item_dagon_" .. i, true)
  if i == 0 then dagon = NPC.GetItem(myHero, "item_dagon", true) end
  if dagon and hero and Ability.IsCastable(dagon, myMana) and hero and Menu.IsEnabled(Windrunner.optionEnableDagon) and NPC.IsLinkensProtected(hero) then Ability.CastTarget(dagon, hero) return end
    end
--Combo	
  if EuL and NPC.IsLinkensProtected(hero) and Menu.IsEnabled(Windrunner.optionEnableEuL) and not NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and Ability.IsCastable(EuL, myMana) then Ability.CastTarget(EuL, hero) return end
  if DiffusalBlade2 and NPC.IsLinkensProtected(hero) and Menu.IsEnabled(Windrunner.optionEnableDiffusalBlade2) and not NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and Ability.IsCastable(DiffusalBlade2, myMana) then Ability.CastTarget(DiffusalBlade2, hero) return end  
  if ForceStaff and NPC.IsLinkensProtected(hero) and Menu.IsEnabled(Windrunner.optionEnableForceStaff) and not NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and Ability.IsCastable(ForceStaff, myMana) then Ability.CastTarget(ForceStaff, hero) return end
  if DiffusalBlade2 and NPC.IsLinkensProtected(hero) and Menu.IsEnabled(Windrunner.optionEnableDiffusalBlade2) and not NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and Ability.IsCastable(DiffusalBlade2, myMana) then Ability.CastTarget(DiffusalBlade2, hero) return end  
  if DiffusalBlade and NPC.IsLinkensProtected(hero) and Menu.IsEnabled(Windrunner.optionEnableDiffusalBlade1) and not NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and Ability.IsCastable(DiffusalBlade, myMana) then Ability.CastTarget(DiffusalBlade, hero) return end
  if Pike and NPC.IsLinkensProtected(hero) and Menu.IsEnabled(Windrunner.optionEnableHurrican_Pike) and not NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and Ability.IsCastable(Pike, myMana) then Ability.CastTarget(Pike, hero) return end
  if BKB and Ability.IsCastable(BKB, 0) and Menu.IsEnabled(Windrunner.optionEnableBKB) then Ability.CastNoTarget(BKB) return end
  if Shackleshot and not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(Windrunner.optionEnableShackleshot) and not NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and Ability.IsCastable(Shackleshot, myMana) then Ability.CastTarget(Shackleshot, hero) return end
  if Windrun and Menu.IsEnabled(Windrunner.optionEnableWindrun) and Ability.IsCastable(Windrun, myMana) then Ability.CastNoTarget(Windrun) return end
  if Hex and not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(Windrunner.optionEnableHex) and not NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and Ability.IsCastable(Hex, myMana) then Ability.CastTarget(Hex, hero) return end
  if Orchid and not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(Windrunner.optionEnableOrchid) and not NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and Ability.IsCastable(Orchid, myMana) then Ability.CastTarget(Orchid, hero) return end
  if Blood and not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(Windrunner.optionEnableBlood) and not NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and Ability.IsCastable(Blood, myMana) then Ability.CastTarget(Blood, hero) return end
  if Mjollnir and not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(Windrunner.optionEnableMjollnir) and Ability.IsCastable(Mjollnir, myMana) then Ability.CastTarget(Mjollnir, myHero) return end
  if FocusFire and not NPC.IsLinkensProtected(hero) and Ability.IsCastable(FocusFire, myMana) then Ability.CastTarget(FocusFire, hero) return end
end

return Windrunner