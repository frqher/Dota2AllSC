-- AutoEnchantress by unknown
-- UPDATE 1

local AutoEnchantress = {}

AutoEnchantress.AutoOffensiveItems = Menu.AddOption({"Hero Specific","Enchantress"}, "Auto Offensive Item Use", "")
AutoEnchantress.AutoDefensiveItems = Menu.AddOption({"Hero Specific","Enchantress"}, "Auto Defensive Item Use", "")
AutoEnchantress.BlackKingBarDuringCombo = Menu.AddOption({"Hero Specific", "Enchantress"}, "Auto Use Black King Bar During Combo", "")
AutoEnchantress.ComboKey = Menu.AddKeyOption({"Hero Specific", "Enchantress"}, "Combo Key", Enum.ButtonCode.KEY_SPACE)
AutoEnchantress.FarmKey = Menu.AddKeyOption({"Hero Specific", "Enchantress"}, "Farm Key", Enum.ButtonCode.KEY_F)
AutoEnchantress.EnchantAgainKey = Menu.AddKeyOption({"Hero Specific", "Enchantress"}, "Toggle Enchant Enchanted Units", Enum.ButtonCode.KEY_6)
AutoEnchantress.EnchantKey = Menu.AddKeyOption({"Hero Specific", "Enchantress"}, "Enchant Key", Enum.ButtonCode.KEY_4)
AutoEnchantress.DominateKey = Menu.AddKeyOption({"Hero Specific", "Enchantress"}, "Dominate Key", Enum.ButtonCode.KEY_5)
AutoEnchantress.Font = Renderer.LoadFont("Tahoma", 24, Enum.FontWeight.EXTRABOLD)

AutoEnchantress.inAutoSpellsMode = false
AutoEnchantress.ProjectileTime = 0
AutoEnchantress.ItemUseTime = 0
AutoEnchantress.HeroAbilityUseTime = 0
AutoEnchantress.UnitAbilityUseTime = 0
AutoEnchantress.Delay = .05
AutoEnchantress.StunTime = 0
AutoEnchantress.StunDuration = 0
AutoEnchantress.AttackOrderTime = 0
AutoEnchantress.MoveOrderTime = 0
AutoEnchantress.FarmManaThreshold = 0.35
AutoEnchantress.CircleDrawTime = 0
AutoEnchantress.OrbWalkTime = 0
AutoEnchantress.CheckDeadTime = 0 
AutoEnchantress.MoveNPCOrderTime = 0
AutoEnchantress.AttackNPCOrderTime = 0
AutoEnchantress.ReadyToInvisTime = nil
AutoEnchantress.NeutralToBuffWithOgre = nil
AutoEnchantress.HeroToBuffWithPriest = nil
AutoEnchantress.HeroToBuffWithOgre = nil
AutoEnchantress.HeroToBuffWithLizard = nil
AutoEnchantress.FleePos = nil
AutoEnchantress.WalkDelay = 0
AutoEnchantress.Kite = false
AutoEnchantress.PikeSecondsSinceLastUse = -1.0
AutoEnchantress.myRange = 0
AutoEnchantress.PikeEnemy = nil
AutoEnchantress.PikeAttackCount = -1
AutoEnchantress.ImpetusChangeStateTime = 0
AutoEnchantress.HelmUnit = nil
AutoEnchantress.ImpetusWasOff = nil
AutoEnchantress.EnchantAgainTime = 0

function AutoEnchantress.OnGameStart()
  AutoEnchantress.inAutoSpellsMode = false
  AutoEnchantress.ProjectileTime = 0
  AutoEnchantress.ItemUseTime = 0
  AutoEnchantress.HeroAbilityUseTime = 0
  AutoEnchantress.UnitAbilityUseTime = 0
  AutoEnchantress.StunTime = 0
  AutoEnchantress.StunDuration = 0
  AutoEnchantress.AttackOrderTime = 0
  AutoEnchantress.MoveOrderTime = 0
  AutoEnchantress.FarmManaThreshold = 0.35
  AutoEnchantress.CircleDrawTime = 0
  AutoEnchantress.OrbWalkTime = 0
  AutoEnchantress.CheckDeadTime = 0 
  AutoEnchantress.MoveNPCOrderTime = 0
  AutoEnchantress.AttackNPCOrderTime = 0
  AutoEnchantress.ReadyToInvisTime = nil
  AutoEnchantress.NeutralToBuffWithOgre = nil
  AutoEnchantress.HeroToBuffWithPriest = nil
  AutoEnchantress.HeroToBuffWithOgre = nil
  AutoEnchantress.HeroToBuffWithLizard = nil
  AutoEnchantress.WalkDelay = 0
  AutoEnchantress.FleePos = nil
  AutoEnchantress.Kite = false
  AutoEnchantress.PikeSecondsSinceLastUse = -1.0
  AutoEnchantress.myRange = 0
  AutoEnchantress.PikeEnemy = nil
  AutoEnchantress.PikeAttackCount = -1
  AutoEnchantress.ImpetusChangeStateTime = 0
  AutoEnchantress.HelmUnit = nil
  AutoEnchantress.ImpetusWasOff = nil
  AutoEnchantress.EnchantAgainTime = 0
end

function AutoEnchantress.AutoRaiseDead(myHero)
  if GameRules.GetGameTime() - AutoEnchantress.CheckDeadTime < 1 then return end
  for _, npc in ipairs(NPC.GetUnitsInRadius(myHero, 99999, Enum.TeamType.TEAM_FRIEND)) do
    if npc and NPC.HasAbility(npc, "dark_troll_warlord_raise_dead") and Entity.IsAlive(npc) and not Entity.IsDormant(npc) and Entity.GetHealth(npc) and (Entity.GetOwner(myHero) == Entity.GetOwner(npc) or Entity.OwnedBy(npc, myHero)) and Ability.IsReady(NPC.GetAbility(npc, "dark_troll_warlord_raise_dead")) and Ability.IsCastable(NPC.GetAbility(npc, "dark_troll_warlord_raise_dead"), NPC.GetMana(npc)) and not Ability.IsInAbilityPhase(NPC.GetAbility(npc, "dark_troll_warlord_raise_dead")) then
      Ability.CastNoTarget(NPC.GetAbility(npc, "dark_troll_warlord_raise_dead"), true)
    end
  end
  AutoEnchantress.CheckDeadTime = GameRules.GetGameTime()
end

function AutoEnchantress.OnProjectile(projectile)
  if not projectile or not projectile.source or not projectile.target then return end
  if not projectile.isAttack then return end
  if not Heroes.GetLocal() or NPC.GetUnitName(Heroes.GetLocal()) ~= "npc_dota_hero_enchantress" then return end
  local myHero = Heroes.GetLocal()
  local mousePos = Input.GetWorldCursorPos()
  local enemy = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
  if projectile.source == myHero then
    local pike = NPC.GetItem(myHero, "item_hurricane_pike", true)
    if pike then
      AutoEnchantress.PikeSecondsSinceLastUse = Ability.SecondsSinceLastUse(pike)
    end
    AutoEnchantress.target = projectile.target
    AutoEnchantress.targetPos = NPC.GetAbsOrigin(projectile.target)
    AutoEnchantress.ProjectileTime = GameRules.GetGameTime()
    if pike and AutoEnchantress.PikeSecondsSinceLastUse <= 5 and AutoEnchantress.PikeSecondsSinceLastUse > 0 and AutoEnchantress.PikeAttackCount and AutoEnchantress.PikeAttackCount < 4 then
      if AutoEnchantress.PikeAttackCount == -1 then
        AutoEnchantress.PikeAttackCount = 1
      else
        AutoEnchantress.PikeAttackCount = AutoEnchantress.PikeAttackCount + 1
      end
    elseif pike and AutoEnchantress.PikeAttackCount and AutoEnchantress.PikeSecondsSinceLastUse and AutoEnchantress.PikeSecondsSinceLastUse > 5 or AutoEnchantress.PikeSecondsSinceLastUse < 0 or AutoEnchantress.PikeAttackCount >= 4 then
      AutoEnchantress.PikeAttackCount = -1
    elseif Menu.IsKeyDown(AutoEnchantress.ComboKey) then
      if Entity.IsAlive(myHero) and not Entity.IsDormant(myHero) and Entity.GetHealth(myHero) > 0 and not NPC.IsEntityInRange(myHero, enemy, AutoEnchantress.myRange) and not NPC.IsPositionInRange(myHero, Entity.GetAbsOrigin(enemy), AutoEnchantress.myRange, 0) or not enemy and GameRules.GetGameTime() - AutoEnchantress.OrbWalkTime >= .01 then
        Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, nil, AutoEnchantress.targetPos, nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero, queue, showEffects)
        AutoEnchantress.OrbWalkTime = GameRules.GetGameTime()
      end
    end
  end
end

--function AutoEnchantress.KiteEnemy(myHero, enemy)
--  if not AutoEnchantress.Kite then return end
--  if not enemy or (NPC.GetAbsOrigin(enemy) - NPC.GetAbsOrigin(myHero)):Length2D() >= AutoEnchantress.myRange - (AutoEnchantress.myRange * .25) or not Menu.IsKeyDown(AutoEnchantress.ComboKey) or not Entity.IsAlive(myHero) then
--    AutoEnchantress.Kite = false
--    return
--  end
--  if Menu.IsKeyDown(AutoEnchantress.ComboKey) then
--    if Entity.IsAlive(myHero) and not Entity.IsDormant(myHero) and Entity.GetHealth(myHero) > 0 and GameRules.GetGameTime() - AutoEnchantress.MoveOrderTime >= .01 then
--      Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, nil, AutoEnchantress.FleePos, nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero, queue, showEffects)
--      AutoEnchantress.MoveOrderTime = GameRules.GetGameTime()
--    end
--  end
--end

--function AutoEnchantress.InFront(myHero, heroPosition, castRange)
--  local vec = Entity.GetRotation(myHero):GetVectors()
--  if vec then
--    local x = heroPosition:GetX() + vec:GetX() * castRange
--    local y = heroPosition:GetY() + vec:GetY() * castRange
--    return Vector(x,y,0)
--  end
--end

--function AutoEnchantress.Behind(myHero)
--  local pos = NPC.GetAbsOrigin(myHero)
--  local fleeRange = 1000
--  local vec = nil
--  if Entity.GetRotation(myHero):GetYaw() + 180 >= 360 then
--    local get_yaw = Entity.GetRotation(myHero):GetYaw()
--    local new_yaw = get_yaw - 180
--    local hero_rot = Entity.GetRotation(myHero)
--    hero_rot:SetYaw(new_yaw)
--    vec = hero_rot:GetVectors()
--  elseif Entity.GetRotation(myHero):GetYaw() + 180 < 360 then
--    local get_yaw = Entity.GetRotation(myHero):GetYaw()
--    local new_yaw = get_yaw + 180
--    local hero_rot = Entity.GetRotation(myHero)
--    hero_rot:SetYaw(new_yaw)
--    vec = hero_rot:GetVectors()
--  end
--  if vec then
--    local x = pos:GetX() + vec:GetX() * fleeRange
--    local y = pos:GetY() + vec:GetY() * fleeRange
--    return Vector(x,y,0)
--  end
--end

