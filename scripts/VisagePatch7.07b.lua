local AutoVisage = {}

AutoVisage.AttackModeKey = Menu.AddKeyOption({"Hero Specific", "Visage"}, "Combo Mode Switch Key", Enum.ButtonCode.KEY_NONE)
AutoVisage.AttackKey = Menu.AddKeyOption({"Hero Specific", "Visage"}, "Combo Key", Enum.ButtonCode.KEY_NONE)
AutoVisage.EscapeModeKey = Menu.AddKeyOption({"Hero Specific", "Visage"}, "Escape Mode Key", Enum.ButtonCode.KEY_NONE)
AutoVisage.FollowModeKey = Menu.AddKeyOption({"Hero Specific", "Visage"}, "Follow Mode Key", Enum.ButtonCode.KEY_NONE)
AutoVisage.StreamerMode = Menu.AddOption({"Hero Specific", "Visage"}, "Streamer Mode", "Disables attack range circle and other script information on the screen.")
AutoVisage.Font = Renderer.LoadFont("Calibri", 24, Enum.FontWeight.EXTRABOLD)
AutoVisage.FontLarge = Renderer.LoadFont("Calibri", 60, Enum.FontWeight.EXTRABOLD)

AutoVisage.StoneFormCastTime = 0
AutoVisage.CircleUpdate = true
AutoVisage.startTime = 0
AutoVisage.targetPos = 0 
AutoVisage.target = 0
AutoVisage.ProjectileTime = 0
AutoVisage.ItemUseTime = 0
AutoVisage.HeroAbilityUseTime = 0
AutoVisage.UnitAbilityUseTime = 0
AutoVisage.StunTime = 0
AutoVisage.StunDuration = 0
AutoVisage.AttackOrderTime = 0
AutoVisage.MoveOrderTime = 0
AutoVisage.FarmManaThreshold = 0.35
AutoVisage.CircleDrawTime = 0
AutoVisage.OrbWalkTime = 0
AutoVisage.CheckDeadTime = 0 
AutoVisage.MoveNPCOrderTime = 0
AutoVisage.AttackNPCOrderTime = 0
AutoVisage.ReadyToInvisTime = nil
AutoVisage.NeutralToBuffWithOgre = nil
AutoVisage.HeroToBuffWithPriest = nil
AutoVisage.HeroToBuffWithOgre = nil
AutoVisage.HeroToBuffWithLizard = nil
AutoVisage.Delay = 0.1
AutoVisage.EscapeOrderTime = 0
AutoVisage.AttackNearestUnitTime = 0
AutoVisage.MoveToTargetTime = 0
AutoVisage.Mode = "Normal"
AutoVisage.DrawAttackRangeTime = 0
AutoVisage.TimeToFace = 0
AutoVisage.f1AttackOrderTime = 0
AutoVisage.f1TimeToFace = 0
AutoVisage.f2AttackOrderTime = 0
AutoVisage.f2TimeToFace = 0
AutoVisage.f3AttackOrderTime = 0
AutoVisage.f3TimeToFace = 0
AutoVisage.familiarAttackOrderTime = 0
AutoVisage.TargetChangeTime = 0
AutoVisage.Target = nil
AutoVisage.PreviousTarget = nil
AutoVisage.CustomTime = 0
AutoVisage.FollowOrderTime = 0
AutoVisage.ComboMode = "Auto"

function AutoVisage.OnUpdate()
  if not GameRules.GetGameState() == 5 then return end
  if not Heroes.GetLocal() or NPC.GetUnitName(Heroes.GetLocal()) ~= "npc_dota_hero_visage" then return end
  local myHero = Heroes.GetLocal()
  local myHeroPos = Entity.GetAbsOrigin(myHero)
  local myMana = NPC.GetMana(myHero)
  local myStr = Hero.GetStrengthTotal(myHero)
  local myAgi = Hero.GetAgilityTotal(myHero)
  local myInt = Hero.GetIntellectTotal(myHero)
  local myXP = Hero.GetCurrentXP(myHero)
  local myHP = Entity.GetHealth(myHero)
  local myMaxHP = Entity.GetMaxHealth(myHero)
  local mySpellAmp = 1 + (myInt * 0.07142857142) / 100
  local soulAssumption = NPC.GetAbility(myHero, "visage_soul_assumption")
  local soulMaxStacks = Ability.GetLevelSpecialValueFor(soulAssumption, "stack_limit")
  local soulModifier = NPC.GetModifier(myHero, "modifier_visage_soul_assumption")
  local soulStackCounter = 0
  local graveChill = NPC.GetAbility(myHero, "visage_grave_chill")
  local familiars = NPC.GetAbility(myHero, "visage_summon_familiars")
  local familiarsLevel = Ability.GetLevel(familiars)
  local myAttackRange = NPC.GetAttackRange(myHero)
  local myAttackRangeBonus = NPC.HasModifier(myHero, "modifier_item_dragon_lance")
  local myAttackPoint = 0.46 / (1 + (Hero.GetAgilityTotal(myHero)/100))
  local myAttackBackswing = 0.54 / (1 + (Hero.GetAgilityTotal(myHero)/100))
  local myTimeBetweenAttacks = (1 / NPC.GetAttacksPerSecond(myHero))
  local myMissleSpeed = 900
  local enemyHero = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
  local enemyHeroPos = Entity.GetAbsOrigin(enemyHero)
  local enemy = Input.GetNearestUnitToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
  local enemyPos = Entity.GetAbsOrigin(enemy)
  local mousePos = Input.GetWorldCursorPos()
  local familiarAttackRange = 160
  local familiarAttackPoint = 0.33
  local familiarAttackBackswing = 0.2
  local familiarTimeBetweenAttacks = 0.4
  local familiarMissleSpeed = 900


  if AutoVisage.Target ~= AutoVisage.PreviousTarget then
    AutoVisage.PreviousTarget = AutoVisage.Target
    AutoVisage.TargetChangeTime = GameRules.GetGameTime()
  end

  if soulModifier then
    soulStackCounter = Modifier.GetStackCount(soulModifier)
  end

  if Menu.IsKeyDownOnce(AutoVisage.AttackModeKey) then
    if AutoVisage.ComboMode == "Auto" then
      AutoVisage.ComboMode = "Lock"
    else
      AutoVisage.ComboMode = "Auto"
    end
  end

  if AutoVisage.Mode == "Attack" and not Menu.IsKeyDown(AutoVisage.AttackKey) then
    AutoVisage.Mode = "Normal"
  end

  if Menu.IsKeyDownOnce(AutoVisage.EscapeModeKey) then
    if AutoVisage.Mode == "Escape" then
      AutoVisage.Mode = "Normal"
    else
      AutoVisage.Mode = "Escape"
    end
  end

  if Menu.IsKeyDownOnce(AutoVisage.FollowModeKey) then
    if AutoVisage.Mode == "Follow" then
      AutoVisage.Mode = "Normal"
    else
      AutoVisage.Mode = "Follow"
    end
  end

  AutoVisage.AutoBreakLinkens(myHero, enemyHero, myMana)
  AutoVisage.Escape(myHero, familiars, familiarsLevel)
  AutoVisage.Follow(myHero, familiars, familiarsLevel)
  AutoVisage.AutoFamiliarSaver(familiars, familiarsLevel, myHero)
  AutoVisage.AutoInterruptChannellingEnemyHero(myHero, familiars, familiarsLevel)
  AutoVisage.AutoKillWithFamiliarStun(myHero, familiars, familiarsLevel)
  AutoVisage.AutoKill(myHero, myMana, myInt, mySpellAmp, soulAssumption, soulMaxStacks, soulModifier, soulStackCounter)
  AutoVisage.DrawAttackRange(myAttackRange, myAttackRangeBonus)

  
  if Menu.IsKeyDown(AutoVisage.AttackKey) then
    AutoVisage.Mode = "Attack"
    AutoVisage.UseItems(myHero, myMana, enemyHero)
    AutoVisage.UseSpells(myHero, enemyHero, myMana, myInt, mySpellAmp, graveChill, soulAssumption, soulMaxStacks, soulModifier, soulStackCounter, myAttackPoint)
    AutoVisage.UseFamiliars(myHero, enemyHero, familiars, familiarsLevel)
    AutoVisage.AttackEnemy(myHero, myMana, myAttackPoint, myAttackBackswing, myAttackRange, myAttackRangeBonus, myTimeBetweenAttacks, enemy, enemyHero, familiars, familiarsLevel)    
  end