function AutoEnchantress.OnUpdate()
  if not GameRules.GetGameState() == 5 then return end
  if not Heroes.GetLocal() or NPC.GetUnitName(Heroes.GetLocal()) ~= "npc_dota_hero_enchantress" then return end
  local myHero = Heroes.GetLocal()
  local myMana = NPC.GetMana(myHero)
  local myStr = Hero.GetStrengthTotal(myHero)
  local myAgi = Hero.GetAgilityTotal(myHero)
  local myInt = Hero.GetIntellectTotal(myHero)
  local mySpellAmp = 1 + (myInt * 0.07142857142) / 100
  local enemy = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
  local neutralEnemy = Input.GetNearestUnitToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
  local mousePos = Input.GetWorldCursorPos()
  local untouchable = NPC.GetAbility(myHero, "enchantress_untouchable")
  local enchant = NPC.GetAbility(myHero, "enchantress_enchant")
  local attendants = NPC.GetAbility(myHero, "enchantress_natures_attendants")
  local impetus = NPC.GetAbility(myHero, "enchantress_impetus")
  local impetus_talent = NPC.GetAbility(myHero, "special_bonus_unique_enchantress_4")
  local dominateItem = NPC.GetItem(myHero, "item_helm_of_the_dominator", true)

  local attackPoint = 0.3
  local impetus_damage_percent
  local pike = NPC.GetItem(myHero, "item_hurricane_pike", true)
  local lance = NPC.GetItem(myHero, "item_dragon_lance", true)

  if pike or lance then
    AutoEnchantress.myRange = NPC.GetAttackRange(myHero) + 190
  else
    AutoEnchantress.myRange = NPC.GetAttackRange(myHero)
  end

  if Ability.GetLevel(impetus) > 0 then
    impetus_damage_percent = 10 + Ability.GetLevel(impetus) * 4
  end

  if Ability.GetLevel(impetus_talent) > 0 and Ability.GetLevel(impetus) > 0 then
    impetus_damage_percent = impetus_damage_percent + 6
  end

  if Menu.IsKeyDownOnce(AutoEnchantress.DominateKey) then
    if dominateItem then
      AutoEnchantress.DominateBestEnemyInRange(myHero)
    end
  end

  if enchant and Menu.IsKeyDownOnce(AutoEnchantress.EnchantKey) then
    if Ability.GetLevel(enchant) > 0 then
      if Entity.IsAlive(myHero) and not Entity.IsDormant(myHero) and Entity.GetHealth(myHero) > 0 then
        AutoEnchantress.EnchantBestEnemyInRange(myHero, myMana, enchant)
      end
    end
  end

  if Entity.IsAlive(myHero) and not Entity.IsDormant(myHero) and Entity.GetHealth(myHero) > 0 then
    if Ability.GetLevel(attendants) > 0 then
      AutoEnchantress.AutoSave(myHero, myMana, attendants)
    end
    AutoEnchantress.AutoUseItems(myHero, myMana)
  end

  if Menu.IsKeyDownOnce(AutoEnchantress.EnchantAgainKey) then
    AutoEnchantress.inAutoSpellsMode = not AutoEnchantress.inAutoSpellsMode
  end

  if Menu.IsKeyDown(AutoEnchantress.ComboKey) then
    if Entity.IsAlive(myHero) and Entity.GetHealth(myHero) > 0 and not Entity.IsDormant(myHero) then
      AutoEnchantress.UseItems(myHero, enemy, myMana)
      AutoEnchantress.UseHeroAbilities(myHero, enemy, myMana, mySpellAmp, enchant, impetus, impetus_damage_percent, attackPoint, pike)
    end
    AutoEnchantress.UseUnitAbilities(myHero, enemy, myMana)
  end

  if Entity.IsAlive(myHero) and not Entity.IsDormant(myHero) and Entity.GetHealth(myHero) > 0 then
    AutoEnchantress.AutoKill(myHero, enemy, myMana, mySpellAmp, enchant, impetus, impetus_damage_percent, attackPoint)
  end

  AutoEnchantress.UnitsTryToBuffHeroes(myHero, myMana)

  if Menu.IsKeyDown(AutoEnchantress.FarmKey) then
    AutoEnchantress.UseUnitAbilitiesOnNPC(myHero, neutralEnemy, myMana)
  end

  if (AutoEnchantress.IsSuitableToUseItem(myHero) or AutoEnchantress.IsChannellingAbility(myHero)) then
    AutoEnchantress.item_glimmer_cape(myHero)
  end

  if AutoEnchantress.IsSuitableToUseItem(myHero) and NPC.IsVisible(myHero) then
    AutoEnchantress.item_sheepstick(myHero)
    AutoEnchantress.item_orchid(myHero)
    AutoEnchantress.item_rod_of_atos(myHero)
    AutoEnchantress.item_abyssal_blade(myHero)
    AutoEnchantress.item_veil_of_discord(myHero)
    AutoEnchantress.item_dagon(myHero)
    AutoEnchantress.item_hand_of_midas(myHero)
    AutoEnchantress.deward(myHero)
    AutoEnchantress.item_lotus_orb(myHero)
    AutoEnchantress.item_solar_crest(myHero)
  end

  if Entity.IsAlive(myHero) and not Entity.IsDormant(myHero) and Entity.GetHealth(myHero) > 0 then
    if Ability.GetLevel(NPC.GetAbility(Heroes.GetLocal(), "enchantress_impetus")) > 0 then
      if NPC.GetAbility(Heroes.GetLocal(), "enchantress_impetus") and AutoEnchantress.ImpetusWasOff and not Menu.IsKeyDown(AutoEnchantress.ComboKey) and GameRules.GetGameTime() - AutoEnchantress.ImpetusChangeStateTime > 0.25 then
        AutoEnchantress.ImpetusWasOff = false
        Engine.ExecuteCommand("dota_ability_autocast 5")
        AutoEnchantress.ImpetusChangeStateTime = GameRules.GetGameTime()
      end
    end
  end

  AutoEnchantress.AutoRaiseDead(myHero)

  if Ability.GetLevel(enchant) > 0 then
    if AutoEnchantress.inAutoSpellsMode then
      AutoEnchantress.EnchantUnitsAgain(myHero, myMana, enchant)
    end
  end

end

function AutoEnchantress.EnchantBestEnemyInRange(myHero, myMana, enchant)
  if Ability.GetLevel(enchant) <= 0 then return end
  local npcTable = {}
  if Ability.GetLevel(enchant) > 0 then
    if enchant and AutoEnchantress.IsSuitableToCastSpell(myHero) and not AutoEnchantress.IsDisabled(myHero) and Ability.IsReady(enchant) and Ability.IsCastable(enchant, myMana) and not Ability.IsChannelling(enchant) and not Ability.IsInAbilityPhase(enchant) then
      for _, npc in ipairs(NPC.GetUnitsInRadius(myHero, Ability.GetCastRange(enchant) + NPC.GetCastRangeBonus(myHero), Enum.TeamType.TEAM_ENEMY)) do
        if Entity.IsAlive(npc) and not Entity.IsDormant(npc) and Entity.GetHealth(npc) > 0 then
          table.insert(npcTable, npc)
        end
      end

      if Ability.GetLevel(NPC.GetAbility(myHero, "special_bonus_unique_enchantress_1")) > 0 then

        for _, creep in ipairs(AutoEnchantress.UsefulCreepNameList) do
          for _, npcName in ipairs(npcTable) do
            if creep == NPC.GetUnitName(npcName) then
              Ability.CastTarget(enchant, npcName)
              return
            end
          end
        end

      else

        for _, creep in ipairs(AutoEnchantress.UsefulNonAncientCreepNameList) do
          for _, npcName in ipairs(npcTable) do
            if creep == NPC.GetUnitName(npcName) then
              Ability.CastTarget(enchant, npcName)
              return
            end
          end
        end

      end

    end
  end
end



function AutoEnchantress.EnchantUnitsAgain(myHero, myMana, enchant)
  if Ability.GetLevel(enchant) > 0 then
    if GameRules.GetGameTime() - AutoEnchantress.EnchantAgainTime > 1 then
      Log.Write("enchant again")
      AutoEnchantress.EnchantAgainTime = GameRules.GetGameTime()
      for _, neutral in ipairs(NPC.GetUnitsInRadius(myHero, Ability.GetCastRange(enchant) + NPC.GetCastRangeBonus(myHero), Enum.TeamType.TEAM_FRIEND)) do
        if Entity.IsAlive(neutral) and not Entity.IsDormant(neutral) and not Entity.IsHero(neutral) and not NPC.HasState(neutral, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) and not NPC.IsStructure(neutral) and NPC.HasModifier(neutral, "modifier_dominated") and (Entity.GetOwner(myHero) == Entity.GetOwner(neutral) or Entity.OwnedBy(neutral, myHero)) then
          local hasMod = NPC.GetModifier(neutral, "modifier_dominated")
          if hasMod then
            local dietime = Modifier.GetDieTime(hasMod) - GameRules.GetGameTime()
            if GameRules.GetGameTime() > Modifier.GetDieTime(NPC.GetModifier(neutral, "modifier_dominated")) then
              AutoEnchantress.HelmUnit = neutral
            elseif GameRules.GetGameTime() < Modifier.GetDieTime(NPC.GetModifier(neutral, "modifier_dominated")) and Modifier.GetDieTime(NPC.GetModifier(neutral, "modifier_dominated")) - GameRules.GetGameTime() <= 2 and Entity.IsAlive(neutral) and Entity.GetHealth(neutral) and AutoEnchantress.IsSuitableToCastSpell(myHero) and not AutoEnchantress.IsDisabled(myHero) and Ability.IsReady(enchant) and Ability.IsCastable(enchant, myMana) and not Ability.IsInAbilityPhase(enchant) then
              Ability.CastTarget(enchant, neutral)
              return
            end
          end
        end
      end
    end
  end
end

function AutoEnchantress.DominateBestEnemyInRange(myHero)
  local npcTable = {}
  local dominateItem = NPC.GetItem(myHero, "item_helm_of_the_dominator", true)
  if not dominateItem then return end
  local dominateRange = Ability.GetCastRange(dominateItem) + NPC.GetCastRangeBonus(myHero)
  if AutoEnchantress.IsSuitableToCastSpell(myHero) and not AutoEnchantress.IsDisabled(myHero) and Ability.IsReady(dominateItem) then
    for _, npc in ipairs(NPC.GetUnitsInRadius(myHero, dominateRange, Enum.TeamType.TEAM_ENEMY)) do
      if Entity.IsAlive(npc) and not Entity.IsDormant(npc) and Entity.GetHealth(npc) then
        table.insert(npcTable, npc)
      end
    end
    for _, creep in ipairs(AutoEnchantress.UsefulCreepNameList) do
      for _, npcName in ipairs(npcTable) do
        if creep == NPC.GetUnitName(npcName) then
          Ability.CastTarget(dominateItem, npcName)
          return
        end
      end
    end
  end
end

function AutoEnchantress.AutoKill(myHero, enemy, myMana, mySpellAmp, enchant, impetus, impetus_damage_percent, attackPoint)
  if GameRules.GetGameTime() - AutoEnchantress.UnitAbilityUseTime < AutoEnchantress.Delay then return end
  for _, npc in pairs(NPC.GetHeroesInRadius(myHero, 99999, Enum.TeamType.TEAM_ENEMY)) do
    if npc and Entity.IsHero(npc) and Entity.IsAlive(npc) then
      local dis = (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(npc)):Length()
      local enchantress_max_damage = NPC.GetTrueMaximumDamage(myHero) * NPC.GetArmorDamageMultiplier(npc)
      -- Kill with Impetus
      if Ability.GetLevel(impetus) > 0  then
        local impetus_max_damage = dis * (impetus_damage_percent / 100)
        if not NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_ATTACK_IMMUNE) and not AutoEnchantress.IsDisabled(myHero) and impetus and Ability.IsCastable(impetus, myMana) and not Ability.IsInAbilityPhase(impetus) and NPC.IsEntityInRange(myHero, npc, Ability.GetCastRange(impetus)) and not Ability.IsChannelling(impetus) and Entity.GetHealth(npc) <= NPC.GetArmorDamageMultiplier(npc) * (impetus_max_damage + enchantress_max_damage) then
          Ability.CastTarget(impetus, npc)
          AutoEnchantress.UnitAbilityUseTime = GameRules.GetGameTime()
          return 
        end
      end
      -- Kill with Right Click
      if (Ability.GetLevel(impetus) == 0 or not Ability.IsCastable(impetus, myMana)) and not NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_ATTACK_IMMUNE) and not AutoEnchantress.IsDisabled(myHero) and NPC.IsEntityInRange(myHero, npc, AutoEnchantress.myRange) and Entity.GetHealth(npc) <= (NPC.GetDamageMultiplierVersus(myHero, npc) * (NPC.GetTrueMaximumDamage(myHero) * NPC.GetArmorDamageMultiplier(npc))) and GameRules.GetGameTime() - AutoEnchantress.ProjectileTime > attackPoint / (1 + (Hero.GetAgilityTotal(myHero)/100)) then
        Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET, npc, Vector(0, 0, 0), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_SELECTED_UNITS, nil)
        return
      end
    end
  end
end

function AutoEnchantress.CallAndGoInvis(myHero, myMana, teleport)
--  local shadow_blade = NPC.GetItem(myHero, "item_invis_sword", true)
--  local silver_edge = NPC.GetItem(myHero, "item_silver_edge", true)
--  if silver_edge and Ability.IsReady(silver_edge) and Ability.IsCastable(silver_edge, myMana) and not Ability.IsInAbilityPhase(silver_edge) then
--    if teleport and Ability.IsReady(teleport) and Ability.IsCastable(teleport, myMana) and not Ability.IsInAbilityPhase(teleport) then
--      Ability.CastTarget(teleport, myHero)
--      AutoEnchantress.ReadyToInvisTime = GameRules.GetGameTime() + Ability.GetCastPoint(teleport) + .05
--    elseif not teleport or not Ability.IsReady(teleport) then
--      AutoEnchantress.ReadyToInvisTime = GameRules.GetGameTime()
--    end
--    return
--  end
--  if shadow_blade and Ability.IsReady(shadow_blade) and Ability.IsCastable(shadow_blade, myMana) and not Ability.IsInAbilityPhase(shadow_blade) then
--    if teleport and Ability.IsReady(teleport) and Ability.IsCastable(teleport, myMana) and not Ability.IsInAbilityPhase(teleport) then
--      Ability.CastTarget(teleport, myHero)
--      AutoEnchantress.ReadyToInvisTime = GameRules.GetGameTime() + Ability.GetCastPoint(teleport) + .05
--    elseif not teleport or not Ability.IsReady(teleport) then
--      AutoEnchantress.ReadyToInvisTime = GameRules.GetGameTime()
--    end
--    return
--  end
end

function AutoEnchantress.ReadyToInvisCheck(myHero, myMana)
--  if not AutoEnchantress.ReadyToInvisTime then return end
--  local shadow_blade = NPC.GetItem(myHero, "item_invis_sword", true)
--  local silver_edge = NPC.GetItem(myHero, "item_silver_edge", true)
--  if GameRules.GetGameTime() >= AutoEnchantress.ReadyToInvisTime then
--    AutoEnchantress.ReadyToInvisTime = nil
--    if silver_edge and Ability.IsReady(silver_edge) and Ability.IsCastable(silver_edge, myMana) and not Ability.IsInAbilityPhase(silver_edge) then
--      Ability.CastNoTarget(silver_edge)
--    end
--    if shadow_blade and Ability.IsReady(shadow_blade) and Ability.IsCastable(shadow_blade, myMana) and not Ability.IsInAbilityPhase(shadow_blade) then
--      Ability.CastNoTarget(shadow_blade)
--    end
--  end
end

function AutoEnchantress.OnDraw()
  if not GameRules.GetGameState() == 5 then return end
  local myHero = Heroes.GetLocal()
  if not myHero or NPC.GetUnitName(myHero) ~= "npc_dota_hero_enchantress" then return end
  if GameRules.GetGameTime() - AutoEnchantress.CircleDrawTime > 1 then
    Engine.ExecuteCommand("dota_range_display " .. tostring(AutoEnchantress.myRange))
    AutoEnchantress.CircleDrawTime = GameRules.GetGameTime()
  end

  if AutoEnchantress.inAutoSpellsMode then 
    -- draw text when auto spells key is up
    local posMH = Entity.GetAbsOrigin(myHero)
    local xMH, yMH, visible = Renderer.WorldToScreen(posMH)
    Renderer.SetDrawColor(0, 255, 0, 255)
    Renderer.DrawText(AutoEnchantress.Font, xMH-15, yMH+15, "⭮", 1)
  end

  local impetus = NPC.GetAbility(myHero, "enchantress_impetus")
  if Ability.GetLevel(impetus) > 0 then
    local impetusCount = AutoEnchantress.round(NPC.GetMana(myHero) / Ability.GetManaCost(impetus), 1)
    local myHeroPos = NPC.GetAbsOrigin(myHero)
    local xH, yH, visibleH = Renderer.WorldToScreen(myHeroPos)
    if visibleH then
      if impetusCount >= 4 then
        Renderer.SetDrawColor(0, 255, 0, 255)
      elseif impetusCount >= 1 then
        Renderer.SetDrawColor(255, 255, 0, 255)
      else
        Renderer.SetDrawColor(255, 0, 0, 255)      
      end
      Renderer.DrawText(AutoEnchantress.Font, xH+15, yH+15, tostring(impetusCount), 1)
    end
  end

  for _, npc in ipairs(NPC.GetUnitsInRadius(myHero, 99999, Enum.TeamType.TEAM_FRIEND)) do
    if AutoEnchantress.HelmUnit and Entity.IsAlive(AutoEnchantress.HelmUnit) and not Entity.IsDormant(AutoEnchantress.HelmUnit) and Entity.GetHealth(AutoEnchantress.HelmUnit) and (Entity.GetOwner(myHero) == Entity.GetOwner(AutoEnchantress.HelmUnit) or Entity.OwnedBy(AutoEnchantress.HelmUnit, myHero)) then 
      local pos3 = NPC.GetAbsOrigin(AutoEnchantress.HelmUnit)
      local x3, y3, visible3 = Renderer.WorldToScreen(pos3)
      if visible3 and AutoEnchantress.HelmUnit then
        Renderer.SetDrawColor(255, 255, 255, 255)
        Renderer.DrawText(AutoEnchantress.Font, x3+15, y3, "DOM", 1)
      end
    end

    if Entity.IsAlive(npc) and not Entity.IsDormant(npc) and not NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) and not NPC.IsStructure(npc) and Entity.GetHealth(npc) and not Entity.IsHero(npc) and (Entity.GetOwner(myHero) == Entity.GetOwner(npc) or Entity.OwnedBy(npc, myHero)) then
      local hasMod = NPC.GetModifier(npc, "modifier_dominated")
      if hasMod then
        local realdietime = Modifier.GetDieTime(hasMod)
        local dietime = Modifier.GetDieTime(hasMod) - GameRules.GetGameTime()
        local posE = NPC.GetAbsOrigin(npc)
        local xE, yE, visibleE = Renderer.WorldToScreen(posE)
        if visibleE and GameRules.GetGameTime() < realdietime then
          Renderer.SetDrawColor(255, 0, 0, 255)
          Renderer.DrawText(AutoEnchantress.Font, xE-15, yE-15, "\n" .. "\n" .. "\n" .. tostring(math.ceil(AutoEnchantress.round(dietime))), 1)
        end
      end
    end

    local pos = NPC.GetAbsOrigin(npc)
    local x, y, visible = Renderer.WorldToScreen(pos)
    if visible and npc then
      local SpellCount = 0
      Renderer.SetDrawColor(255, 255, 255, 255)
      for _, spell in ipairs(AutoEnchantress.InteractiveAbilities) do
        if NPC.GetAbility(npc, spell) then
          SpellCount = SpellCount + 1
          if SpellCount == 3 then
            if Ability.GetCooldownTimeLeft(NPC.GetAbility(npc, spell)) > 0 then
              Renderer.DrawText(AutoEnchantress.Font, x-15, y-15, "\n" .. "\n" .. tostring(math.ceil(Ability.GetCooldownTimeLeft(NPC.GetAbility(npc, spell)))), 1) -- tostring(Ability.GetName(NPC.GetAbility(npc, spell))) .. " " .. 
            end
          elseif SpellCount == 2 then
            if Ability.GetCooldownTimeLeft(NPC.GetAbility(npc, spell)) > 0 then
              Renderer.DrawText(AutoEnchantress.Font, x-15, y-15, "\n" .. tostring(math.ceil(Ability.GetCooldownTimeLeft(NPC.GetAbility(npc, spell)))), 1) --tostring(Ability.GetName(NPC.GetAbility(npc, spell))) .. " " .. 
            end
          else
            if Ability.GetCooldownTimeLeft(NPC.GetAbility(npc, spell)) > 0 then
              Renderer.DrawText(AutoEnchantress.Font, x-15, y-15, tostring(math.ceil(Ability.GetCooldownTimeLeft(NPC.GetAbility(npc, spell)))), 1) --tostring(Ability.GetName(NPC.GetAbility(npc, spell))) .. " "
            end
          end
        end
      end
    end
  end
end

function AutoEnchantress.UseItems(myHero, enemy, myMana, mySpellAmp, enchant, impetus, impetus_damage_percent, attackPoint)
  if NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then return end
  if GameRules.GetGameTime() - AutoEnchantress.ItemUseTime < AutoEnchantress.Delay then return end
  for _, item in ipairs(AutoEnchantress.InteractiveItems) do
    if NPC.GetItem(myHero, item, true) and Ability.IsReady(NPC.GetItem(myHero, item, true)) and Ability.IsCastable(NPC.GetItem(myHero, item, true), myMana) and not Ability.IsInAbilityPhase(NPC.GetItem(myHero, item, true)) then --and not NPC.IsLinkensProtected(enemy)
      if Ability.GetCastRange(NPC.GetItem(myHero, item, true)) > 0 then
        if item == "item_hurricane_pike" then
          if NPC.IsEntityInRange(myHero, enemy, 400) then
            Ability.CastTarget(NPC.GetItem(myHero, item, true), enemy)
            AutoEnchantress.ItemUseTime = GameRules.GetGameTime()
            AutoEnchantress.PikeEnemy = enemy
          end
        else
          if NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(NPC.GetItem(myHero, item, true)) + NPC.GetCastRangeBonus(myHero)) then
            Ability.CastTarget(NPC.GetItem(myHero, item, true), enemy)
            AutoEnchantress.ItemUseTime = GameRules.GetGameTime()
          end
        end
      elseif Ability.GetCastRange(NPC.GetItem(myHero, item, true)) == 0 then
        if NPC.IsEntityInRange(myHero, enemy, AutoEnchantress.myRange) then
          if item == "item_black_king_bar" then
            if Menu.IsEnabled(AutoEnchantress.BlackKingBarDuringCombo) then
              Ability.CastNoTarget(NPC.GetItem(myHero, item, true))
              AutoEnchantress.ItemUseTime = GameRules.GetGameTime()
            end
          else
            Ability.CastNoTarget(NPC.GetItem(myHero, item, true))
            AutoEnchantress.ItemUseTime = GameRules.GetGameTime()
          end
        end
      end
    end
  end
end

function AutoEnchantress.UseUnitAbilities(myHero, enemy, myMana)
  if not enemy or not Entity.IsAlive(enemy) or Entity.IsDormant(enemy) or Entity.GetHealth(enemy) <= 0 or not NPC.IsPositionInRange(enemy, Input.GetWorldCursorPos(), 500, 0) then return end
  if GameRules.GetGameTime() - AutoEnchantress.UnitAbilityUseTime < AutoEnchantress.Delay then return end
  for _, npc in ipairs(NPC.GetUnitsInRadius(myHero, 99999, Enum.TeamType.TEAM_FRIEND)) do
    if Entity.IsAlive(npc) and not Entity.IsDormant(npc) and Entity.GetHealth(npc) and (Entity.GetOwner(myHero) == Entity.GetOwner(npc) or Entity.OwnedBy(npc, myHero)) then
      for _, ability in ipairs(AutoEnchantress.InteractiveAbilities) do
        if ability ~= "dark_troll_warlord_raise_dead" and ability ~= "forest_troll_high_priest_heal" and ability ~= "enraged_wildkin_tornado" and ability ~= "ogre_magi_frost_armor" and ability ~= "big_thunder_lizard_frenzy" then
          if NPC.HasAbility(npc, ability) and Ability.IsCastable(NPC.GetAbility(npc, ability), NPC.GetMana(npc)) and Ability.IsReady(NPC.GetAbility(npc, ability)) and not Ability.IsInAbilityPhase(NPC.GetAbility(npc, ability)) and not NPC.IsLinkensProtected(enemy) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
            if Ability.GetCastRange(NPC.GetAbility(npc, ability)) > 0 then
              if NPC.IsEntityInRange(npc, enemy, Ability.GetCastRange(NPC.GetAbility(npc, ability)) + NPC.GetCastRangeBonus(npc)) then
                if ability == "black_dragon_fireball" then
                  Ability.CastPosition(NPC.GetAbility(npc, ability), Entity.GetAbsOrigin(enemy))
                  AutoEnchantress.UnitAbilityUseTime = GameRules.GetGameTime()
                  return
                end
                if ability == "spawnlord_master_freeze" or ability == "dark_troll_warlord_ensnare" or ability == "mud_golem_hurl_boulder" then
                  if ((NPC.IsStunned(enemy) or NPC.HasModifier(enemy, "modifier_rooted") or NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_ROOTED)) and GameRules.GetGameTime() < AutoEnchantress.StunTime + AutoEnchantress.StunDuration) or GameRules.GetGameTime() < AutoEnchantress.StunTime + AutoEnchantress.StunDuration then
                    return
                  end
                  if GameRules.GetGameTime() >= AutoEnchantress.StunTime + AutoEnchantress.StunDuration then
                    Ability.CastTarget(NPC.GetAbility(npc, ability), enemy)
                    AutoEnchantress.StunTime = GameRules.GetGameTime()
                    if ability == "spawnlord_master_freeze" then
                      AutoEnchantress.StunDuration = 2
                    end
                    if ability == "dark_troll_warlord_ensnare" then
                      AutoEnchantress.StunDuration = 1.75
                    end
                    if ability == "mud_golem_hurl_boulder" then
                      AutoEnchantress.StunDuration = 0.6
                    end
                    AutoEnchantress.UnitAbilityUseTime = GameRules.GetGameTime()
                    return
                  end
                end
                Ability.CastTarget(NPC.GetAbility(npc, ability), enemy)
                AutoEnchantress.UnitAbilityUseTime = GameRules.GetGameTime()
                return
              end
            end

            if Ability.GetCastRange(NPC.GetAbility(npc, ability)) == 0 then
              if ability == "big_thunder_lizard_slam" then
                if NPC.IsEntityInRange(npc, enemy, 250) then
                  Ability.CastNoTarget(NPC.GetAbility(npc, ability))
                  AutoEnchantress.UnitAbilityUseTime = GameRules.GetGameTime()
                  return
                end
              end
              if ability == "centaur_khan_war_stomp" then
                if ((NPC.IsStunned(enemy) or NPC.HasModifier(enemy, "modifier_rooted") or NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_ROOTED)) and GameRules.GetGameTime() < AutoEnchantress.StunTime + AutoEnchantress.StunDuration) or GameRules.GetGameTime() < AutoEnchantress.StunTime + AutoEnchantress.StunDuration then
                  return
                end
                if GameRules.GetGameTime() >= AutoEnchantress.StunTime + AutoEnchantress.StunDuration and NPC.IsPositionInRange(npc, AutoEnchantress.GetPredictedPosition(enemy, 0.5), 240) then
                  Ability.CastNoTarget(NPC.GetAbility(npc, ability))
                  AutoEnchantress.StunTime = GameRules.GetGameTime()
                  AutoEnchantress.StunDuration = 2
                  AutoEnchantress.UnitAbilityUseTime = GameRules.GetGameTime()
                  return
                end
              end
              if NPC.IsEntityInRange(npc, enemy, NPC.GetAttackRange(npc)) then
                Ability.CastNoTarget(NPC.GetAbility(npc, ability))
                AutoEnchantress.UnitAbilityUseTime = GameRules.GetGameTime()
                return
              end
            end
          end
        end
      end
    end
  end
end