end

function AutoVisage.OnGameStart()
  AutoVisage.StoneFormCastTime = 0
  AutoVisage.CircleUpdate = true
  AutoVisage.startTime = 0
  AutoVisage.targetPos = 0 
  AutoVisage.target = 0
  AutoVisage.ProjectileTime = 0
  AutoVisage.ItemUseTime = 0
  AutoVisage.HeroAbilityUseTime = 0
  AutoVisage.UnitAbilityUseTime = 0
  AutoVisage.StunTime = 0
  AutoVisage.StunDuration = 0
  AutoVisage.AttackOrderTime = 0
  AutoVisage.MoveOrderTime = 0
  AutoVisage.FarmManaThreshold = 0.35
  AutoVisage.CircleDrawTime = 0
  AutoVisage.OrbWalkTime = 0
  AutoVisage.CheckDeadTime = 0 
  AutoVisage.MoveNPCOrderTime = 0
  AutoVisage.AttackNPCOrderTime = 0
  AutoVisage.ReadyToInvisTime = nil
  AutoVisage.NeutralToBuffWithOgre = nil
  AutoVisage.HeroToBuffWithPriest = nil
  AutoVisage.HeroToBuffWithOgre = nil
  AutoVisage.HeroToBuffWithLizard = nil
  AutoVisage.Delay = 0.05
  AutoVisage.EscapeOrderTime = 0
  AutoVisage.AttackNearestUnitTime = 0
  AutoVisage.MoveToTargetTime = 0
  AutoVisage.Mode = "Normal"
  AutoVisage.DrawAttackRangeTime = 0
  AutoVisage.TimeToFace = 0
  AutoVisage.f1AttackOrderTime = 0
  AutoVisage.f1TimeToFace = 0
  AutoVisage.f2AttackOrderTime = 0
  AutoVisage.f2TimeToFace = 0
  AutoVisage.f3AttackOrderTime = 0
  AutoVisage.f3TimeToFace = 0
  AutoVisage.familiarAttackOrderTime = 0
  AutoVisage.TargetChangeTime = 0
  AutoVisage.Target = nil
  AutoVisage.PreviousTarget = nil
  AutoVisage.CustomTime = 0
  AutoVisage.FollowOrderTime = 0
  AutoVisage.ComboMode = "Auto"
end

function AutoVisage.OnProjectile(projectile)
  if not projectile or not projectile.source or not projectile.target then return end
  if not projectile.isAttack then return end
  if not Heroes.GetLocal() or NPC.GetUnitName(Heroes.GetLocal()) ~= "npc_dota_hero_visage" then return end
  local myHero = Heroes.GetLocal()
  local mousePos = Input.GetWorldCursorPos()
  local enemyHero = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
  if projectile.source == myHero then
    AutoVisage.ProjectileTime = GameRules.GetGameTime()
  end
end

  function AutoVisage.DrawAttackRange(myAttackRange, myAttackRangeBonus)
  if GameRules.GetGameTime() - AutoVisage.DrawAttackRangeTime > 5 then
    if Menu.IsEnabled(AutoVisage.StreamerMode) then
      Engine.ExecuteCommand("dota_range_display 0")
    else
      Engine.ExecuteCommand("dota_range_display " .. tostring(myAttackRange))
	end
    AutoVisage.DrawAttackRangeTime = GameRules.GetGameTime()
  end
end

function AutoVisage.AttackEnemy(myHero, myMana, myAttackPoint, myAttackBackswing, myAttackRange, myAttackRangeBonus, myTimeBetweenAttacks, enemy, enemyHero, familiars, familiarsLevel)   
  if Menu.IsKeyDown(AutoVisage.AttackKey) and AutoVisage.Mode == "Attack" then
    if AutoVisage.ComboMode == "Auto" then
      if GameRules.GetGameTime() - AutoVisage.TargetChangeTime > myTimeBetweenAttacks then
        local targetEnemyHero = AutoVisage.GetLowestPhysicalTargetEnemyHeroAroundPos(Input.GetWorldCursorPos(), 900)
        AutoVisage.Target = targetEnemyHero
      end
    end

    if AutoVisage.ComboMode == "Lock" then
      AutoVisage.Target = enemyHero
    end

    if AutoVisage.Target then
      Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET, AutoVisage.Target, Vector(0, 0, 0), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_SELECTED_UNITS, nil, false, false)
    else
      Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, nil, Input.GetWorldCursorPos(), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_SELECTED_UNITS, nil, false, false)
    end

    if Entity.GetHealth(myHero) > 0 and not Entity.IsDormant(myHero) then

      if myAttackRangeBonus then
        myAttackRange = myAttackRange + 140
      end

      if GameRules.GetGameTime() - AutoVisage.ProjectileTime <= myTimeBetweenAttacks then
        if (AutoVisage.ComboMode == "Lock" and not NPC.IsEntityInRange(myHero, AutoVisage.Target, myAttackRange - 65)) or AutoVisage.ComboMode == "Auto" then
          Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, nil, Input.GetWorldCursorPos(), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, myHero, false, false)
        end
      end
    end
  end
end

function AutoVisage.Escape(myHero, familiars, familiarsLevel)
  if not familiars then return end
  if AutoVisage.Mode == "Escape" then
    if Entity.GetHealth(myHero) > 0 then
      if GameRules.GetGameTime() >= AutoVisage.EscapeOrderTime + 1 then
        local enemyAround = NPC.GetHeroesInRadius(myHero, 1000, Enum.TeamType.TEAM_ENEMY)
        if #enemyAround > 0 then
          for _, enemyHero in ipairs(NPC.GetHeroesInRadius(myHero, 1000, Enum.TeamType.TEAM_ENEMY)) do
            AutoVisage.StunEnemyInRange(myHero, enemyHero, familiars, familiarsLevel)
            AutoVisage.EscapeOrderTime = GameRules.GetGameTime()
          end
        else
          for _, npc in ipairs(NPC.GetUnitsInRadius(myHero, 99999, Enum.TeamType.TEAM_FRIEND)) do
            if npc and (NPC.GetUnitName(npc) == "npc_dota_visage_familiar" .. 1 or NPC.GetUnitName(npc) == "npc_dota_visage_familiar" .. 2 or NPC.GetUnitName(npc) == "npc_dota_visage_familiar" .. 3) and not NPC.HasModifier(npc, "modifier_rooted") and not NPC.HasModifier(npc, "modifier_visage_summon_familiars_stone_form") then
              Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_TARGET, myHero, Vector(0, 0, 0), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, npc, false, false)
              AutoVisage.EscapeOrderTime = GameRules.GetGameTime()
            end
          end
        end
      end
    end
  end
end

function AutoVisage.Follow(myHero, familiars, familiarsLevel)
  if not familiars then return end
  if AutoVisage.Mode == "Follow" then
    if Entity.GetHealth(myHero) > 0 then
      if GameRules.GetGameTime() >= AutoVisage.FollowOrderTime + .1 then
        for _, npc in ipairs(NPC.GetUnitsInRadius(myHero, 99999, Enum.TeamType.TEAM_FRIEND)) do
          if npc and (NPC.GetUnitName(npc) == "npc_dota_visage_familiar" .. 1 or NPC.GetUnitName(npc) == "npc_dota_visage_familiar" .. 2 or NPC.GetUnitName(npc) == "npc_dota_visage_familiar" .. 3) and not NPC.HasModifier(npc, "modifier_rooted") and not NPC.HasModifier(npc, "modifier_visage_summon_familiars_stone_form") then
            Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_TARGET, myHero, Vector(0, 0, 0), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, npc, false, false)
            AutoVisage.FollowOrderTime = GameRules.GetGameTime()
          end
        end
      end
    end
  end
end

function AutoVisage.OnDraw()
  if not GameRules.GetGameState() == 5 then return end
  if Menu.IsEnabled(AutoVisage.StreamerMode) then return end
  local myHero = Heroes.GetLocal()
  if not myHero or NPC.GetUnitName(myHero) ~= "npc_dota_hero_visage" then return end
  local familiars = NPC.GetAbility(myHero, "visage_summon_familiars")
  local familiarsLevel = Ability.GetLevel(familiars)
  
  
  if AutoVisage.Mode ~= "Normal" then
    local pos = NPC.GetAbsOrigin(myHero)
    local x, y, visible = Renderer.WorldToScreen(pos)
    if visible and Entity.GetHealth(myHero) > 0 then
      Renderer.SetDrawColor(0, 255, 0, 255)
      Renderer.DrawText(AutoVisage.Font, x+15, y+15, tostring(AutoVisage.Mode), 1)
    end
  end

  if AutoVisage.ComboMode then
    local pos = NPC.GetAbsOrigin(myHero)
    local x, y, visible = Renderer.WorldToScreen(pos)
    if visible and Entity.GetHealth(myHero) > 0 then
      Renderer.SetDrawColor(0, 255, 0, 255)
      Renderer.DrawText(AutoVisage.Font, x+15, y+15, "\n" .. tostring(AutoVisage.ComboMode), 1)
    end
  end

  if AutoVisage.Mode == "Attack" then
    if AutoVisage.ComboMode == "Auto" then
      local targetEnemyHero = AutoVisage.GetLowestPhysicalTargetEnemyHeroAroundPos(Input.GetWorldCursorPos(), 900)
      local pos = NPC.GetAbsOrigin(targetEnemyHero)
      local x, y, visible = Renderer.WorldToScreen(pos)
      if targetEnemyHero and visible and Entity.GetHealth(targetEnemyHero) > 0 then
        Renderer.SetDrawColor(255, 255, 0, 255)
        Renderer.DrawText(AutoVisage.Font, x+15, y+15, "Attack Target", 1)
      end
      local graveChill = NPC.GetAbility(myHero, "visage_grave_chill")
      if Ability.GetLevel(graveChill) > 0 then
        local spellTargetEnemyHero = AutoVisage.GetLowestSpellTargetEnemyHeroAround(myHero, Ability.GetCastRange(graveChill))
        local pos1 = NPC.GetAbsOrigin(spellTargetEnemyHero)
        local x1, y1, visible1 = Renderer.WorldToScreen(pos1)
        if spellTargetEnemyHero and visible1 and Entity.GetHealth(spellTargetEnemyHero) > 0 then
          Renderer.SetDrawColor(255, 0, 255, 255)
          Renderer.DrawText(AutoVisage.Font, x1+15, y1+15, "\n" .. "Spell Target", 1)
        end
      end
    end
	
    if AutoVisage.ComboMode == "Lock" then
      local enemyHero = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
      local pos = NPC.GetAbsOrigin(enemyHero)
      local x, y, visible = Renderer.WorldToScreen(pos)
      if visible and Entity.GetHealth(enemyHero) > 0 then
        Renderer.SetDrawColor(255, 255, 0, 255)
        Renderer.DrawText(AutoVisage.Font, x+15, y+15, "Target", 1)
      end
    end
  end
end