function AutoEnchantress.UseUnitAbilitiesOnNPC(myHero, enemy, myMana)
  if not enemy or not Entity.IsAlive(enemy) or Entity.IsDormant(enemy) or Entity.GetHealth(enemy) <= 0 or not NPC.IsPositionInRange(enemy, Input.GetWorldCursorPos(), 500, 0) and GameRules.GetGameTime() - AutoEnchantress.MoveNPCOrderTime > 0.05 then
    Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, nil, Input.GetWorldCursorPos(), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_SELECTED_UNITS, nil)
    AutoEnchantress.MoveNPCOrderTime = GameRules.GetGameTime()
    return 
  end
  if enemy and NPC.IsPositionInRange(enemy, Input.GetWorldCursorPos(), 500, 0) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_ATTACK_IMMUNE) and GameRules.GetGameTime() - AutoEnchantress.AttackNPCOrderTime > 0.96  then
    Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET, enemy, Vector(0, 0, 0), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_SELECTED_UNITS, nil)
    AutoEnchantress.AttackNPCOrderTime = GameRules.GetGameTime()
    return
  end
  if GameRules.GetGameTime() - AutoEnchantress.UnitAbilityUseTime < AutoEnchantress.Delay then return end
  for _, npc in ipairs(NPC.GetUnitsInRadius(myHero, 99999, Enum.TeamType.TEAM_FRIEND)) do
    if Entity.IsAlive(npc) and not Entity.IsDormant(npc) and Entity.GetHealth(npc) and (Entity.GetOwner(myHero) == Entity.GetOwner(npc) or Entity.OwnedBy(npc, myHero)) then
      for _, ability in ipairs(AutoEnchantress.InteractiveAbilities) do
        if ability ~= "dark_troll_warlord_raise_dead" and ability ~= "forest_troll_high_priest_heal" and ability ~= "enraged_wildkin_tornado" and ability ~= "ogre_magi_frost_armor" and ability ~= "big_thunder_lizard_frenzy" and ability ~= "dark_troll_warlord_ensnare" then
          if NPC.HasAbility(npc, ability) and Ability.IsCastable(NPC.GetAbility(npc, ability), NPC.GetMana(npc)) and Ability.IsReady(NPC.GetAbility(npc, ability)) and not Ability.IsInAbilityPhase(NPC.GetAbility(npc, ability)) and not NPC.IsLinkensProtected(enemy) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
            if Ability.GetCastRange(NPC.GetAbility(npc, ability)) > 0 then
              if NPC.IsEntityInRange(npc, enemy, Ability.GetCastRange(NPC.GetAbility(npc, ability)) + NPC.GetCastRangeBonus(npc)) then
                if ability == "black_dragon_fireball" then
                  Ability.CastPosition(NPC.GetAbility(npc, ability), Entity.GetAbsOrigin(enemy))
                  AutoEnchantress.UnitAbilityUseTime = GameRules.GetGameTime()
                  return
                end
                if ability == "spawnlord_master_freeze" or ability == "dark_troll_warlord_ensnare" or ability == "mud_golem_hurl_boulder" then
                  if ((NPC.IsStunned(enemy) or NPC.HasModifier(enemy, "modifier_rooted") or NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_ROOTED)) and GameRules.GetGameTime() < AutoEnchantress.StunTime + AutoEnchantress.StunDuration) or GameRules.GetGameTime() < AutoEnchantress.StunTime + AutoEnchantress.StunDuration then
                    return
                  end
                  if GameRules.GetGameTime() >= AutoEnchantress.StunTime + AutoEnchantress.StunDuration then
                    Ability.CastTarget(NPC.GetAbility(npc, ability), enemy)
                    AutoEnchantress.StunTime = GameRules.GetGameTime()
                    if ability == "spawnlord_master_freeze" then
                      AutoEnchantress.StunDuration = 2
                    end
                    if ability == "dark_troll_warlord_ensnare" then
                      AutoEnchantress.StunDuration = 1.75
                    end
                    if ability == "mud_golem_hurl_boulder" then
                      AutoEnchantress.StunDuration = 0.6
                    end
                    AutoEnchantress.UnitAbilityUseTime = GameRules.GetGameTime()
                    return
                  end
                end
                Ability.CastTarget(NPC.GetAbility(npc, ability), enemy)
                AutoEnchantress.UnitAbilityUseTime = GameRules.GetGameTime()
                return
              end
            end

            if Ability.GetCastRange(NPC.GetAbility(npc, ability)) == 0 then
              if ability == "big_thunder_lizard_slam" then
                if NPC.IsEntityInRange(npc, enemy, 250) then
                  Ability.CastNoTarget(NPC.GetAbility(npc, ability))
                  AutoEnchantress.UnitAbilityUseTime = GameRules.GetGameTime()
                  return
                end
              end
              if ability == "centaur_khan_war_stomp" then
                if ((NPC.IsStunned(enemy) or NPC.HasModifier(enemy, "modifier_rooted") or NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_ROOTED)) and GameRules.GetGameTime() < AutoEnchantress.StunTime + AutoEnchantress.StunDuration) or GameRules.GetGameTime() < AutoEnchantress.StunTime + AutoEnchantress.StunDuration then
                  return
                end
                if GameRules.GetGameTime() >= AutoEnchantress.StunTime + AutoEnchantress.StunDuration and NPC.IsPositionInRange(npc, AutoEnchantress.GetPredictedPosition(enemy, 0.5), 200) then
                  Ability.CastNoTarget(NPC.GetAbility(npc, ability))
                  AutoEnchantress.StunTime = GameRules.GetGameTime()
                  AutoEnchantress.StunDuration = 2
                  AutoEnchantress.UnitAbilityUseTime = GameRules.GetGameTime()
                  return
                end
              end
              if NPC.IsEntityInRange(npc, enemy, NPC.GetAttackRange(npc)) then
                Ability.CastNoTarget(NPC.GetAbility(npc, ability))
                AutoEnchantress.UnitAbilityUseTime = GameRules.GetGameTime()
                return
              end
            end
          end
        end
      end
    end
  end
end

function AutoEnchantress.UseHeroAbilities(myHero, enemy, myMana, mySpellAmp, enchant, impetus, impetus_damage_percent, attackPoint, pike)
  -- Turn on impetus autocast if it was off autocast
  if Entity.IsAlive(myHero) and not Entity.IsDormant(myHero) and Entity.GetHealth(myHero) > 0 then
    if Ability.GetLevel(NPC.GetAbility(Heroes.GetLocal(), "enchantress_impetus")) > 0 then
      if NPC.GetAbility(Heroes.GetLocal(), "enchantress_impetus") and Ability.GetAutoCastState(NPC.GetAbility(Heroes.GetLocal(), "enchantress_impetus")) == false and GameRules.GetGameTime() - AutoEnchantress.ImpetusChangeStateTime > 0.25 then
        Engine.ExecuteCommand("dota_ability_autocast 5")
        AutoEnchantress.ImpetusChangeStateTime = GameRules.GetGameTime()
        AutoEnchantress.ImpetusWasOff = true
      end
    end
  end

  if pike then
    AutoEnchantress.PikeSecondsSinceLastUse = Ability.SecondsSinceLastUse(pike)
    if Ability.SecondsSinceLastUse(pike) == -1 then
      AutoEnchantress.PikeEnemy = nil
    end
  end

  if pike and AutoEnchantress.PikeEnemy and AutoEnchantress.PikeSecondsSinceLastUse and AutoEnchantress.PikeAttackCount and AutoEnchantress.PikeSecondsSinceLastUse <= 5 and AutoEnchantress.PikeSecondsSinceLastUse > 0 and AutoEnchantress.PikeAttackCount and AutoEnchantress.PikeAttackCount < 4 then
    if not Entity.IsAlive(AutoEnchantress.PikeEnemy) or Entity.IsDormant(AutoEnchantress.PikeEnemy) or Entity.GetHealth(AutoEnchantress.PikeEnemy) <= 0 or not NPC.IsPositionInRange(AutoEnchantress.PikeEnemy, Input.GetWorldCursorPos(), 99999, 0) and GameRules.GetGameTime() - AutoEnchantress.MoveOrderTime > 0.05 then
      Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, nil, Input.GetWorldCursorPos(), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_SELECTED_UNITS, nil)
      AutoEnchantress.MoveOrderTime = GameRules.GetGameTime()
      return 
    end
    if not NPC.HasState(AutoEnchantress.PikeEnemy, Enum.ModifierState.MODIFIER_STATE_ATTACK_IMMUNE) then
      --if AutoEnchantress.ProjectileTime and GameRules.GetGameTime() - AutoEnchantress.ProjectileTime > attackPoint / (1 + (Hero.GetAgilityTotal(myHero)/100)) and GameRules.GetGameTime() - AutoEnchantress.AttackOrderTime > 0.05 then
      Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET, AutoEnchantress.PikeEnemy, Vector(0, 0, 0), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_SELECTED_UNITS, nil)
      --end
      AutoEnchantress.AttackOrderTime = GameRules.GetGameTime()
      return
    end

  else

    if not enemy or not Entity.IsAlive(enemy) or Entity.IsDormant(enemy) or Entity.GetHealth(enemy) <= 0 or not NPC.IsPositionInRange(enemy, Input.GetWorldCursorPos(), 500, 0) and GameRules.GetGameTime() - AutoEnchantress.MoveOrderTime > 0.05 then
      Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, nil, Input.GetWorldCursorPos(), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_SELECTED_UNITS, nil)
      AutoEnchantress.MoveOrderTime = GameRules.GetGameTime()
      return 
    end

    if Entity.IsAlive(myHero) and not Entity.IsDormant(myHero) and Entity.GetHealth(myHero) and AutoEnchantress.IsSuitableToCastSpell(myHero) and AutoEnchantress.CanCastSpellOn(enemy) and not AutoEnchantress.IsDisabled(myHero) and enemy and Entity.IsAlive(enemy) and not Entity.IsDormant(enemy) and Entity.GetHealth(enemy) > 0 and NPC.IsPositionInRange(enemy, Input.GetWorldCursorPos(), 500, 0) then
      if Ability.GetLevel(NPC.GetAbility(Heroes.GetLocal(), "enchantress_enchant")) > 0 then
        if enchant and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(enchant) + NPC.GetCastRangeBonus(myHero)) and not Ability.IsChannelling(enchant) and Ability.IsReady(enchant) and not Ability.IsInAbilityPhase(enchant) and GameRules.GetGameTime() - AutoEnchantress.HeroAbilityUseTime > AutoEnchantress.Delay then
          Ability.CastTarget(enchant, enemy)
          AutoEnchantress.HeroAbilityUseTime = GameRules.GetGameTime()
          return 
        end
      end

      if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_ATTACK_IMMUNE) then
        if AutoEnchantress.ProjectileTime and GameRules.GetGameTime() - AutoEnchantress.ProjectileTime > attackPoint / (1 + (Hero.GetAgilityTotal(myHero)/100)) and GameRules.GetGameTime() - AutoEnchantress.AttackOrderTime > 0.05 then
          Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET, enemy, Vector(0, 0, 0), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_SELECTED_UNITS, nil)
          AutoEnchantress.AttackOrderTime = GameRules.GetGameTime()
          return
        end
      end
    end
  end
end