function AutoVisage.AutoInterruptChannellingEnemyHero(myHero, familiars, familiarsLevel)
  for _, npc in ipairs(NPC.GetUnitsInRadius(myHero, 99999, Enum.TeamType.TEAM_FRIEND)) do
    if familiarsLevel > 0 and (NPC.GetUnitName(npc) == "npc_dota_visage_familiar" .. 1 or NPC.GetUnitName(npc) == "npc_dota_visage_familiar" .. 2 or NPC.GetUnitName(npc) == "npc_dota_visage_familiar" .. 3) and not NPC.HasModifier(npc, "modifier_sheepstick_debuff") and not NPC.IsSilenced(npc) and not NPC.HasModifier(npc, "modifier_rooted") and (Entity.IsAlive(npc) or Entity.GetHealth(npc) > 0) then
      local stoneForm = NPC.GetAbility(npc, "visage_summon_familiars_stone_form")
      for _, enemyHero in pairs(NPC.GetHeroesInRadius(npc, 1000, Enum.TeamType.TEAM_ENEMY)) do
        if enemyHero and stoneForm and Entity.IsHero(enemyHero) and Ability.IsReady(stoneForm)  and not Ability.IsInAbilityPhase(stoneForm) and NPC.IsPositionInRange(npc, AutoVisage.GetPredictedPosition(enemyHero, 0.55), 350) and AutoVisage.CanCastSpellOn(enemyHero)  and AutoVisage.IsChannellingAbility(enemyHero) and (GameRules.GetGameTime() - AutoVisage.StoneFormCastTime) >= (Ability.GetLevelSpecialValueForFloat(stoneForm, "stun_duration")) then
          Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET, enemyHero, Vector(0,0,0), stoneForm, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, npc)
          AutoVisage.StoneFormCastTime = GameRules.GetGameTime()
        end
      end
    end
  end
end

function AutoVisage.AutoKillWithFamiliarStun(myHero, familiars, familiarsLevel)
  local FamiliarStoneDMG = 20 + 40 * familiarsLevel
  for _, npc in ipairs(NPC.GetUnitsInRadius(myHero, 99999, Enum.TeamType.TEAM_FRIEND)) do
    if familiarsLevel > 0 and (NPC.GetUnitName(npc) == "npc_dota_visage_familiar" .. 1 or NPC.GetUnitName(npc) == "npc_dota_visage_familiar" .. 2 or NPC.GetUnitName(npc) == "npc_dota_visage_familiar" .. 3) and not NPC.HasModifier(npc, "modifier_sheepstick_debuff") and not NPC.IsSilenced(npc) and not NPC.HasModifier(npc, "modifier_rooted") and (Entity.IsAlive(npc) or Entity.GetHealth(npc) > 0) then
      local stoneForm = NPC.GetAbility(npc, "visage_summon_familiars_stone_form")
      for _, enemyHero in pairs(NPC.GetHeroesInRadius(npc, 1000, Enum.TeamType.TEAM_ENEMY)) do
        if Entity.IsHero(enemyHero) and not NPC.IsIllusion(enemyHero) then
          AutoVisage.InRangeCount = 0
          for _, familiarNPCs in ipairs(NPC.GetUnitsInRadius(enemyHero, 1000, Enum.TeamType.TEAM_ENEMY)) do
            if familiarsLevel > 0 and (NPC.GetUnitName(familiarNPCs) == "npc_dota_visage_familiar" .. 1 or NPC.GetUnitName(familiarNPCs) == "npc_dota_visage_familiar" .. 2 or NPC.GetUnitName(familiarNPCs) == "npc_dota_visage_familiar" .. 3) and not NPC.HasModifier(familiarNPCs, "modifier_sheepstick_debuff") and not NPC.IsSilenced(familiarNPCs) and not NPC.HasModifier(familiarNPCs, "modifier_rooted") and (Entity.IsAlive(familiarNPCs) or Entity.GetHealth(familiarNPCs) > 0) then
              if NPC.IsPositionInRange(familiarNPCs, AutoVisage.GetPredictedPosition(enemyHero, 0.55), 350) then
                AutoVisage.InRangeCount = AutoVisage.InRangeCount + 1
              end
            end
          end
          if enemyHero and stoneForm and Entity.IsHero(enemyHero) and not NPC.IsIllusion(enemyHero) and Ability.IsReady(stoneForm) and not Ability.IsInAbilityPhase(stoneForm) and AutoVisage.CantCastSpellOnImmoModifiers(enemyHero) and NPC.IsPositionInRange(npc, AutoVisage.GetPredictedPosition(enemyHero, 0.55), 350) and AutoVisage.CanCastSpellOn(enemyHero) and Entity.GetHealth(enemyHero) <= (FamiliarStoneDMG * NPC.GetMagicalArmorDamageMultiplier(enemyHero)) * (AutoVisage.InRangeCount) then
            Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET, enemyHero, Vector(0,0,0), stoneForm, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, npc)
            AutoVisage.StoneFormCastTime = GameRules.GetGameTime()
          end
        end
      end
    end
  end
end

function AutoVisage.StunEnemyInRange(myHero, enemyHero, familiars, familiarsLevel)
  for _, npc in ipairs(NPC.GetUnitsInRadius(myHero, 99999, Enum.TeamType.TEAM_FRIEND)) do
    if familiarsLevel > 0 and (NPC.GetUnitName(npc) == "npc_dota_visage_familiar" .. 1 or NPC.GetUnitName(npc) == "npc_dota_visage_familiar" .. 2 or NPC.GetUnitName(npc) == "npc_dota_visage_familiar" .. 3) and not NPC.HasModifier(npc, "modifier_sheepstick_debuff") and not NPC.IsSilenced(npc) and not NPC.HasModifier(npc, "modifier_rooted") and (Entity.IsAlive(npc) or Entity.GetHealth(npc) > 0) then
      local stoneForm = NPC.GetAbility(npc, "visage_summon_familiars_stone_form")
      if enemyHero and stoneForm and Entity.IsHero(enemyHero) and not NPC.IsIllusion(enemyHero) and Ability.IsReady(stoneForm) and not Ability.IsInAbilityPhase(stoneForm) and NPC.IsPositionInRange(npc, AutoVisage.GetPredictedPosition(enemyHero, 0.55), 350) and AutoVisage.CanCastSpellOn(enemyHero) and (GameRules.GetGameTime() - AutoVisage.StoneFormCastTime) >= (Ability.GetLevelSpecialValueForFloat(stoneForm, "stun_duration")) then
        Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET, enemyHero, Vector(0,0,0), stoneForm, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, npc)
        AutoVisage.StoneFormCastTime = GameRules.GetGameTime()
      elseif GameRules.GetGameTime() - AutoVisage.MoveOrderTime > .25 then
        Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET, enemyHero, Vector(0, 0, 0), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, npc, false, false)
        AutoVisage.MoveOrderTime = GameRules.GetGameTime()
      end
    end
  end
end



function AutoVisage.AutoKill(myHero, myMana, myInt, mySpellAmp, soulAssumption, soulMaxStacks, soulModifier, soulStackCounter)
  for _, npc in pairs(NPC.GetHeroesInRadius(myHero, 99999, Enum.TeamType.TEAM_ENEMY)) do
    if npc and Ability.GetLevel(soulAssumption) > 0 and Entity.IsHero(npc) and AutoVisage.IsSuitableToCastSpell(myHero) and AutoVisage.CanCastSpellOn(npc) and Ability.IsCastable(soulAssumption, myMana) and NPC.IsEntityInRange(myHero, npc, Ability.GetCastRange(soulAssumption)) and Ability.IsReady(soulAssumption) and not Ability.IsChannelling(soulAssumption) and AutoVisage.CantCastSpellOnImmoModifiers(npc) and not Ability.IsInAbilityPhase(soulAssumption) and Entity.GetHealth(npc) <= (NPC.GetMagicalArmorDamageMultiplier(npc) * ((20 + 65 * soulStackCounter) * (1 + mySpellAmp / 100))) then
      Ability.CastTarget(soulAssumption, npc)
    end
  end
end

function AutoVisage.UseSpells(myHero, enemyHero, myMana, myInt, mySpellAmp, graveChill, soulAssumption, soulMaxStacks, soulModifier, soulStackCounter, myAttackPoint)

  if AutoVisage.IsSuitableToCastSpell(myHero) then

    if Ability.GetLevel(graveChill) > 0 and Ability.IsCastable(graveChill, myMana) and Ability.IsReady(graveChill) and not Ability.IsInAbilityPhase(graveChill) then
      if AutoVisage.ComboMode == "Auto" then
        local targetEnemyHero = AutoVisage.GetLowestSpellTargetEnemyHeroAround(myHero, Ability.GetCastRange(graveChill))
        if targetEnemyHero then
          Ability.CastTarget(graveChill, targetEnemyHero)
        end
      end
      if AutoVisage.ComboMode == "Lock" then
        local targetEnemyHero = enemyHero
        if targetEnemyHero then
          Ability.CastTarget(graveChill, targetEnemyHero)
        end
      end
    end


    if Ability.GetLevel(soulAssumption) > 0 and Ability.IsCastable(soulAssumption, myMana) and Ability.IsReady(soulAssumption) and AutoVisage.CantCastSpellOnImmoModifiers(enemyHero) and not Ability.IsInAbilityPhase(soulAssumption) and soulMaxStacks <= soulStackCounter then
      if AutoVisage.ComboMode == "Auto" then
        local targetEnemyHero = AutoVisage.GetLowestSpellTargetEnemyHeroAround(myHero, Ability.GetCastRange(soulAssumption))
        if targetEnemyHero then
          Ability.CastTarget(soulAssumption, targetEnemyHero)
        end
      end
      if AutoVisage.ComboMode == "Lock" then
        local targetEnemyHero = enemyHero
        if targetEnemyHero then
          Ability.CastTarget(soulAssumption, targetEnemyHero)
        end
      end

    end
  end
end

function AutoVisage.UseFamiliars(myHero, enemyHero, familiars, familiarsLevel)
  local targetEnemyHero = AutoVisage.GetLowestPhysicalTargetEnemyHeroAroundPos(Input.GetWorldCursorPos(), 600)
  if targetEnemyHero then
    for _, npc in ipairs(NPC.GetUnitsInRadius(myHero, 99999, Enum.TeamType.TEAM_FRIEND)) do
      if familiarsLevel > 0 and (NPC.GetUnitName(npc) == "npc_dota_visage_familiar" .. 1 or NPC.GetUnitName(npc) == "npc_dota_visage_familiar" .. 2 or NPC.GetUnitName(npc) == "npc_dota_visage_familiar" .. 3) and not NPC.HasModifier(npc, "modifier_sheepstick_debuff") and not NPC.IsSilenced(npc) and (Entity.IsAlive(npc) or Entity.GetHealth(npc) > 0) and not NPC.HasModifier(npc, "modifier_rooted") then
        local stoneForm = NPC.GetAbility(npc, "visage_summon_familiars_stone_form")
       
        if Entity.GetHealth(targetEnemyHero) > 0 and not NPC.HasState(targetEnemyHero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.IsIllusion(targetEnemyHero) and NPC.IsPositionInRange(npc, AutoVisage.GetPredictedPosition(targetEnemyHero, 0.55), 350) and stoneForm and Ability.IsReady(stoneForm) and not Ability.IsInAbilityPhase(stoneForm) and not NPC.HasModifier(targetEnemyHero, "modifier_rooted") and not NPC.HasModifier(targetEnemyHero, "modifier_sheepstick_debuff") and not NPC.HasModifier(npc, "modifier_visage_summon_familiars_stone_form") then
          if (GameRules.GetGameTime() - AutoVisage.StoneFormCastTime) >= (Ability.GetLevelSpecialValueForFloat(stoneForm, "stun_duration")) then
            Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET, targetEnemyHero, Vector(0,0,0), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, npc)
            AutoVisage.StoneFormCastTime = GameRules.GetGameTime()
          end
        end
      end
    end 
  end
end

function AutoVisage.AutoFamiliarSaver(familiars, familiarsLevel, myHero)
  if familiarsLevel == 0 then return end
  for _, npc in ipairs(NPC.GetUnitsInRadius(myHero, 99999, Enum.TeamType.TEAM_FRIEND)) do
    if npc and (NPC.GetUnitName(npc) == "npc_dota_visage_familiar" .. 1 or NPC.GetUnitName(npc) == "npc_dota_visage_familiar" .. 2 or NPC.GetUnitName(npc) == "npc_dota_visage_familiar" .. 3) and not NPC.HasModifier(npc, "modifier_rooted") and not NPC.HasModifier(npc, "modifier_visage_summon_familiars_stone_form") then
      local stoneForm = NPC.GetAbility(npc, "visage_summon_familiars_stone_form")
      if Entity.GetHealth(npc) < (Entity.GetMaxHealth(npc) * 0.63) and stoneForm and Ability.IsReady(stoneForm) and not Ability.IsInAbilityPhase(stoneForm) and not NPC.IsStunned(npc) and not NPC.IsSilenced(npc) then
        Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET, nil, Vector(0,0,0), stoneForm, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, npc)
        Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, nil, Entity.GetAbsOrigin(myHero), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, npc, queue)
      end
    end
  end