function AutoEnchantress.UnitsTryToBuffHeroes(myHero, myMana)
  AutoEnchantress.NeutralToBuffWithOgre = nil
  AutoEnchantress.HeroToBuffWithPriest = nil
  AutoEnchantress.HeroToBuffWithOgre = nil
  AutoEnchantress.HeroToBuffWithLizard = nil  
  if GameRules.GetGameTime() - AutoEnchantress.UnitAbilityUseTime < AutoEnchantress.Delay then return end
  for _, npc in ipairs(NPC.GetUnitsInRadius(myHero, 99999, Enum.TeamType.TEAM_FRIEND)) do
    if NPC.GetUnitName(npc) == "npc_dota_neutral_forest_troll_high_priest" and Entity.IsAlive(npc) and not Entity.IsDormant(npc) and Entity.GetHealth(npc) and (Entity.GetOwner(myHero) == Entity.GetOwner(npc) or Entity.OwnedBy(npc, myHero)) and NPC.HasAbility(npc, "forest_troll_high_priest_heal") and Ability.IsCastable(NPC.GetAbility(npc, "forest_troll_high_priest_heal"), NPC.GetMana(npc)) and Ability.IsReady(NPC.GetAbility(npc, "forest_troll_high_priest_heal")) then
      for _, hero in ipairs(NPC.GetHeroesInRadius(npc, Ability.GetCastRange(NPC.GetAbility(npc, "forest_troll_high_priest_heal")), Enum.TeamType.TEAM_FRIEND)) do 
        if Entity.IsAlive(hero) and not Entity.IsDormant(hero) and not NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) and not NPC.IsStructure(hero) and Entity.GetHealth(hero) < Entity.GetMaxHealth(hero) and not NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_ATTACK_IMMUNE) then
          if not lowestHealth or not AutoEnchantress.HeroToBuffWithPriest then
            local lowestHealth = Entity.GetHealth(hero)
            AutoEnchantress.HeroToBuffWithPriest = hero
          end
          if lowestHealth and AutoEnchantress.HeroToBuffWithPriest and Entity.GetHealth(hero) < lowestHealth then
            lowestHealth = Entity.GetHealth(hero)
            AutoEnchantress.HeroToBuffWithPriest = hero
          end
        end
      end
      if AutoEnchantress.HeroToBuffWithPriest then
        Ability.CastTarget(NPC.GetAbility(npc, "forest_troll_high_priest_heal"), AutoEnchantress.HeroToBuffWithPriest)
        AutoEnchantress.UnitAbilityUseTime = GameRules.GetGameTime()
        AutoEnchantress.HeroToBuffWithPriest = nil
        return
      end
    end

    if NPC.GetUnitName(npc) == "npc_dota_neutral_big_thunder_lizard" and Entity.IsAlive(npc) and not Entity.IsDormant(npc) and Entity.GetHealth(npc) and (Entity.GetOwner(myHero) == Entity.GetOwner(npc) or Entity.OwnedBy(npc, myHero)) and NPC.HasAbility(npc, "big_thunder_lizard_frenzy") and Ability.IsCastable(NPC.GetAbility(npc, "big_thunder_lizard_frenzy"), NPC.GetMana(npc)) and Ability.IsReady(NPC.GetAbility(npc, "big_thunder_lizard_frenzy")) then
      for _, hero in ipairs(NPC.GetHeroesInRadius(npc, Ability.GetCastRange(NPC.GetAbility(npc, "big_thunder_lizard_frenzy")), Enum.TeamType.TEAM_FRIEND)) do 
        if Entity.IsAlive(hero) and not Entity.IsDormant(hero) and not NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) and not NPC.IsStructure(hero) and Entity.GetHealth(hero) and not NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_ATTACK_IMMUNE) and not NPC.HasModifier(hero, "modifier_big_thunder_lizard_frenzy") then
          if not lowestHealth or not AutoEnchantress.HeroToBuffWithLizard then
            local lowestHealth = Entity.GetHealth(hero)
            AutoEnchantress.HeroToBuffWithLizard = hero
          end
          if lowestHealth and AutoEnchantress.HeroToBuffWithLizard and Entity.GetHealth(hero) < lowestHealth then
            lowestHealth = Entity.GetHealth(hero)
            AutoEnchantress.HeroToBuffWithLizard = hero
          end
        end
      end
      if AutoEnchantress.HeroToBuffWithLizard then
        local enemyAround = NPC.GetHeroesInRadius(AutoEnchantress.HeroToBuffWithLizard, NPC.GetAttackRange(AutoEnchantress.HeroToBuffWithLizard), Enum.TeamType.TEAM_ENEMY)
        if #enemyAround > 0 then
          Ability.CastTarget(NPC.GetAbility(npc, "big_thunder_lizard_frenzy"), AutoEnchantress.HeroToBuffWithLizard)
          AutoEnchantress.UnitAbilityUseTime = GameRules.GetGameTime()
          AutoEnchantress.HeroToBuffWithLizard = nil
          return
        end
      end
    end
    if NPC.GetUnitName(npc) == "npc_dota_neutral_ogre_magi" and Entity.IsAlive(npc) and not Entity.IsDormant(npc) and Entity.GetHealth(npc) and (Entity.GetOwner(myHero) == Entity.GetOwner(npc) or Entity.OwnedBy(npc, myHero)) and NPC.HasAbility(npc, "ogre_magi_frost_armor") and Ability.IsCastable(NPC.GetAbility(npc, "ogre_magi_frost_armor"), NPC.GetMana(npc)) and Ability.IsReady(NPC.GetAbility(npc, "ogre_magi_frost_armor")) then
      for _, hero in ipairs(NPC.GetHeroesInRadius(npc, Ability.GetCastRange(NPC.GetAbility(npc, "ogre_magi_frost_armor")), Enum.TeamType.TEAM_FRIEND)) do
        if Entity.IsAlive(hero) and not Entity.IsDormant(hero) and not NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) and not NPC.IsStructure(hero) and Entity.GetHealth(hero) <= Entity.GetMaxHealth(hero) and not NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_ATTACK_IMMUNE) and not NPC.HasModifier(hero, "modifier_ogre_magi_frost_armor") and not Ability.IsInAbilityPhase(NPC.GetAbility(npc, "ogre_magi_frost_armor")) then
          if not lowestHealth or not AutoEnchantress.HeroToBuffWithOgre then
            local lowestHealth = Entity.GetHealth(hero)
            AutoEnchantress.HeroToBuffWithOgre = hero
          end
          if lowestHealth and AutoEnchantress.HeroToBuffWithOgre and Entity.GetHealth(hero) < lowestHealth then
            lowestHealth = Entity.GetHealth(hero)
            AutoEnchantress.HeroToBuffWithOgre = hero
          end
        end
      end
      if AutoEnchantress.HeroToBuffWithOgre and not Ability.IsInAbilityPhase(NPC.GetAbility(npc, "ogre_magi_frost_armor")) and not NPC.HasModifier(AutoEnchantress.HeroToBuffWithOgre, "modifier_ogre_magi_frost_armor") then
        Ability.CastTarget(NPC.GetAbility(npc, "ogre_magi_frost_armor"), AutoEnchantress.HeroToBuffWithOgre)
        AutoEnchantress.UnitAbilityUseTime = GameRules.GetGameTime()
        AutoEnchantress.HeroToBuffWithOgre = nil
        return
      end
    end
    if NPC.GetUnitName(npc) == "npc_dota_neutral_ogre_magi" and Entity.IsAlive(npc) and not Entity.IsDormant(npc) and Entity.GetHealth(npc) and (Entity.GetOwner(myHero) == Entity.GetOwner(npc) or Entity.OwnedBy(npc, myHero)) and NPC.HasAbility(npc, "ogre_magi_frost_armor") and Ability.IsCastable(NPC.GetAbility(npc, "ogre_magi_frost_armor"), NPC.GetMana(npc)) and Ability.IsReady(NPC.GetAbility(npc, "ogre_magi_frost_armor")) then
      for _, neutral in ipairs(NPC.GetUnitsInRadius(npc, Ability.GetCastRange(NPC.GetAbility(npc, "ogre_magi_frost_armor")), Enum.TeamType.TEAM_FRIEND)) do 
        if Entity.IsAlive(neutral) and not Entity.IsDormant(neutral) and not Entity.IsHero(neutral) and not NPC.HasState(neutral, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) and not NPC.IsStructure(neutral) and Entity.GetHealth(neutral) <= Entity.GetMaxHealth(neutral) and not NPC.HasState(neutral, Enum.ModifierState.MODIFIER_STATE_ATTACK_IMMUNE) and not NPC.HasModifier(neutral, "modifier_ogre_magi_frost_armor") and NPC.GetMana(npc) >= NPC.GetMaxMana(npc) * .5 and not Ability.IsInAbilityPhase(NPC.GetAbility(npc, "ogre_magi_frost_armor")) and NPC.GetUnitName(neutral) ~= "npc_dota_dark_troll_warlord_skeleton_warrior" and NPC.GetUnitName(neutral) ~= "npc_dota_creep_goodguys_melee" and NPC.GetUnitName(neutral) ~= "npc_dota_creep_goodguys_melee_upgraded" and NPC.GetUnitName(neutral) ~= "npc_dota_creep_goodguys_melee_upgraded_mega" and NPC.GetUnitName(neutral) ~= "npc_dota_goodguys_siege" and NPC.GetUnitName(neutral) ~= "npc_dota_creep_goodguys_ranged" and NPC.GetUnitName(neutral) ~= "npc_dota_creep_goodguys_ranged_upgraded" and NPC.GetUnitName(neutral) ~= "npc_dota_creep_goodguys_ranged_upgraded_mega" then
          if not lowestHealthNeutral or not AutoEnchantress.NeutralToBuffWithOgre then
            local lowestHealthNeutral = Entity.GetHealth(neutral)
            AutoEnchantress.NeutralToBuffWithOgre = neutral
          end
          if lowestHealthNeutral and AutoEnchantress.NeutralToBuffWithOgre and Entity.GetHealth(neutral) < lowestHealthNeutral then
            lowestHealthNeutral = Entity.GetHealth(neutral)
            AutoEnchantress.NeutralToBuffWithOgre = neutral
          end
        end
      end
      if AutoEnchantress.NeutralToBuffWithOgre and not AutoEnchantress.HeroToBuffWithOgre and not Ability.IsInAbilityPhase(NPC.GetAbility(npc, "ogre_magi_frost_armor")) and not NPC.HasModifier(AutoEnchantress.NeutralToBuffWithOgre, "modifier_ogre_magi_frost_armor") then
        Ability.CastTarget(NPC.GetAbility(npc, "ogre_magi_frost_armor"), AutoEnchantress.NeutralToBuffWithOgre)
        AutoEnchantress.UnitAbilityUseTime = GameRules.GetGameTime()
        AutoEnchantress.NeutralToBuffWithOgre = nil
        return
      end
      if not AutoEnchantress.HeroToBuffWithOgre and not Ability.IsInAbilityPhase(NPC.GetAbility(npc, "ogre_magi_frost_armor")) and not NPC.HasModifier(npc, "modifier_ogre_magi_frost_armor") then
        Ability.CastTarget(NPC.GetAbility(npc, "ogre_magi_frost_armor"), npc)
        AutoEnchantress.UnitAbilityUseTime = GameRules.GetGameTime()
        AutoEnchantress.NeutralToBuffWithOgre = nil
        return
      end
    end
  end
end

function AutoEnchantress.AutoSave(myHero, myMana, attendants)
  if GameRules.GetGameTime() - AutoEnchantress.HeroAbilityUseTime < AutoEnchantress.Delay then return end
  if Entity.GetHealth(myHero) <= Entity.GetMaxHealth(myHero) * 0.50 and Ability.IsReady(attendants) and Ability.IsCastable(attendants, myMana) and not NPC.IsIllusion(myHero) then
    Ability.CastNoTarget(attendants)
    AutoEnchantress.HeroAbilityUseTime = GameRules.GetGameTime()
    return
  end
  for _, npc in pairs(NPC.GetHeroesInRadius(myHero, 500, Enum.TeamType.TEAM_FRIEND)) do
    if Entity.IsHero(npc) and not NPC.IsIllusion(npc) and Entity.GetHealth(npc) <= Entity.GetMaxHealth(npc) * 0.25 and Ability.IsReady(attendants) and Ability.IsCastable(attendants, myMana) then
      Ability.CastNoTarget(attendants)
      AutoEnchantress.HeroAbilityUseTime = GameRules.GetGameTime()
      return
    end
  end
end

function AutoEnchantress.AutoUseItems(myHero, myMana)
  if not Menu.IsEnabled(AutoEnchantress.AutoDefensiveItems) then return end
  local stick = NPC.GetItem(myHero, "item_magic_stick", true)
  local wand = NPC.GetItem(myHero, "item_magic_wand", true)
  local mekansm = NPC.GetItem(myHero, "item_mekansm", true)
  local greaves = NPC.GetItem(myHero, "item_guardian_greaves", true)
  local arcane = NPC.GetItem(myHero, "item_arcane_boots", true)
  local faerie = NPC.GetItem(myHero, "item_faerie_fire", true)

  if faerie and Entity.GetHealth(myHero) <= Entity.GetMaxHealth(myHero) * .25 and Entity.IsAlive(myHero) and not NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) and not NPC.HasModifier(myHero, "modifier_ice_blast") and not NPC.IsChannellingAbility(myHero) then
    if Ability.IsReady(faerie) then
      Ability.CastNoTarget(faerie)
      return
    end
  end

  if (stick or wand) and Entity.GetHealth(myHero) <= Entity.GetMaxHealth(myHero) * .25 and Entity.IsAlive(myHero) and not NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) and not NPC.HasModifier(myHero, "modifier_ice_blast") and not NPC.IsChannellingAbility(myHero) then
    if stick and Item.GetCurrentCharges(stick) >= 1 and Ability.IsReady(stick) then
      Ability.CastNoTarget(stick)
      return
    end
    if wand and Item.GetCurrentCharges(wand) >= 1 and Ability.IsReady(wand) then
      Ability.CastNoTarget(wand)
      return
    end
  end
  if mekansm then
    if Entity.IsAlive(myHero) and not NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) and not NPC.HasModifier(myHero, "modifier_ice_blast") and not NPC.IsChannellingAbility(myHero) then	
      if Entity.GetHealth(myHero) <= Entity.GetMaxHealth(myHero) * .25 and Ability.IsCastable(mekansm, myMana) and Ability.IsReady(mekansm) then 
        Ability.CastNoTarget(mekansm) 
        return
      end
    end
    for _, teamMates in ipairs(NPC.GetHeroesInRadius(myHero, 900, Enum.TeamType.TEAM_FRIEND)) do
      if teamMates then
        if Entity.IsAlive(myHero) and Entity.IsAlive(teamMates) and not NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) and not NPC.HasModifier(teamMates, "modifier_ice_blast") and not NPC.IsChannellingAbility(myHero) then	
          if Entity.GetHealth(teamMates) <= Entity.GetMaxHealth(teamMates) * .25 and Ability.IsCastable(mekansm, myMana) and Ability.IsReady(mekansm) then
            Ability.CastNoTarget(mekansm) 
            return 
          end
        end
      end
    end
  end
  if greaves then
    if Entity.IsAlive(myHero) and not NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) and not NPC.HasModifier(myHero, "modifier_ice_blast") and not NPC.IsChannellingAbility(myHero) then	
      if greaves and Entity.GetHealth(myHero) <= Entity.GetMaxHealth(myHero) * .25 and Ability.IsReady(greaves) then 
        Ability.CastNoTarget(greaves) 
        return
      end
    end
    for _, teamMates in ipairs(NPC.GetHeroesInRadius(myHero, 900, Enum.TeamType.TEAM_FRIEND)) do
      if teamMates then
        if Entity.IsAlive(myHero) and Entity.IsAlive(teamMates) and not NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) and not NPC.HasModifier(teamMates, "modifier_ice_blast") and not NPC.IsChannellingAbility(myHero) then	
          if greaves and Entity.GetHealth(teamMates) <= Entity.GetMaxHealth(teamMates) * .25 and Ability.IsReady(greaves) then
            Ability.CastNoTarget(greaves) 
            return 
          end
        end
      end
    end
  end
  if arcane then
    local myManaMissing = NPC.GetMaxMana(myHero) - NPC.GetMana(myHero)
    if Entity.IsAlive(myHero) and not NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) and not NPC.IsChannellingAbility(myHero) then
      if arcane and myManaMissing >= 250 and Ability.IsReady(arcane) then 
        Ability.CastNoTarget(arcane)
        return 
      end
    end
    for _, teamMates in ipairs(NPC.GetHeroesInRadius(myHero, 900, Enum.TeamType.TEAM_FRIEND)) do
      if teamMates then
        if Entity.IsAlive(myHero) and Entity.IsAlive(teamMates) and not NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) and not NPC.IsChannellingAbility(myHero) then
          if arcane and NPC.GetMana(teamMates) <= NPC.GetMaxMana(teamMates) * .4 and Ability.IsReady(arcane) then 
            Ability.CastNoTarget(arcane)
            return 
          end 
        end
      end
    end
  end
end

function AutoEnchantress.round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

AutoEnchantress.AncientCreepNameList = {
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

-- return best position to cast certain spells
-- eg. axe's call, void's chrono, enigma's black hole
-- input  : unitsAround, radius
-- return : positon (a vector)
function AutoEnchantress.BestPosition(unitsAround, radius)
  if not unitsAround or #unitsAround <= 0 then return nil end
  local enemyNum = #unitsAround

  if enemyNum == 1 then return Entity.GetAbsOrigin(unitsAround[1]) end

  -- find all mid points of every two enemy heroes,
  -- then find out the best position among these.
  -- O(n^3) complexity
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

-- return predicted position
function AutoEnchantress.GetPredictedPosition(npc, delay)
  local pos = Entity.GetAbsOrigin(npc)
  if AutoEnchantress.CantMove(npc) then return pos end
  if not NPC.IsRunning(npc) or not delay then return pos end
  local dir = Entity.GetRotation(npc):GetForward():Normalized()
  local speed = AutoEnchantress.GetMoveSpeed(npc)
  return pos + dir:Scaled(speed * delay)
end

function AutoEnchantress.GetMoveSpeed(npc)
  local base_speed = NPC.GetBaseSpeed(npc)
  local bonus_speed = NPC.GetMoveSpeed(npc) - NPC.GetBaseSpeed(npc)
  -- when affected by ice wall, assume move speed as 100 for convenience
  if NPC.HasModifier(npc, "modifier_invoker_ice_wall_slow_debuff") then return 100 end
  -- when get hexed,  move speed = 140/100 + bonus_speed
  if AutoEnchantress.GetHexTimeLeft(npc) > 0 then return 140 + bonus_speed end
  return base_speed + bonus_speed
end

-- return true if is protected by lotus orb or AM's aghs
function AutoEnchantress.IsLotusProtected(npc)
  if NPC.HasModifier(npc, "modifier_item_lotus_orb_active") then return true end
  local shield = NPC.GetAbility(npc, "antimage_spell_shield")
  if shield and Ability.IsReady(shield) and NPC.HasItem(npc, "item_ultimate_scepter", true) then
    return true
  end
  return false
end

-- return true if this npc is disabled, return false otherwise
function AutoEnchantress.IsDisabled(npc)
  if not Entity.IsAlive(npc) then return true end
  if NPC.IsStunned(npc) then return true end
  if NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_HEXED) then return true end
  return false
end

-- return true if can cast spell on this npc, return false otherwise
function AutoEnchantress.CanCastSpellOn(npc)
  if Entity.IsDormant(npc) or not Entity.IsAlive(npc) then return false end
  if NPC.IsStructure(npc) then return false end --or not NPC.IsKillable(npc)
  if NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then return false end
  if NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then return false end
  if NPC.HasModifier(npc, "modifier_abaddon_borrowed_time") then return false end
  return true
end

-- check if it is safe to cast spell or item on enemy
-- in case enemy has blademail or lotus.
-- Caster will take double damage if target has both lotus and blademail
function AutoEnchantress.IsSafeToCast(myHero, enemy, magic_damage)
  if not myHero or not enemy or not magic_damage then return true end
  if magic_damage <= 0 then return true end
  local counter = 0
  if NPC.HasModifier(enemy, "modifier_item_lotus_orb_active") then counter = counter + 1 end
  if NPC.HasModifier(enemy, "modifier_item_blade_mail_reflect") then counter = counter + 1 end
  local reflect_damage = counter * magic_damage * NPC.GetMagicalArmorDamageMultiplier(myHero)
  return Entity.GetHealth(myHero) > reflect_damage
end

-- situations that ally need to be saved
function AutoEnchantress.NeedToBeSaved(npc)
  if not npc or NPC.IsIllusion(npc) or not Entity.IsAlive(npc) then return false end
  if NPC.IsStunned(npc) or NPC.IsSilenced(npc) then return true end
  if NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_ROOTED) then return true end
  --if NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_DISARMED) then return true end
  if NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_HEXED) then return true end
  --if NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_PASSIVES_DISABLED) then return true end
  --if NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_BLIND) then return true end
  if Entity.GetHealth(npc) <= 0.2 * Entity.GetMaxHealth(npc) then return true end
  return false
end

-- pop all defensive items
function AutoEnchantress.PopDefensiveItems(myHero)
  if not myHero then return end

  -- blade mail
  if NPC.HasItem(myHero, "item_blade_mail", true) then
    local item = NPC.GetItem(myHero, "item_blade_mail", true)
    if Ability.IsCastable(item, NPC.GetMana(myHero)) then
      Ability.CastNoTarget(item)
    end
  end

  -- buckler
  if NPC.HasItem(myHero, "item_buckler", true) then
    local item = NPC.GetItem(myHero, "item_buckler", true)
    if Ability.IsCastable(item, NPC.GetMana(myHero)) then
      Ability.CastNoTarget(item)
    end
  end

  -- hood of defiance
  if NPC.HasItem(myHero, "item_hood_of_defiance", true) then
    local item = NPC.GetItem(myHero, "item_hood_of_defiance", true)
    if Ability.IsCastable(item, NPC.GetMana(myHero)) then
      Ability.CastNoTarget(item)
    end
  end

  -- pipe of insight
  if NPC.HasItem(myHero, "item_pipe", true) then
    local item = NPC.GetItem(myHero, "item_pipe", true)
    if Ability.IsCastable(item, NPC.GetMana(myHero)) then
      Ability.CastNoTarget(item)
    end
  end

  -- crimson guard
  if NPC.HasItem(myHero, "item_crimson_guard", true) then
    local item = NPC.GetItem(myHero, "item_crimson_guard", true)
    if Ability.IsCastable(item, NPC.GetMana(myHero)) then
      Ability.CastNoTarget(item)
    end
  end

  -- shiva's guard
  if NPC.HasItem(myHero, "item_shivas_guard", true) then
    local item = NPC.GetItem(myHero, "item_shivas_guard", true)
    if Ability.IsCastable(item, NPC.GetMana(myHero)) then
      Ability.CastNoTarget(item)
    end
  end

  -- lotus orb
  if NPC.HasItem(myHero, "item_lotus_orb", true) then
    local item = NPC.GetItem(myHero, "item_lotus_orb", true)
    if Ability.IsCastable(item, NPC.GetMana(myHero)) then
      Ability.CastTarget(item, myHero)
    end
  end

  -- mjollnir
  if NPC.HasItem(myHero, "item_mjollnir", true) then
    local item = NPC.GetItem(myHero, "item_mjollnir", true)
    if Ability.IsCastable(item, NPC.GetMana(myHero)) then
      Ability.CastTarget(item, myHero)
    end
  end
end

function AutoEnchantress.IsAncientCreep(npc)
  if not npc then return false end

  for i, name in ipairs(AutoEnchantress.AncientCreepNameList) do
    if name and NPC.GetUnitName(npc) == name then return true end
  end

  return false
end

function AutoEnchantress.CantMove(npc)
  if not npc then return false end

  if NPC.IsRooted(npc) or AutoEnchantress.GetStunTimeLeft(npc) >= 1 then return true end
  if NPC.HasModifier(npc, "modifier_axe_berserkers_call") then return true end
  if NPC.HasModifier(npc, "modifier_legion_commander_duel") then return true end

  return false
end

-- only able to get stun modifier. no specific modifier for root or hex.
function AutoEnchantress.GetStunTimeLeft(npc)
  local mod = NPC.GetModifier(npc, "modifier_stunned")
  if not mod then return 0 end
  return math.max(Modifier.GetDieTime(mod) - GameRules.GetGameTime(), 0)
end

-- hex only has three types: sheepstick, lion's hex, shadow shaman's hex
function AutoEnchantress.GetHexTimeLeft(npc)
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

-- return false for conditions that are not suitable to cast spell (like TPing, being invisible)
-- return true otherwise
function AutoEnchantress.IsSuitableToCastSpell(myHero)
  if NPC.IsSilenced(myHero) or NPC.IsStunned(myHero) or not Entity.IsAlive(myHero) then return false end
  --if NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) then return false end
  if NPC.HasModifier(myHero, "modifier_teleporting") then return false end
  if NPC.IsChannellingAbility(myHero) then return false end
  return true
end

function AutoEnchantress.IsSuitableToUseItem(myHero)
  if NPC.IsStunned(myHero) or not Entity.IsAlive(myHero) then return false end
  if NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) then return false end
  if NPC.HasModifier(myHero, "modifier_teleporting") then return false end
  if NPC.IsChannellingAbility(myHero) then return false end
  return true
end

-- return true if: (1) channeling ability; (2) TPing
function AutoEnchantress.IsChannellingAbility(npc, target)
  if NPC.HasModifier(npc, "modifier_teleporting") then return true end
  if NPC.IsChannellingAbility(npc) then return true end

  return false
end

function AutoEnchantress.IsAffectedByDoT(npc)
  if not npc then return false end

  if NPC.HasModifier(npc, "modifier_item_radiance_debuff") then return true end
  if NPC.HasModifier(npc, "modifier_item_urn_damage") then return true end
  if NPC.HasModifier(npc, "modifier_alchemist_acid_spray") then return true end
  if NPC.HasModifier(npc, "modifier_cold_feet") then return true end
  if NPC.HasModifier(npc, "modifier_ice_blast") then return true end
  if NPC.HasModifier(npc, "modifier_axe_battle_hunger") then return true end
  if NPC.HasModifier(npc, "modifier_bane_fiends_grip") then return true end
  if NPC.HasModifier(npc, "modifier_batrider_firefly") then return true end
  if NPC.HasModifier(npc, "modifier_rattletrap_battery_assault") then return true end
  if NPC.HasModifier(npc, "modifier_crystal_maiden_frostbite") then return true end
  if NPC.HasModifier(npc, "modifier_crystal_maiden_freezing_field") then return true end
  if NPC.HasModifier(npc, "modifier_dazzle_poison_touch") then return true end
  if NPC.HasModifier(npc, "modifier_disruptor_static_storm") then return true end
  if NPC.HasModifier(npc, "modifier_disruptor_thunder_strike") then return true end
  if NPC.HasModifier(npc, "modifier_doom_bringer_doom") then return true end
  if NPC.HasModifier(npc, "modifier_doom_bringer_scorched_earth_effect") then return true end
  if NPC.HasModifier(npc, "modifier_dragon_knight_corrosive_breath_dot") then return true end
  if NPC.HasModifier(npc, "modifier_earth_spirit_magnetize") then return true end
  if NPC.HasModifier(npc, "modifier_ember_spirit_flame_guard") then return true end
  if NPC.HasModifier(npc, "modifier_enigma_malefice") then return true end
  if NPC.HasModifier(npc, "modifier_brewmaster_fire_permanent_immolation") then return true end
  if NPC.HasModifier(npc, "modifier_gyrocopter_rocket_barrage") then return true end
  if NPC.HasModifier(npc, "modifier_huskar_burning_spear_debuff") then return true end
  if NPC.HasModifier(npc, "modifier_invoker_ice_wall_slow_debuff") then return true end
  if NPC.HasModifier(npc, "modifier_invoker_chaos_meteor_burn") then return true end
  if NPC.HasModifier(npc, "modifier_jakiro_dual_breath_burn") then return true end
  if NPC.HasModifier(npc, "modifier_jakiro_macropyre") then return true end
  if NPC.HasModifier(npc, "modifier_juggernaut_blade_fury") then return true end
  if NPC.HasModifier(npc, "modifier_leshrac_diabolic_edict") then return true end
  if NPC.HasModifier(npc, "modifier_leshrac_pulse_nova") then return true end
  if NPC.HasModifier(npc, "modifier_ogre_magi_ignite") then return true end
  if NPC.HasModifier(npc, "modifier_phoenix_fire_spirit_burn") then return true end
  if NPC.HasModifier(npc, "modifier_phoenix_icarus_dive_burn") then return true end
  if NPC.HasModifier(npc, "modifier_phoenix_sun_debuff") then return true end
  if NPC.HasModifier(npc, "modifier_pudge_rot") then return true end
  if NPC.HasModifier(npc, "modifier_pugna_life_drain") then return true end
  if NPC.HasModifier(npc, "modifier_queenofpain_shadow_strike") then return true end
  if NPC.HasModifier(npc, "modifier_razor_eye_of_the_storm") then return true end
  if NPC.HasModifier(npc, "modifier_sandking_sand_storm") then return true end
  if NPC.HasModifier(npc, "modifier_silencer_curse_of_the_silent") then return true end
  if NPC.HasModifier(npc, "modifier_sniper_shrapnel_slow") then return true end
  if NPC.HasModifier(npc, "modifier_shredder_chakram_debuff") then return true end
  if NPC.HasModifier(npc, "modifier_treant_leech_seed") then return true end
  if NPC.HasModifier(npc, "modifier_abyssal_underlord_firestorm_burn") then return true end
  if NPC.HasModifier(npc, "modifier_venomancer_venomous_gale") then return true end
  if NPC.HasModifier(npc, "modifier_venomancer_poison_nova") then return true end
  if NPC.HasModifier(npc, "modifier_viper_viper_strike") then return true end
  if NPC.HasModifier(npc, "modifier_warlock_shadow_word") then return true end
  if NPC.HasModifier(npc, "modifier_warlock_golem_permanent_immolation_debuff") then return true end
  if NPC.HasModifier(npc, "modifier_maledict") then return true end

  return false