end

function AutoVisage.GetLowestSpellTargetEnemyHeroAround(npc, radius)
  local enemyHeroesList = NPC.GetHeroesInRadius(npc, radius, Enum.TeamType.TEAM_ENEMY)
  local lowestEnemyHero = nil
  local minHp = nil
  local enemyHeroHealth = nil
  for _, enemyHero in ipairs(enemyHeroesList) do
    if not NPC.IsIllusion(enemyHero) and not Entity.IsDormant(enemyHero) and AutoVisage.CanCastSpellOn(enemyHero) and Entity.IsAlive(enemyHero) and Entity.GetHealth(enemyHero) > 0 then
      local enemyHeroHealth = Entity.GetHealth(enemyHero)
      if not minHp then
        lowestEnemyHero = enemyHero
        minHp = enemyHeroHealth
      end
      if enemyHeroHealth < minHp then
        lowestEnemyHero = enemyHero
        minHp = enemyHeroHealth
      end
    end
  end
  return lowestEnemyHero
end

function AutoVisage.GetLowestPhysicalTargetEnemyHeroAroundPos(pos, radius)
  local enemyHeroesList = NPC.GetHeroesInRadius(Heroes.GetLocal(), 99999, Enum.TeamType.TEAM_ENEMY)
  local lowestEnemyHero = nil
  local minHp = nil
  local enemyHeroHealth = nil
  for _, enemyHero in ipairs(enemyHeroesList) do
    if not NPC.IsIllusion(enemyHero) and not NPC.HasState(enemyHero, Enum.ModifierState.MODIFIER_STATE_ATTACK_IMMUNE) and Entity.IsAlive(enemyHero) and Entity.GetHealth(enemyHero) > 0 then
      if NPC.IsPositionInRange(enemyHero, pos, radius, 0) then
        local enemyHeroHealth = Entity.GetHealth(enemyHero)
        if not minHp then
          lowestEnemyHero = enemyHero
          minHp = enemyHeroHealth
        end
        if enemyHeroHealth < minHp then
          lowestEnemyHero = enemyHero
          minHp = enemyHeroHealth
        end
      end
    end
  end
  return lowestEnemyHero
end

function AutoVisage.GetLowestPhysicalTargetEnemyHeroAround(npc, radius)
  local enemyHeroesList = NPC.GetHeroesInRadius(npc, radius, Enum.TeamType.TEAM_ENEMY)
  local lowestEnemyHero = nil
  local minHp = nil
  local enemyHeroHealth = nil
  for _, enemyHero in ipairs(enemyHeroesList) do
    if not NPC.IsIllusion(enemyHero) and not NPC.HasState(enemyHero, Enum.ModifierState.MODIFIER_STATE_ATTACK_IMMUNE) and Entity.IsAlive(enemyHero) and Entity.GetHealth(enemyHero) > 0 then
      local enemyHeroHealth = Entity.GetHealth(enemyHero)
      if not minHp then
        lowestEnemyHero = enemyHero
        minHp = enemyHeroHealth
      end
      if enemyHeroHealth < minHp then
        lowestEnemyHero = enemyHero
        minHp = enemyHeroHealth
      end
    end
  end
  return lowestEnemyHero
end

function AutoVisage.UseItems(myHero, myMana, enemyHero)  
  if AutoVisage.IsSuitableToUseItem(myHero) then
    if NPC.HasState(enemyHero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then return end
    if GameRules.GetGameTime() - AutoVisage.ItemUseTime < AutoVisage.Delay then return end
    for _, item in ipairs(AutoVisage.InteractiveItems) do
      if NPC.GetItem(myHero, item, true) and Ability.IsReady(NPC.GetItem(myHero, item, true)) and Ability.IsCastable(NPC.GetItem(myHero, item, true), NPC.GetMana(myHero)) and not Ability.IsInAbilityPhase(NPC.GetItem(myHero, item, true)) then 
        if AutoVisage.ComboMode == "Auto" then
          local enemyHero = AutoVisage.GetLowestSpellTargetEnemyHeroAround(myHero, Ability.GetCastRange(NPC.GetItem(myHero, item, true)) + NPC.GetCastRangeBonus(myHero))
          if Ability.GetCastRange(NPC.GetItem(myHero, item, true)) > 0 then
            if NPC.IsEntityInRange(myHero, enemyHero, Ability.GetCastRange(NPC.GetItem(myHero, item, true)) + NPC.GetCastRangeBonus(myHero)) then
              Ability.CastTarget(NPC.GetItem(myHero, item, true), enemyHero)
              AutoVisage.ItemUseTime = GameRules.GetGameTime()
            end
          elseif Ability.GetCastRange(NPC.GetItem(myHero, item, true)) == 0 then
            if NPC.IsEntityInRange(myHero, enemyHero, NPC.GetAttackRange(myHero)) then
              Ability.CastNoTarget(NPC.GetItem(myHero, item, true))
              AutoVisage.ItemUseTime = GameRules.GetGameTime()
            end
          end
        end
        if AutoVisage.ComboMode == "Lock" then
          local enemyHero = enemyHero
          if Ability.GetCastRange(NPC.GetItem(myHero, item, true)) > 0 then
            if NPC.IsEntityInRange(myHero, enemyHero, Ability.GetCastRange(NPC.GetItem(myHero, item, true)) + NPC.GetCastRangeBonus(myHero)) then
              Ability.CastTarget(NPC.GetItem(myHero, item, true), enemyHero)
              AutoVisage.ItemUseTime = GameRules.GetGameTime()
            end
          elseif Ability.GetCastRange(NPC.GetItem(myHero, item, true)) == 0 then
            if NPC.IsEntityInRange(myHero, enemyHero, NPC.GetAttackRange(myHero)) then
              Ability.CastNoTarget(NPC.GetItem(myHero, item, true))
              AutoVisage.ItemUseTime = GameRules.GetGameTime()
            end
          end
        end
      end
    end
  end
end

function AutoVisage.AutoBreakLinkens(myHero, enemyHero, myMana)
  if NPC.IsLinkensProtected(enemyHero) and Menu.IsKeyDown(AutoVisage.AttackKey) then
    local item_sheepstick = NPC.GetItem(myHero, "item_sheepstick", true)
    local item_bloodthorn = NPC.GetItem(myHero, "item_bloodthorn", true)
    local item_ethereal_blade = NPC.GetItem(myHero, "item_ethereal_blade", true)
    local item_orchid = NPC.GetItem(myHero, "item_orchid", true)
    local item_rod_of_atos = NPC.GetItem(myHero, "item_rod_of_atos", true)
    local item_abyssal_blade = NPC.GetItem(myHero, "item_abyssal_blade", true)
    local item_heavens_halberd = NPC.GetItem(myHero, "item_heavens_halberd", true)
    local item_cyclone = NPC.GetItem( myHero, "item_cyclone", true)
    local item_force_staff = NPC.GetItem(myHero, "item_force_staff", true)
    local item_diffusal_blade = NPC.GetItem(myHero, "item_diffusal_blade", true)
    local item_dagon = NPC.GetItem(myHero, "item_dagon", true)
	
    if NPC.HasItem(myHero, "item_force_staff", true) and Ability.IsCastable(item_force_staff, myMana) and NPC.IsPositionInRange(myHero, NPC.GetAbsOrigin(enemyHero), Ability.GetCastRange(item_force_staff) + NPC.GetCastRangeBonus(myHero), 0) then Ability.CastTarget(item_force_staff, enemyHero) return 
    end
    if NPC.HasItem(myHero, "item_cyclone", true) and Ability.IsCastable(item_cyclone, myMana) and NPC.IsPositionInRange(myHero, NPC.GetAbsOrigin(enemyHero), Ability.GetCastRange(item_cyclone) + NPC.GetCastRangeBonus(myHero), 0) then Ability.CastTarget(item_cyclone, enemyHero) return 
    end
    if NPC.HasItem(myHero, "item_rod_of_atos", true) and Ability.IsCastable(item_rod_of_atos, myMana) and NPC.IsPositionInRange(myHero, NPC.GetAbsOrigin(enemyHero), Ability.GetCastRange(item_rod_of_atos) + NPC.GetCastRangeBonus(myHero), 0) then Ability.CastTarget(item_rod_of_atos, enemyHero) return 
    end
    if NPC.HasItem(myHero, "item_diffusal_blade", true) and Ability.IsCastable(item_diffusal_blade, myMana) and NPC.IsPositionInRange(myHero, NPC.GetAbsOrigin(enemyHero), Ability.GetCastRange(item_diffusal_blade) + NPC.GetCastRangeBonus(myHero), 0) then Ability.CastTarget(item_diffusal_blade, enemyHero) return 
    end
    if NPC.HasItem(myHero, "item_heavens_halberd", true) and Ability.IsCastable(item_heavens_halberd, myMana) and NPC.IsPositionInRange(myHero, NPC.GetAbsOrigin(enemyHero), Ability.GetCastRange(item_heavens_halberd) + NPC.GetCastRangeBonus(myHero), 0) then Ability.CastTarget(item_heavens_halberd, enemyHero) return 
    end
    if NPC.HasItem(myHero, "item_orchid", true) and Ability.IsCastable(item_orchid, myMana) and NPC.IsPositionInRange(myHero, NPC.GetAbsOrigin(enemyHero), Ability.GetCastRange(item_orchid) + NPC.GetCastRangeBonus(myHero), 0) then Ability.CastTarget(item_orchid, enemyHero) return 
    end
    if NPC.HasItem(myHero, "item_abyssal_blade", true) and Ability.IsCastable(item_abyssal_blade, myMana) and NPC.IsPositionInRange(myHero, NPC.GetAbsOrigin(enemyHero), Ability.GetCastRange(item_abyssal_blade) + NPC.GetCastRangeBonus(myHero), 0) then Ability.CastTarget(item_abyssal_blade, enemyHero) return 
    end
    if NPC.HasItem(myHero, "item_bloodthorn", true) and Ability.IsCastable(item_bloodthorn, myMana) and NPC.IsPositionInRange(myHero, NPC.GetAbsOrigin(enemyHero), Ability.GetCastRange(item_bloodthorn) + NPC.GetCastRangeBonus(myHero), 0) then Ability.CastTarget(item_bloodthorn, enemyHero) return 
    end
    if NPC.HasItem(myHero, "item_sheepstick", true) and Ability.IsCastable(item_sheepstick, myMana) and NPC.IsPositionInRange(myHero, NPC.GetAbsOrigin(enemyHero), Ability.GetCastRange(item_sheepstick) + NPC.GetCastRangeBonus(myHero), 0) then Ability.CastTarget(item_sheepstick, enemyHero) return 
    end
  end
end

function AutoVisage.Round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function AutoVisage.OnPrepareUnitOrders(orders)
  if not orders or not orders.ability then return true end
  if not Entity.IsAbility(orders.ability) then return true end
  if Ability.GetManaCost(orders.ability) < 100 then return true end
  local myHero = Heroes.GetLocal()
  if not myHero or NPC.IsStunned(myHero) then return true end
  if NPC.GetUnitName(Heroes.GetLocal()) ~= "npc_dota_hero_wisp" then return true end
  if Entity.GetHealth(myHero) >= Entity.GetMaxHealth(myHero) * .70  then
    local soul_ring = NPC.GetItem(myHero, "item_soul_ring", true)
    if not soul_ring or not Ability.IsCastable(soul_ring, 0) then return true end
    Ability.CastNoTarget(soul_ring)
  end
  return true
end

function AutoVisage.BestPosition(unitsAround, radius)
  if not unitsAround or #unitsAround <= 0 then return nil end
  local enemyNum = #unitsAround

  if enemyNum == 1 then return Entity.GetAbsOrigin(unitsAround[1]) end

  local maxNum = 1
  local bestPos = Entity.GetAbsOrigin(unitsAround[1])
  for i = 1, enemyNum-1 do
    for j = i+1, enemyNum do
      if unitsAround[i] and unitsAround[j] then
        local pos1 = Entity.GetAbsOrigin(unitsAround[i])
        local pos2 = Entity.GetAbsOrigin(unitsAround[j])
        local mid = pos1:__add(pos2):Scaled(0.5)
        local heroesNum = 0
        for k = 1, enemyNum do
          if NPC.IsPositionInRange(unitsAround[k], mid, radius, 0) then
            heroesNum = heroesNum + 1
          end
        end
        if heroesNum > maxNum then
          maxNum = heroesNum
          bestPos = mid
        end
      end
    end
  end
  return bestPos
end

function AutoVisage.GetPredictedPosition(npc, delay)
  local pos = Entity.GetAbsOrigin(npc)
  if AutoVisage.CantMove(npc) then return pos end
  if not NPC.IsRunning(npc) or not delay then return pos end
  local dir = Entity.GetRotation(npc):GetForward():Normalized()
  local speed = AutoVisage.GetMoveSpeed(npc)
  return pos + dir:Scaled(speed * delay)
end

function AutoVisage.GetMoveSpeed(npc)
  local base_speed = NPC.GetBaseSpeed(npc)
  local bonus_speed = NPC.GetMoveSpeed(npc) - NPC.GetBaseSpeed(npc)
  if NPC.HasModifier(npc, "modifier_invoker_ice_wall_slow_debuff") then return 100 end
  if AutoVisage.GetHexTimeLeft(npc) > 0 then return 140 + bonus_speed end
  return base_speed + bonus_speed
end

function AutoVisage.IsLotusProtected(npc)
  if NPC.HasModifier(npc, "modifier_item_lotus_orb_active") then return true end
  local shield = NPC.GetAbility(npc, "antimage_spell_shield")
  if shield and Ability.IsReady(shield) and NPC.HasItem(npc, "item_ultimate_scepter", true) then
    return true
  end
  return false
end

function AutoVisage.IsDisabled(npc)
  if not Entity.IsAlive(npc) then return true end
  if NPC.IsStunned(npc) then return true end
  if NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_HEXED) then return true end
  return false