end

-- auto use midas on high XP creeps once available
function AutoEnchantress.item_hand_of_midas(myHero)
  local item = NPC.GetItem(myHero, "item_hand_of_midas", true)
  if not item or not Ability.IsCastable(item, 0) then return end

  local range = 600
  local XP_threshold = 88
  local creeps = NPC.GetUnitsInRadius(myHero, range, Enum.TeamType.TEAM_ENEMY)
  for i, npc in ipairs(creeps) do
    local XP = NPC.GetBountyXP(npc)
    if NPC.IsCreep(npc) and not AutoEnchantress.IsAncientCreep(npc) and XP >= XP_threshold then
      Ability.CastTarget(item, npc)
      return
    end
  end
end

-- Auto use quelling blade, iron talen, or battle fury to deward
function AutoEnchantress.deward(myHero)
  local item1 = NPC.GetItem(myHero, "item_quelling_blade", true)
  local item2 = NPC.GetItem(myHero, "item_iron_talon", true)
  local item3 = NPC.GetItem(myHero, "item_bfury", true)

  local item = nil
  if item1 and Ability.IsCastable(item1, 0) then item = item1 end
  if item2 and Ability.IsCastable(item2, 0) then item = item2 end
  if item3 and Ability.IsCastable(item3, 0) then item = item3 end
  if not item then return end

  local range = 450
  local wards = NPC.GetUnitsInRadius(myHero, range, Enum.TeamType.TEAM_ENEMY)
  for i, npc in ipairs(wards) do
    if NPC.GetUnitName(npc) == "npc_dota_observer_wards" or NPC.GetUnitName(npc) == "npc_dota_sentry_wards" then
      Ability.CastTarget(item, npc)
      return
    end
  end
end