end

function AutoVisage.CanCastSpellOn(npc)
  if Entity.IsDormant(npc) or not Entity.IsAlive(npc) then return false end
  if NPC.IsStructure(npc) then return false end
  if NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then return false end
  if NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then return false end
  return true
end
 
function AutoVisage.CantCastSpellOnImmoModifiers(npc) 
  if NPC.HasModifier(npc, "modifier_nyx_assassin_spiked_carapace") or
     NPC.HasModifier(npc, "modifier_abaddon_borrowed_time") or
	 NPC.HasModifier(npc, "modifier_templar_assassin_refraction_absorb") or
	 NPC.HasModifier(npc, "modifier_ursa_enrage") or
     NPC.HasModifier(npc, "modifier_dazzle_shallow_grave") then return false end
  return true
end
 
function AutoVisage.IsSafeToCast(myHero, enemyHero, magic_damage)
  if not myHero or not enemyHero or not magic_damage then return true end
  if magic_damage <= 0 then return true end
  local counter = 0
  if NPC.HasModifier(enemyHero, "modifier_item_lotus_orb_active") then counter = counter + 1 end
  if NPC.HasModifier(enemyHero, "modifier_item_blade_mail_reflect") then counter = counter + 1 end
  local reflect_damage = counter * magic_damage * NPC.GetMagicalArmorDamageMultiplier(myHero)
  return Entity.GetHealth(myHero) > reflect_damage
end

function AutoVisage.IsAncientCreep(npc)
  if not npc then return false end

  for i, name in ipairs(AutoVisage.AncientCreepNameList) do
    if name and NPC.GetUnitName(npc) == name then return true end
  end

  return false
end

function AutoVisage.CantMove(npc)
  if not npc then return false end

  if NPC.IsRooted(npc) or AutoVisage.GetStunTimeLeft(npc) >= 1 then return true end
  if NPC.HasModifier(npc, "modifier_axe_berserkers_call") then return true end
  if NPC.HasModifier(npc, "modifier_legion_commander_duel") then return true end

  return false
end

function AutoVisage.GetStunTimeLeft(npc)
  local mod = NPC.GetModifier(npc, "modifier_stunned")
  if not mod then return 0 end
  return math.max(Modifier.GetDieTime(mod) - GameRules.GetGameTime(), 0)
end

function AutoVisage.GetHexTimeLeft(npc)
  local mod
  local mod1 = NPC.GetModifier(npc, "modifier_sheepstick_debuff")
  local mod2 = NPC.GetModifier(npc, "modifier_lion_voodoo")
  local mod3 = NPC.GetModifier(npc, "modifier_shadow_shaman_voodoo")

  if mod1 then mod = mod1 end
  if mod2 then mod = mod2 end
  if mod3 then mod = mod3 end

  if not mod then return 0 end
  return math.max(Modifier.GetDieTime(mod) - GameRules.GetGameTime(), 0)
end

function AutoVisage.IsSuitableToCastSpell(myHero)
  if NPC.IsSilenced(myHero) or AutoVisage.IsDisabled(myHero) or Entity.IsDormant(myHero) or Entity.GetHealth(myHero) <= 0 then return false end
  if NPC.HasModifier(myHero, "modifier_teleporting") then return false end
  if NPC.IsChannellingAbility(myHero) then return false end
  return true
end

function AutoVisage.IsSuitableToUseItem(myHero)
  if AutoVisage.IsDisabled(myHero) or Entity.IsDormant(myHero) or Entity.GetHealth(myHero) <= 0 then return false end
  if NPC.HasModifier(myHero, "modifier_teleporting") then return false end
  if NPC.IsChannellingAbility(myHero) then return false end
  return true
end

function AutoVisage.IsInvisible(myHero)
  if Entity.IsAlive(myHero) and Entity.GetHealth(myHero) > 0 and NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) then return true end
  return false
end

function AutoVisage.IsChannellingAbility(npc, target)
  if NPC.HasModifier(npc, "modifier_teleporting") then return true end
  if NPC.IsChannellingAbility(npc) then return true end

  return false
end

AutoVisage.InteractiveItems = {
"item_sheepstick",
"item_orchid",
"item_bloodthorn",
"item_rod_of_atos",
"item_heavens_halberd",
"item_medallion_of_courage",
"item_solar_crest",
}

AutoVisage.AncientCreepNameList = {
"npc_dota_neutral_black_drake",
"npc_dota_neutral_black_dragon",
"npc_dota_neutral_blue_dragonspawn_sorcerer",
"npc_dota_neutral_blue_dragonspawn_overseer",
"npc_dota_neutral_granite_golem",
"npc_dota_neutral_elder_jungle_stalker",
"npc_dota_neutral_prowler_acolyte",
"npc_dota_neutral_prowler_shaman",
"npc_dota_neutral_rock_golem",
"npc_dota_neutral_small_thunder_lizard",
"npc_dota_neutral_jungle_stalker",
"npc_dota_neutral_big_thunder_lizard",
"npc_dota_roshan"
}

return AutoVisage