-- Auto use sheepstick on enemy hero once available
-- Doesn't use on enemy who is lotus orb protected or AM with aghs.
function AutoEnchantress.item_sheepstick(myHero)
  if not Menu.IsEnabled(AutoEnchantress.AutoOffensiveItems) then return end
  local item = NPC.GetItem(myHero, "item_sheepstick", true)
  if not item or not Ability.IsCastable(item, NPC.GetMana(myHero)) then return end

  local range = 800
  local enemyAround = NPC.GetHeroesInRadius(myHero, range, Enum.TeamType.TEAM_ENEMY)

  local minDistance = 99999
  local target = nil
  for i, enemy in ipairs(enemyAround) do
    if not NPC.IsIllusion(enemy) and not AutoEnchantress.IsDisabled(enemy)
    and AutoEnchantress.CanCastSpellOn(enemy) and not AutoEnchantress.IsLotusProtected(enemy) then
      local dis = (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Length()
      if dis < minDistance then
        minDistance = dis
        target = enemy
      end
    end
  end

  -- cast sheepstick on nearest enemy in range
  if target then Ability.CastTarget(item, target) end
end

-- Auto use orchid or bloodthorn on enemy hero once available
-- Doesn't use on enemy who is lotus orb protected or AM with aghs.
function AutoEnchantress.item_orchid(myHero)
  if not Menu.IsEnabled(AutoEnchantress.AutoOffensiveItems) then return end
  local item1 = NPC.GetItem(myHero, "item_orchid", true)
  local item2 = NPC.GetItem(myHero, "item_bloodthorn", true)

  local item = nil
  if item1 and Ability.IsCastable(item1, NPC.GetMana(myHero)) then item = item1 end
  if item2 and Ability.IsCastable(item2, NPC.GetMana(myHero)) then item = item2 end
  if not item then return end

  local range = 900
  local enemyAround = NPC.GetHeroesInRadius(myHero, range, Enum.TeamType.TEAM_ENEMY)

  local minDistance = 99999
  local target = nil
  for i, enemy in ipairs(enemyAround) do
    if not NPC.IsIllusion(enemy) and not AutoEnchantress.IsDisabled(enemy)
    and AutoEnchantress.CanCastSpellOn(enemy) and not NPC.IsSilenced(enemy) and not AutoEnchantress.IsLotusProtected(enemy) then
      local dis = (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Length()
      if dis < minDistance then
        minDistance = dis
        target = enemy
      end
    end
  end

  -- cast orchid/bloodthorn on nearest enemy in range
  if target then Ability.CastTarget(item, target) end
end

-- Auto use rod of atos on enemy hero once available
-- Doesn't use on enemy who is lotus orb protected or AM with aghs.
function AutoEnchantress.item_rod_of_atos(myHero)
  if not Menu.IsEnabled(AutoEnchantress.AutoOffensiveItems) then return end
  local item = NPC.GetItem(myHero, "item_rod_of_atos", true)
  if not item or not Ability.IsCastable(item, NPC.GetMana(myHero)) then return end

  local range = 1150
  local enemyAround = NPC.GetHeroesInRadius(myHero, range, Enum.TeamType.TEAM_ENEMY)

  local minDistance = 99999
  local target = nil
  for i, enemy in ipairs(enemyAround) do
    if not NPC.IsIllusion(enemy) and not AutoEnchantress.IsDisabled(enemy)
    and AutoEnchantress.CanCastSpellOn(enemy) and not AutoEnchantress.IsLotusProtected(enemy)
    and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_ROOTED) then

      local dis = (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Length()
      if dis < minDistance then
        minDistance = dis
        target = enemy
      end
    end
  end

  -- cast rod of atos on nearest enemy in range
  if target then Ability.CastTarget(item, target) end
end

-- Auto use abyssal blade on enemy hero once available
-- Doesn't use on enemy who is lotus orb protected or AM with aghs.
function AutoEnchantress.item_abyssal_blade(myHero)
  if not Menu.IsEnabled(AutoEnchantress.AutoOffensiveItems) then return end
  local item = NPC.GetItem(myHero, "item_abyssal_blade", true)
  if not item or not Ability.IsCastable(item, NPC.GetMana(myHero)) then return end

  local range = 140
  local enemyAround = NPC.GetHeroesInRadius(myHero, range, Enum.TeamType.TEAM_ENEMY)

  local minDistance = 99999
  local target = nil
  for i, enemy in ipairs(enemyAround) do
    if not NPC.IsIllusion(enemy) and not NPC.IsStunned(enemy) and not AutoEnchantress.IsLotusProtected(enemy) then
      local dis = (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Length()
      if dis < minDistance then
        minDistance = dis
        target = enemy
      end
    end
  end

  -- cast rod of atos on nearest enemy in range
  if target then Ability.CastTarget(item, target) end
end

function AutoEnchantress.item_dagon(myHero)
  if not Menu.IsEnabled(AutoEnchantress.AutoOffensiveItems) then return end
  local level, item
  local item1 = NPC.GetItem(myHero, "item_dagon", true)
  local item2 = NPC.GetItem(myHero, "item_dagon_2", true)
  local item3 = NPC.GetItem(myHero, "item_dagon_3", true)
  local item4 = NPC.GetItem(myHero, "item_dagon_4", true)
  local item5 = NPC.GetItem(myHero, "item_dagon_5", true)

  if item1 and Ability.IsCastable(item1, NPC.GetMana(myHero)) then item = item1; level = 1 end
  if item2 and Ability.IsCastable(item2, NPC.GetMana(myHero)) then item = item2; level = 2 end
  if item3 and Ability.IsCastable(item3, NPC.GetMana(myHero)) then item = item3; level = 3 end
  if item4 and Ability.IsCastable(item4, NPC.GetMana(myHero)) then item = item4; level = 4 end
  if item5 and Ability.IsCastable(item5, NPC.GetMana(myHero)) then item = item5; level = 5 end

  if not item then return end

  local range = 600 + 50 * (level - 1)
  local magic_damage = 400 + 100 * (level - 1)

  local target
  local minHp = 99999
  local enemyAround = NPC.GetHeroesInRadius(myHero, range, Enum.TeamType.TEAM_ENEMY)
  for i, enemy in ipairs(enemyAround) do
    if not NPC.IsIllusion(enemy) and not AutoEnchantress.IsDisabled(enemy)
    and AutoEnchantress.CanCastSpellOn(enemy) and AutoEnchantress.IsSafeToCast(myHero, enemy, magic_damage) then

      local enemyHp = Entity.GetHealth(enemy)
      if enemyHp < minHp then
        target = enemy
        minHp = enemyHp
      end
    end
  end

  -- cast dagon on enemy with lowest HP in range
  if target then Ability.CastTarget(item, target) end
end

function AutoEnchantress.item_veil_of_discord(myHero)
  if not Menu.IsEnabled(AutoEnchantress.AutoOffensiveItems) then return end
  local item = NPC.GetItem(myHero, "item_veil_of_discord", true)
  if not item or not Ability.IsCastable(item, NPC.GetMana(myHero)) then return end

  local range = 1000
  local enemyHeroes = NPC.GetHeroesInRadius(myHero, range, Enum.TeamType.TEAM_ENEMY)
  if not enemyHeroes or #enemyHeroes <= 0 then return end

  local radius = 600
  local pos = AutoEnchantress.BestPosition(enemyHeroes, radius)
  if pos then Ability.CastPosition(item, pos) end
end

-- Auto cast lotus orb to save ally
-- For tinker, auto use lotus orb on self or allies once available
function AutoEnchantress.item_lotus_orb(myHero)
  if not Menu.IsEnabled(AutoEnchantress.AutoDefensiveItems) then return end
  local item = NPC.GetItem(myHero, "item_lotus_orb", true)
  if not item or not Ability.IsCastable(item, NPC.GetMana(myHero)) then return end

  -- cast on self first if needed
  if AutoEnchantress.NeedToBeSaved(myHero) then Ability.CastTarget(item, myHero); return end

  local range = 900
  local allyAround = NPC.GetHeroesInRadius(myHero, range, Enum.TeamType.TEAM_FRIEND)
  if not allyAround or #allyAround <= 0 then return end

  -- save ally who get stunned, silenced, rooted, disarmed, low Hp, etc
  for i, ally in ipairs(allyAround) do
    if AutoEnchantress.NeedToBeSaved(ally) and AutoEnchantress.CanCastSpellOn(ally) then
      Ability.CastTarget(item, ally)
      return
    end
  end

  -- for tinker
  if NPC.GetUnitName(myHero) ~= "npc_dota_hero_tinker" then return end

  if not NPC.HasModifier(myHero, "modifier_item_lotus_orb_active") and AutoEnchantress.CanCastSpellOn(myHero) then
    Ability.CastTarget(item, myHero)
    return
  end

  -- cast lotus orb once available
  for i, ally in ipairs(allyAround) do
    if Entity.IsAlive(ally) and not NPC.IsIllusion(ally) and AutoEnchantress.CanCastSpellOn(ally)
    and not NPC.HasModifier(ally, "modifier_item_lotus_orb_active") then

      Ability.CastTarget(item, ally)
      return
    end
  end
end

-- Auto cast solar crest/medallion of courage to save ally
function AutoEnchantress.item_solar_crest(myHero)
  if not Menu.IsEnabled(AutoEnchantress.AutoOffensiveItems) then return end
  local item
  local item1 = NPC.GetItem(myHero, "item_solar_crest", true)
  local item2 = NPC.GetItem(myHero, "item_medallion_of_courage", true)

  if item1 then item = item1 end
  if item2 then item = item2 end

  if not item or not Ability.IsCastable(item, NPC.GetMana(myHero)) then return end

  local range = 1000
  local allyAround = NPC.GetHeroesInRadius(myHero, range, Enum.TeamType.TEAM_FRIEND)
  if not allyAround or #allyAround <= 0 then return end

  for i, ally in ipairs(allyAround) do
    if AutoEnchantress.NeedToBeSaved(ally) and AutoEnchantress.CanCastSpellOn(ally) then
      Ability.CastTarget(item, ally)
      return
    end
  end
end

-- Auto cast Glimmer Cape to ally or yourself when channeling spell or need to be saved.
function AutoEnchantress.item_glimmer_cape(myHero)
  if not Menu.IsEnabled(AutoEnchantress.AutoDefensiveItems) then return end
  local item = NPC.GetItem(myHero, "item_glimmer_cape", true)
  if not item or not Ability.IsCastable(item, NPC.GetMana(myHero)) then return end

  if AutoEnchantress.CanCastSpellOn(myHero) and (AutoEnchantress.NeedToBeSaved(myHero) or AutoEnchantress.IsChannellingAbility(myHero)) then
    Ability.CastTarget(item, myHero)
  end

  local range = 1050
  local allyAround = NPC.GetHeroesInRadius(myHero, range, Enum.TeamType.TEAM_FRIEND)
  if not allyAround or #allyAround <= 0 then return end

  for i, ally in ipairs(allyAround) do
    if AutoEnchantress.CanCastSpellOn(ally) and (AutoEnchantress.NeedToBeSaved(ally) or AutoEnchantress.IsChannellingAbility(ally)) then
      Ability.CastTarget(item, ally)
      return
    end
  end
end

AutoEnchantress.CreepNameList = {
"npc_dota_neutral_alpha_wolf",
"npc_dota_neutral_big_thunder_lizard",
"npc_dota_neutral_black_dragon",
"npc_dota_neutral_black_drake",
"npc_dota_neutral_blue_dragonspawn_overseer",
"npc_dota_neutral_blue_dragonspawn_sorcerer",
"npc_dota_neutral_centaur_khan",
"npc_dota_neutral_centaur_outrunner",
"npc_dota_neutral_dark_troll",
"npc_dota_neutral_dark_troll_warlord",
"npc_dota_neutral_elder_jungle_stalker",
"npc_dota_neutral_enraged_wildkin",
"npc_dota_neutral_fel_beast",
"npc_dota_neutral_forest_troll_berserker",
"npc_dota_neutral_forest_troll_high_priest",
"npc_dota_neutral_ghost",
"npc_dota_neutral_giant_wolf",
"npc_dota_neutral_gnoll_assassin",
"npc_dota_neutral_granite_golem",
"npc_dota_neutral_harpy_scout",
"npc_dota_neutral_harpy_storm",
"npc_dota_neutral_jungle_stalker",
"npc_dota_neutral_kobold",
"npc_dota_neutral_kobold_taskmaster",
"npc_dota_neutral_kobold_tunneler",
"npc_dota_neutral_mud_golem",
"npc_dota_neutral_ogre_magi",
"npc_dota_neutral_ogre_mauler",
"npc_dota_neutral_polar_furbolg_champion",
"npc_dota_neutral_polar_furbolg_ursa_warrior",
"npc_dota_neutral_rock_golem",
"npc_dota_neutral_satyr_hellcaller",
"npc_dota_neutral_satyr_soulstealer",
"npc_dota_neutral_satyr_trickster",
"npc_dota_neutral_small_thunder_lizard",
"npc_dota_neutral_wildkin",
"npc_dota_neutral_prowler_shaman",
"npc_dota_neutral_prowler_acolyte"
}

AutoEnchantress.UsefulNonAncientCreepNameList = {
"npc_dota_neutral_satyr_hellcaller",
"npc_dota_neutral_dark_troll_warlord",
"npc_dota_neutral_centaur_khan",
"npc_dota_neutral_enraged_wildkin",
"npc_dota_neutral_alpha_wolf",
"npc_dota_neutral_ogre_magi",
"npc_dota_neutral_polar_furbolg_ursa_warrior",
"npc_dota_neutral_harpy_storm",
"npc_dota_neutral_mud_golem",
"npc_dota_neutral_ghost",
"npc_dota_neutral_forest_troll_high_priest",
"npc_dota_neutral_kobold_taskmaster"
}

AutoEnchantress.UsefulCreepNameList = {
"npc_dota_neutral_granite_golem",
"npc_dota_neutral_black_dragon",
"npc_dota_neutral_big_thunder_lizard",
"npc_dota_neutral_satyr_hellcaller",
"npc_dota_neutral_dark_troll_warlord",
"npc_dota_neutral_centaur_khan",
"npc_dota_neutral_enraged_wildkin",
"npc_dota_neutral_alpha_wolf",
"npc_dota_neutral_ogre_magi",
"npc_dota_neutral_polar_furbolg_ursa_warrior",
"npc_dota_neutral_prowler_acolyte",
"npc_dota_neutral_prowler_shaman",
"npc_dota_neutral_harpy_storm",
"npc_dota_neutral_mud_golem",
"npc_dota_neutral_ghost",
"npc_dota_neutral_forest_troll_high_priest",
"npc_dota_neutral_kobold_taskmaster"
}

AutoEnchantress.InteractiveAbilities = {
"forest_troll_high_priest_heal",
"harpy_storm_chain_lightning",
"centaur_khan_war_stomp",
"satyr_trickster_purge",
"satyr_soulstealer_mana_burn",
"ogre_magi_frost_armor",
"mud_golem_hurl_boulder",
"satyr_hellcaller_shockwave",
"polar_furbolg_ursa_warrior_thunder_clap",
"enraged_wildkin_tornado",
"dark_troll_warlord_ensnare",
"dark_troll_warlord_raise_dead",
"black_dragon_fireball",
"big_thunder_lizard_slam",
"big_thunder_lizard_frenzy",
"spawnlord_master_stomp",
"spawnlord_master_freeze"
}

AutoEnchantress.HeroAbilities = {
"enchantress_untouchable",
"enchantress_enchant",
"enchantress_natures_attendants",
"enchantress_impetus",
"special_bonus_all_stats_6",
"special_bonus_movement_speed_25",
"special_bonus_unique_enchantress_2",
"special_bonus_attack_damage_50",
"special_bonus_magic_resistance_15",
"special_bonus_unique_enchantress_3",
"special_bonus_unique_enchantress_4",
"special_bonus_unique_enchantress_1"
}

AutoEnchantress.Items = {
"item_abyssal_blade",
"item_aegis",
"item_aether_lens",
"item_ancient_janggo",
"item_arcane_boots",
"item_armlet",
"item_assault",
"item_banana",
"item_basher",
"item_belt_of_strength",
"item_bfury",
"item_black_king_bar",
"item_blade_mail",
"item_blade_of_alacrity",
"item_blades_of_attack",
"item_blight_stone",
"item_bloodstone",
"item_bloodthorn",
"item_boots",
"item_boots_of_elves",
"item_bottle",
"item_bracer",
"item_branches",
"item_broadsword",
"item_buckler",
"item_butterfly",
"item_chainmail",
"item_cheese",
"item_circlet",
"item_clarity",
"item_claymore",
"item_cloak",
"item_courier",
"item_crimson_guard",
"item_cyclone",
"item_dagon",
"item_dagon_2",
"item_dagon_3",
"item_dagon_4",
"item_dagon_5",
"item_demon_edge",
"item_desolator",
"item_diffusal_blade",
"item_diffusal_blade_2",
"item_dragon_lance",
"item_dust",
"item_eagle",
"item_echo_sabre",
"item_enchanted_mango",
"item_energy_booster",
"item_ethereal_blade",
"item_faerie_fire",
"item_flask",
"item_flying_courier",
"item_force_staff",
"item_gauntlets",
"item_gem",
"item_ghost",
"item_glimmer_cape",
"item_gloves",
"item_greater_crit",
"item_greevil_whistle",
"item_greevil_whistle_toggle",
"item_guardian_greaves",
"item_halloween_candy_corn",
"item_halloween_rapier",
"item_hand_of_midas",
"item_headdress",
"item_heart",
"item_heavens_halberd",
"item_helm_of_iron_will",
"item_helm_of_the_dominator",
"item_hood_of_defiance",
"item_hurricane_pike",
"item_hyperstone",
"item_infused_raindrop",
"item_invis_sword",
"item_iron_talon",
"item_javelin",
"item_lesser_crit",
"item_lifesteal",
"item_lotus_orb",
"item_maelstrom",
"item_magic_stick",
"item_magic_wand",
"item_manta",
"item_mantle",
"item_mask_of_madness",
"item_medallion_of_courage",
"item_mekansm",
"item_mithril_hammer",
"item_mjollnir",
"item_monkey_king_bar",
"item_moon_shard",
"item_mystery_arrow",
"item_mystery_hook",
"item_mystery_missile",
"item_mystery_toss",
"item_mystery_vacuum",
"item_mystic_staff",
"item_necronomicon",
"item_necronomicon_2",
"item_necronomicon_3",
"item_null_talisman",
"item_oblivion_staff",
"item_octarine_core",
"item_ogre_axe",
"item_orb_of_venom",
"item_orchid",
"item_pers",
"item_phase_boots",
"item_pipe",
"item_platemail",
"item_point_booster",
"item_poor_mans_shield",
"item_power_treads",
"item_present",
"item_quarterstaff",
"item_quelling_blade",
"item_radiance",
"item_rapier",
"item_reaver",
"item_recipe_abyssal_blade",
"item_recipe_aether_lens",
"item_recipe_ancient_janggo",
"item_recipe_arcane_boots",
"item_recipe_armlet",
"item_recipe_assault",
"item_recipe_basher",
"item_recipe_bfury",
"item_recipe_black_king_bar",
"item_recipe_blade_mail",
"item_recipe_bloodstone",
"item_recipe_bloodthorn",
"item_recipe_bracer",
"item_recipe_buckler",
"item_recipe_butterfly",
"item_recipe_crimson_guard",
"item_recipe_cyclone",
"item_recipe_dagon",
"item_recipe_dagon_2",
"item_recipe_dagon_3",
"item_recipe_dagon_4",
"item_recipe_dagon_5",
"item_recipe_desolator",
"item_recipe_diffusal_blade",
"item_recipe_diffusal_blade_2",
"item_recipe_dragon_lance",
"item_recipe_echo_sabre",
"item_recipe_ethereal_blade",
"item_recipe_force_staff",
"item_recipe_glimmer_cape",
"item_recipe_greater_crit",
"item_recipe_guardian_greaves",
"item_recipe_hand_of_midas",
"item_recipe_headdress",
"item_recipe_heart",
"item_recipe_heavens_halberd",
"item_recipe_helm_of_the_dominator",
"item_recipe_hood_of_defiance",
"item_recipe_hurricane_pike",
"item_recipe_invis_sword",
"item_recipe_iron_talon",
"item_recipe_lesser_crit",
"item_recipe_lotus_orb",
"item_recipe_maelstrom",
"item_recipe_magic_wand",
"item_recipe_manta",
"item_recipe_mask_of_madness",
"item_recipe_medallion_of_courage",
"item_recipe_mekansm",
"item_recipe_mjollnir",
"item_recipe_monkey_king_bar",
"item_recipe_moon_shard",
"item_recipe_necronomicon",
"item_recipe_necronomicon_2",
"item_recipe_necronomicon_3",
"item_recipe_null_talisman",
"item_recipe_oblivion_staff",
"item_recipe_octarine_core",
"item_recipe_orchid",
"item_recipe_pers",
"item_recipe_phase_boots",
"item_recipe_pipe",
"item_recipe_poor_mans_shield",
"item_recipe_power_treads",
"item_recipe_radiance",
"item_recipe_rapier",
"item_recipe_refresher",
"item_recipe_ring_of_aquila",
"item_recipe_ring_of_basilius",
"item_recipe_rod_of_atos",
"item_recipe_sange",
"item_recipe_sange_and_yasha",
"item_recipe_satanic",
"item_recipe_sheepstick",
"item_recipe_shivas_guard",
"item_recipe_silver_edge",
"item_recipe_skadi",
"item_recipe_solar_crest",
"item_recipe_soul_booster",
"item_recipe_soul_ring",
"item_recipe_sphere",
"item_recipe_tranquil_boots",
"item_recipe_travel_boots",
"item_recipe_travel_boots_2",
"item_recipe_ultimate_scepter",
"item_recipe_urn_of_shadows",
"item_recipe_vanguard",
"item_recipe_veil_of_discord",
"item_recipe_vladmir",
"item_recipe_ward_dispenser",
"item_recipe_wraith_band",
"item_recipe_yasha",
"item_refresher",
"item_relic",
"item_ring_of_aquila",
"item_ring_of_basilius",
"item_ring_of_health",
"item_ring_of_protection",
"item_ring_of_regen",
"item_river_painter",
"item_river_painter2",
"item_river_painter3",
"item_river_painter4",
"item_river_painter5",
"item_river_painter6",
"item_river_painter7",
"item_robe",
"item_rod_of_atos",
"item_sange",
"item_sange_and_yasha",
"item_satanic",
"item_shadow_amulet",
"item_sheepstick",
"item_shivas_guard",
"item_silver_edge",
"item_skadi",
"item_slippers",
"item_smoke_of_deceit",
"item_sobi_mask",
"item_solar_crest",
"item_soul_booster",
"item_soul_ring",
"item_sphere",
"item_staff_of_wizardry",
"item_stout_shield",
"item_talisman_of_evasion",
"item_tango",
"item_tango_single",
"item_tome_of_knowledge",
"item_tpscroll",
"item_tranquil_boots",
"item_travel_boots",
"item_travel_boots_2",
"item_ultimate_orb",
"item_ultimate_scepter",
"item_urn_of_shadows",
"item_vanguard",
"item_veil_of_discord",
"item_vitality_booster",
"item_vladmir",
"item_void_stone",
"item_ward_dispenser",
"item_ward_observer",
"item_ward_sentry",
"item_wind_lace",
"item_winter_cake",
"item_winter_coco",
"item_winter_cookie",
"item_winter_greevil_chewy",
"item_winter_greevil_garbage",
"item_winter_greevil_treat",
"item_winter_ham",
"item_winter_kringle",
"item_winter_mushroom",
"item_winter_skates",
"item_winter_stocking",
"item_wraith_band",
"item_yasha"
}

AutoEnchantress.InteractiveItems = {
"item_sheepstick",
"item_orchid",
"item_bloodthorn",
"item_rod_of_atos",
"item_veil_of_discord",
"item_heavens_halberd",
"item_abyssal_blade",
"item_diffusal_blade",
"item_diffusal_blade_2",
"item_ethereal_blade",
"item_medallion_of_courage",
"item_shivas_guard",
"item_solar_crest",
"item_satanic",
"item_ancient_janggo",
"item_dagon",
"item_dagon_2",
"item_dagon_3",
"item_dagon_4",
"item_dagon_5",
"item_black_king_bar",
"item_pipe",
"item_blade_mail",
"item_buckler",
"item_hood_of_defiance",
"item_lotus_orb",
"item_manta",
"item_mask_of_madness",
"item_mjollnir",
"item_necronomicon",
"item_necronomicon_2",
"item_necronomicon_3",
"item_urn_of_shadows",
"item_hurricane_pike"
}

AutoEnchantress.InteractiveAutoItems = {
"item_magic_stick",
"item_magic_wand",
"item_mekansm",
"item_guardian_greaves",
"item_arcane_boots"
}

return AutoEnchantress