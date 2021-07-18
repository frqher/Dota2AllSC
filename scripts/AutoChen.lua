-- AutoChen by unknown
--

local AutoChen = {}

AutoChen.ComboKey = Menu.AddKeyOption({"Hero Specific", "Chen"}, "Combo Key", Enum.ButtonCode.KEY_SPACE)
AutoChen.CallUnitsKey = Menu.AddKeyOption({"Hero Specific", "Chen"}, "Call Units Key", Enum.ButtonCode.KEY_T)
AutoChen.CallUnitsGoInvisKey = Menu.AddKeyOption({"Hero Specific", "Chen"}, "Call Units and Go Invisible Key", Enum.ButtonCode.KEY_G)
AutoChen.FarmKey = Menu.AddKeyOption({"Hero Specific", "Chen"}, "Farm Key", Enum.ButtonCode.KEY_F)
AutoChen.PersuadeKey = Menu.AddKeyOption({"Hero Specific", "Chen"}, "Persuade Key", Enum.ButtonCode.KEY_4)
AutoChen.DominateKey = Menu.AddKeyOption({"Hero Specific", "Chen"}, "Dominate Key", Enum.ButtonCode.KEY_5)
AutoChen.Font = Renderer.LoadFont("Tahoma", 24, Enum.FontWeight.EXTRABOLD)

AutoChen.CreepNameList = {
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
AutoChen.UsefulCreepNameList = {
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
AutoChen.InteractiveAbilities = {
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
AutoChen.ChenAbilities = {
"chen_penitence",
"chen_test_of_faith",
"chen_test_of_faith_teleport",
"chen_holy_persuasion",
"chen_hand_of_god",
"special_bonus_movement_speed_30",
"special_bonus_cast_range_125",
"special_bonus_hp_250",
"special_bonus_unique_chen_3",
"special_bonus_gold_income_15",
"special_bonus_unique_chen_4",
"special_bonus_unique_chen_1",
"special_bonus_unique_chen_2"
}
AutoChen.Items = {
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
AutoChen.InteractiveItems = {
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
"item_hurricane_pike",
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
"item_urn_of_shadows"
}   

AutoChen.AttackAnimationPoint = 0.500000
AutoChen.ProjectileSpeed = 1100
AutoChen.ProjectileTime = 0
AutoChen.ItemUseTime = 0
AutoChen.ChenAbilityUseTime = 0
AutoChen.UnitAbilityUseTime = 0
AutoChen.Delay = .05
AutoChen.StunTime = 0
AutoChen.StunDuration = 0
AutoChen.AttackOrderTime = 0
AutoChen.MoveOrderTime = 0
AutoChen.FarmManaThreshold = 0.35
AutoChen.CircleDrawTime = 0
AutoChen.OrbWalkTime = 0
AutoChen.CheckDeadTime = 0 
AutoChen.MoveNPCOrderTime = 0
AutoChen.AttackNPCOrderTime = 0
AutoChen.ReadyToInvisTime = nil
AutoChen.HeroToBuff = nil
AutoChen.NeutralToBuffWithOgre = nil
AutoChen.HeroToBuffWithPriest = nil
AutoChen.HeroToBuffWithOgre = nil
AutoChen.HeroToBuffWithLizard = nil

function AutoChen.OnGameStart()
  AutoChen.AttackAnimationPoint = 0.500000
  AutoChen.ProjectileSpeed = 1100
  AutoChen.ProjectileTime = 0
  AutoChen.ItemUseTime = 0
  AutoChen.ChenAbilityUseTime = 0
  AutoChen.UnitAbilityUseTime = 0
  AutoChen.StunTime = 0
  AutoChen.StunDuration = 0
  AutoChen.AttackOrderTime = 0
  AutoChen.MoveOrderTime = 0
  AutoChen.FarmManaThreshold = 0.35
  AutoChen.CircleDrawTime = 0
  AutoChen.OrbWalkTime = 0
  AutoChen.CheckDeadTime = 0 
  AutoChen.MoveNPCOrderTime = 0
  AutoChen.AttackNPCOrderTime = 0
  AutoChen.ReadyToInvisTime = nil
  AutoChen.HeroToBuff = nil
  AutoChen.NeutralToBuffWithOgre = nil
  AutoChen.HeroToBuffWithPriest = nil
  AutoChen.HeroToBuffWithOgre = nil
  AutoChen.HeroToBuffWithLizard = nil
end
function AutoChen.AutoRaiseDead(myHero)
  if GameRules.GetGameTime() - AutoChen.CheckDeadTime < 1 then return end
  for _, npc in ipairs(NPC.GetUnitsInRadius(myHero, 99999, Enum.TeamType.TEAM_FRIEND)) do
    if npc and NPC.HasAbility(npc, "dark_troll_warlord_raise_dead") and Entity.IsAlive(npc) and not Entity.IsDormant(npc) and Entity.GetHealth(npc) and (Entity.GetOwner(myHero) == Entity.GetOwner(npc) or Entity.OwnedBy(npc, myHero)) and Ability.IsReady(NPC.GetAbility(npc, "dark_troll_warlord_raise_dead")) and Ability.IsCastable(NPC.GetAbility(npc, "dark_troll_warlord_raise_dead"), NPC.GetMana(npc)) and not Ability.IsInAbilityPhase(NPC.GetAbility(npc, "dark_troll_warlord_raise_dead")) then
      Ability.CastNoTarget(NPC.GetAbility(npc, "dark_troll_warlord_raise_dead"), true)
    end
  end
  AutoChen.CheckDeadTime = GameRules.GetGameTime()
end
function AutoChen.OnProjectile(projectile)
  if not projectile or not projectile.source or not projectile.target then return end
  if not projectile.isAttack then return end
  if not Heroes.GetLocal() or NPC.GetUnitName(Heroes.GetLocal()) ~= "npc_dota_hero_chen" then return end
  local myHero = Heroes.GetLocal()
  local mousePos = Input.GetWorldCursorPos()
  local enemy = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
  if projectile.source == myHero then
    AutoChen.target = projectile.target
    AutoChen.targetPos = NPC.GetAbsOrigin(projectile.target)
    AutoChen.ProjectileTime = GameRules.GetGameTime()
    if Menu.IsKeyDown(AutoChen.ComboKey) then
      if Entity.IsAlive(myHero) and not Entity.IsDormant(myHero) and Entity.GetHealth(myHero) > 0 and not NPC.IsPositionInRange(myHero, Entity.GetAbsOrigin(enemy), NPC.GetAttackRange(myHero)-65, 0) or not enemy and GameRules.GetGameTime() - AutoChen.OrbWalkTime >= .01 then
        Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, nil, AutoChen.targetPos, nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero, queue, showEffects)
        AutoChen.OrbWalkTime = GameRules.GetGameTime()
      end
    end
  end
end
function AutoChen.OnUpdate()
  if not GameRules.GetGameState() == 5 then return end
  if not Heroes.GetLocal() or NPC.GetUnitName(Heroes.GetLocal()) ~= "npc_dota_hero_chen" then return end
  local myHero = Heroes.GetLocal()
  local myMana = NPC.GetMana(myHero)
  local myStr = Hero.GetStrengthTotal(myHero)
  local myAgi = Hero.GetAgilityTotal(myHero)
  local myInt = Hero.GetIntellectTotal(myHero)
  local myAttackRange = NPC.GetAttackRange(myHero)
  local mySpellAmp = 1 + (myInt * 0.07142857142) / 100
  local enemy = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
  local neutralEnemy = Input.GetNearestUnitToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
  local mousePos = Input.GetWorldCursorPos()
  local faith = NPC.GetAbility(myHero, "chen_test_of_faith")
  local penitence = NPC.GetAbility(myHero, "chen_penitence")
  local hand = NPC.GetAbility(myHero, "chen_hand_of_god")
  local teleport = NPC.GetAbility(myHero, "chen_test_of_faith_teleport")
  local persuasion = NPC.GetAbility(myHero, "chen_holy_persuasion")
  local attackPoint = 0.5
  local persuasionRange
  local hand_heal_amount
  local faith_max_damage
  local penitence_amp
  if faith then
    faith_max_damage = 100 * Ability.GetLevel(faith) * mySpellAmp
  end
  if penitence then
    penitence_amp = 1 + (12 + (Ability.GetLevel(penitence) * 6)) / 100
  end
  if hand then
    if NPC.GetAbility(myHero, "special_bonus_unique_chen_2") then
      hand_heal_amount = 325 + 100 * Ability.GetLevel(hand)  
    else
      hand_heal_amount = 125 + 100 * Ability.GetLevel(hand)
    end
  end
  if persuasion then
    persuasionRange = Ability.GetCastRange(persuasion)
  end
  if teleport and Menu.IsKeyDownOnce(AutoChen.CallUnitsKey) then
    Ability.CastTarget(teleport, myHero)
  end
  if persuasion and Menu.IsKeyDownOnce(AutoChen.PersuadeKey) then
    AutoChen.PersuadeBestEnemyInRange(myHero, myMana, persuasion, persuasionRange)
  end
  if Menu.IsKeyDownOnce(AutoChen.DominateKey) then
    AutoChen.DominateBestEnemyInRange(myHero)
  end
  if teleport and Menu.IsKeyDownOnce(AutoChen.CallUnitsGoInvisKey) then
    AutoChen.CallAndGoInvis(myHero, myMana, teleport)
  end
  if Entity.IsAlive(myHero) and not Entity.IsDormant(myHero) and Entity.GetHealth(myHero) > 0 then
    AutoChen.AutoSave(myHero, myMana, hand, hand_heal_amount)
    AutoChen.AutoUseItems(myHero, myMana)
  end
  if Menu.IsKeyDown(AutoChen.ComboKey) and Entity.IsAlive(myHero) and not Entity.IsDormant(myHero) and Entity.GetHealth(myHero) > 0 then
    AutoChen.UseItems(myHero, enemy, myMana)
    AutoChen.UseChenAbilities(myHero, enemy, myMana, faith, penitence, faith_max_damage, penitence_amp, attackPoint)
  end
  if Menu.IsKeyDown(AutoChen.ComboKey) then
    AutoChen.UseUnitAbilities(myHero, enemy, myMana)
  end
  if Entity.IsAlive(myHero) and not Entity.IsDormant(myHero) and Entity.GetHealth(myHero) > 0 then
    AutoChen.AutoKill(myHero, myMana, myInt, mySpellAmp, faith, faith_max_damage, penitence, penitence_amp, attackPoint, myAttackRange)
  end
  AutoChen.UnitsTryToBuffHeroes(myHero, myMana)
  if Menu.IsKeyDown(AutoChen.FarmKey) then
    AutoChen.UseUnitAbilitiesOnNPC(myHero, neutralEnemy, myMana)
  end
  AutoChen.ReadyToInvisCheck(myHero, myMana)
  AutoChen.AutoRaiseDead(myHero)
end
function AutoChen.PersuadeBestEnemyInRange(myHero, myMana, persuasion, persuasionRange)
  local npcTable = {}
  if AutoChen.IsSuitableToCastSpell(myHero) and not AutoChen.IsDisabled(myHero) and Ability.IsReady(persuasion) and Ability.IsCastable(persuasion, myMana) and not Ability.IsChannelling(persuasion) then
    for _, npc in ipairs(NPC.GetUnitsInRadius(myHero, persuasionRange, Enum.TeamType.TEAM_ENEMY)) do
      if Entity.IsAlive(npc) and not Entity.IsDormant(npc) and Entity.GetHealth(npc) then
        table.insert(npcTable, npc)
      end
    end
    for _, creep in ipairs(AutoChen.UsefulCreepNameList) do
      for _, npcName in ipairs(npcTable) do
        if creep == NPC.GetUnitName(npcName) then
          Ability.CastTarget(persuasion, npcName)
          return
        end
      end
    end
  end
end
function AutoChen.DominateBestEnemyInRange(myHero)
  local npcTable = {}
  local dominateItem = NPC.GetItem(myHero, "item_helm_of_the_dominator", true)
  if not dominateItem then return end
  local dominateRange = Ability.GetCastRange(dominateItem) + NPC.GetCastRangeBonus(myHero)
  if AutoChen.IsSuitableToCastSpell(myHero) and not AutoChen.IsDisabled(myHero) and Ability.IsReady(dominateItem) then
    for _, npc in ipairs(NPC.GetUnitsInRadius(myHero, dominateRange, Enum.TeamType.TEAM_ENEMY)) do
      if Entity.IsAlive(npc) and not Entity.IsDormant(npc) and Entity.GetHealth(npc) then
        table.insert(npcTable, npc)
      end
    end
    for _, creep in ipairs(AutoChen.UsefulCreepNameList) do
      for _, npcName in ipairs(npcTable) do
        if creep == NPC.GetUnitName(npcName) then
          Ability.CastTarget(dominateItem, npcName)
          return
        end
      end
    end
  end
end
function AutoChen.AutoKill(myHero, myMana, myInt, mySpellAmp, faith, faith_max_damage, penitence, penitence_amp, attackPoint, myAttackRange)
  if GameRules.GetGameTime() - AutoChen.UnitAbilityUseTime < AutoChen.Delay then return end
  for _, npc in pairs(NPC.GetHeroesInRadius(myHero, 99999, Enum.TeamType.TEAM_ENEMY)) do
    if npc and Entity.IsHero(npc) and Entity.IsAlive(npc) then
-- Kill with Test of Faith
      if AutoChen.IsSuitableToCastSpell(myHero) and AutoChen.CanCastSpellOn(npc) and not AutoChen.IsDisabled(myHero) and faith and Ability.IsCastable(faith, myMana) and Ability.IsReady(faith) and not Ability.IsInAbilityPhase(faith) and NPC.IsEntityInRange(myHero, npc, Ability.GetCastRange(faith)) and not Ability.IsChannelling(faith) and Entity.GetHealth(npc) <= NPC.GetMagicalArmorDamageMultiplier(npc) * faith_max_damage then
        Ability.CastTarget(faith, npc)
        AutoChen.UnitAbilityUseTime = GameRules.GetGameTime()
        return 
      end
-- Kill with Penitence + Test of Faith
      if AutoChen.IsSuitableToCastSpell(myHero) and AutoChen.CanCastSpellOn(npc) and not AutoChen.IsDisabled(myHero) and faith and NPC.IsEntityInRange(myHero, npc, Ability.GetCastRange(faith)) and not Ability.IsChannelling(faith) and Ability.IsReady(faith) and not Ability.IsInAbilityPhase(faith) and penitence and NPC.IsEntityInRange(myHero, npc, Ability.GetCastRange(penitence)) and not Ability.IsChannelling(penitence) and Entity.GetHealth(npc) <= NPC.GetMagicalArmorDamageMultiplier(npc) * (faith_max_damage * penitence_amp) and Ability.IsCastable(faith, myMana - Ability.GetManaCost(penitence)) and Ability.IsReady(penitence) and not Ability.IsInAbilityPhase(penitence) then
        Ability.CastTarget(penitence, npc)
        AutoChen.UnitAbilityUseTime = GameRules.GetGameTime()
        return 
      end
-- Kill with Right Click
      if not NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_ATTACK_IMMUNE) and not AutoChen.IsDisabled(myHero) and NPC.IsEntityInRange(myHero, npc, myAttackRange) and Entity.GetHealth(npc) <= (NPC.GetDamageMultiplierVersus(myHero, npc) * (NPC.GetTrueMaximumDamage(myHero) * NPC.GetArmorDamageMultiplier(npc))) and GameRules.GetGameTime() - AutoChen.ProjectileTime > attackPoint / (1 + (Hero.GetAgilityTotal(myHero)/100)) then
        Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET, npc, Vector(0, 0, 0), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_SELECTED_UNITS, nil)
        return
      end
-- Kill with Penitence + Right Click
      if not NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_ATTACK_IMMUNE) and not AutoChen.IsDisabled(myHero) and NPC.IsEntityInRange(myHero, npc, myAttackRange) and penitence and NPC.IsEntityInRange(myHero, npc, Ability.GetCastRange(penitence)) and not Ability.IsChannelling(penitence) and Entity.GetHealth(npc) <= ((NPC.GetDamageMultiplierVersus(myHero, npc) * (NPC.GetTrueMaximumDamage(myHero) * NPC.GetArmorDamageMultiplier(npc))) * penitence_amp) and GameRules.GetGameTime() - AutoChen.ProjectileTime > attackPoint / (1 + (Hero.GetAgilityTotal(myHero)/100)) and Ability.IsReady(penitence) and not Ability.IsInAbilityPhase(penitence) then
        Ability.CastTarget(penitence, npc)
        AutoChen.UnitAbilityUseTime = GameRules.GetGameTime()
        return
      end
-- Kill with Penitence + Test of Faith + Right Click
      if AutoChen.IsSuitableToCastSpell(myHero) and AutoChen.CanCastSpellOn(npc) and not AutoChen.IsDisabled(myHero) and faith and NPC.IsEntityInRange(myHero, npc, Ability.GetCastRange(faith)) and not Ability.IsChannelling(faith) and Ability.IsReady(faith) and not Ability.IsInAbilityPhase(faith) and penitence and NPC.IsEntityInRange(myHero, npc, Ability.GetCastRange(penitence)) and not Ability.IsChannelling(penitence) and Ability.IsReady(penitence) and not Ability.IsInAbilityPhase(penitence) and Entity.GetHealth(npc) <= NPC.GetMagicalArmorDamageMultiplier(npc) * (faith_max_damage + ((NPC.GetDamageMultiplierVersus(myHero, npc) * (NPC.GetTrueMaximumDamage(myHero) * NPC.GetArmorDamageMultiplier(npc))) * penitence_amp)) and Ability.IsCastable(faith, myMana - Ability.GetManaCost(penitence)) and not NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_ATTACK_IMMUNE) and GameRules.GetGameTime() - AutoChen.ProjectileTime > attackPoint / (1 + (Hero.GetAgilityTotal(myHero)/100)) then
        Ability.CastTarget(penitence, npc) 
        AutoChen.UnitAbilityUseTime = GameRules.GetGameTime()
        return 
      end
    end
  end
end
function AutoChen.CallAndGoInvis(myHero, myMana, teleport)
  local shadow_blade = NPC.GetItem(myHero, "item_invis_sword", true)
  local silver_edge = NPC.GetItem(myHero, "item_silver_edge", true)
  if silver_edge and Ability.IsReady(silver_edge) and Ability.IsCastable(silver_edge, myMana) and not Ability.IsInAbilityPhase(silver_edge) then
    if teleport and Ability.IsReady(teleport) and Ability.IsCastable(teleport, myMana) and not Ability.IsInAbilityPhase(teleport) then
      Ability.CastTarget(teleport, myHero)
      AutoChen.ReadyToInvisTime = GameRules.GetGameTime() + Ability.GetCastPoint(teleport) + .05
    end
    return
  end
  if shadow_blade and Ability.IsReady(shadow_blade) and Ability.IsCastable(shadow_blade, myMana) and not Ability.IsInAbilityPhase(shadow_blade) then
    if teleport and Ability.IsReady(teleport) and Ability.IsCastable(teleport, myMana) and not Ability.IsInAbilityPhase(teleport) then
      Ability.CastTarget(teleport, myHero)
      AutoChen.ReadyToInvisTime = GameRules.GetGameTime() + Ability.GetCastPoint(teleport) + .05
      Log.Write(tostring(AutoChen.ReadyToInvisTime))
      Log.Write(tostring(GameRules.GetGameTime()))
    end
    return
  end
end
function AutoChen.ReadyToInvisCheck(myHero, myMana)
  if not AutoChen.ReadyToInvisTime then return end
  local shadow_blade = NPC.GetItem(myHero, "item_invis_sword", true)
  local silver_edge = NPC.GetItem(myHero, "item_silver_edge", true)
  if GameRules.GetGameTime() >= AutoChen.ReadyToInvisTime then
    AutoChen.ReadyToInvisTime = nil
    if silver_edge and Ability.IsReady(silver_edge) and Ability.IsCastable(silver_edge, myMana) and not Ability.IsInAbilityPhase(silver_edge) then
      Ability.CastNoTarget(silver_edge)
    end
    if shadow_blade and Ability.IsReady(shadow_blade) and Ability.IsCastable(shadow_blade, myMana) and not Ability.IsInAbilityPhase(shadow_blade) then
      Ability.CastNoTarget(shadow_blade)
    end
  end
end
function AutoChen.OnDraw()
  if not GameRules.GetGameState() == 5 then return end
  local myHero = Heroes.GetLocal()
  if not myHero or NPC.GetUnitName(myHero) ~= "npc_dota_hero_chen" then return end
  if GameRules.GetGameTime() - AutoChen.CircleDrawTime > 5 then
    Engine.ExecuteCommand("dota_range_display " .. tostring(NPC.GetAttackRange(myHero)))
    AutoChen.CircleDrawTime = GameRules.GetGameTime()
  end
  for _, npc in ipairs(NPC.GetUnitsInRadius(myHero, 99999, Enum.TeamType.TEAM_FRIEND)) do
  if NPC.HasModifier(npc, "modifier_dominated") and not NPC.HasModifier(npc, "modifier_chen_holy_persuasion") and Entity.IsAlive(npc) and not Entity.IsDormant(npc) and Entity.GetHealth(npc) and (Entity.GetOwner(myHero) == Entity.GetOwner(npc) or Entity.OwnedBy(npc, myHero)) then
      local pos3 = NPC.GetAbsOrigin(npc)
      local x3, y3, visible3 = Renderer.WorldToScreen(pos3)
      if visible3 and npc then
        Renderer.SetDrawColor(255, 255, 255, 255)
        Renderer.DrawText(AutoChen.Font, x3+15, y3, "DOM", 1)
      end
  end
    if NPC.HasModifier(npc, "modifier_chen_test_of_faith_teleport") and Entity.IsAlive(npc) and not Entity.IsDormant(npc) and Entity.GetHealth(npc) and (Entity.GetOwner(myHero) == Entity.GetOwner(npc) or Entity.OwnedBy(npc, myHero)) then
      local mod1 = AutoChen.round(Modifier.GetDieTime(NPC.GetModifier(npc, "modifier_chen_test_of_faith_teleport")) - GameRules.GetGameTime(), 1)
      local pos1 = NPC.GetAbsOrigin(npc)
      local pos2 = NPC.GetAbsOrigin(myHero)
      local x1, y1, visible1 = Renderer.WorldToScreen(pos1)
      local x2, y2, visible2 = Renderer.WorldToScreen(pos2)
      if visible1 and npc and mod1 and GameRules.GetGameTime() <= Modifier.GetDieTime(NPC.GetModifier(npc, "modifier_chen_test_of_faith_teleport")) then
        Renderer.SetDrawColor(255, 255, 255, 255)
        Renderer.DrawText(AutoChen.Font, x1+15, y1+15, "(" .. tostring(mod1) .. ")", 1)
      end
      if visible2 and npc and mod1 and GameRules.GetGameTime() <= Modifier.GetDieTime(NPC.GetModifier(npc, "modifier_chen_test_of_faith_teleport")) then
        Renderer.SetDrawColor(255, 255, 255, 255)
        Renderer.DrawText(AutoChen.Font, x2+15, y2+15, "(" .. tostring(mod1) .. ")", 1)
      end
    end
    if Entity.IsAlive(npc) and not Entity.IsDormant(npc) and not NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) and not NPC.IsStructure(npc) and Entity.GetHealth(npc) and not Entity.IsHero(npc) and (Entity.GetOwner(myHero) == Entity.GetOwner(npc) or Entity.OwnedBy(npc, myHero)) then
      local pos = NPC.GetAbsOrigin(npc)
      local x, y, visible = Renderer.WorldToScreen(pos)
      if visible and npc then
        local SpellCount = 0
        Renderer.SetDrawColor(255, 255, 255, 255)
        for _, spell in ipairs(AutoChen.InteractiveAbilities) do
          if NPC.GetAbility(npc, spell) then
            SpellCount = SpellCount + 1
            if SpellCount == 3 then
              if Ability.GetCooldownTimeLeft(NPC.GetAbility(npc, spell)) > 0 then
              Renderer.DrawText(AutoChen.Font, x-15, y-15, "\n" .. "\n" .. tostring(math.ceil(Ability.GetCooldownTimeLeft(NPC.GetAbility(npc, spell)))), 1) -- tostring(Ability.GetName(NPC.GetAbility(npc, spell))) .. " " .. 
              end
            elseif SpellCount == 2 then
              if Ability.GetCooldownTimeLeft(NPC.GetAbility(npc, spell)) > 0 then
              Renderer.DrawText(AutoChen.Font, x-15, y-15, "\n" .. tostring(math.ceil(Ability.GetCooldownTimeLeft(NPC.GetAbility(npc, spell)))), 1) --tostring(Ability.GetName(NPC.GetAbility(npc, spell))) .. " " .. 
              end
            else
              if Ability.GetCooldownTimeLeft(NPC.GetAbility(npc, spell)) > 0 then
              Renderer.DrawText(AutoChen.Font, x-15, y-15, tostring(math.ceil(Ability.GetCooldownTimeLeft(NPC.GetAbility(npc, spell)))), 1) --tostring(Ability.GetName(NPC.GetAbility(npc, spell))) .. " "
              end
            end
          end
        end
      end
    end
  end
end
function AutoChen.UseItems(myHero, enemy, myMana)
  if NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then return end
  if GameRules.GetGameTime() - AutoChen.ItemUseTime < AutoChen.Delay then return end
  for _, item in ipairs(AutoChen.InteractiveItems) do
    if NPC.GetItem(myHero, item, true) and Ability.IsReady(NPC.GetItem(myHero, item, true)) and Ability.IsCastable(NPC.GetItem(myHero, item, true), myMana) and not Ability.IsInAbilityPhase(NPC.GetItem(myHero, item, true)) then --and not NPC.IsLinkensProtected(enemy)
      if Ability.GetCastRange(NPC.GetItem(myHero, item, true)) > 0 then
        if NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(NPC.GetItem(myHero, item, true)) + NPC.GetCastRangeBonus(myHero)) then
          Ability.CastTarget(NPC.GetItem(myHero, item, true), enemy)
          --Ability.GetName(NPC.GetItem(myHero, item, true))
          AutoChen.ItemUseTime = GameRules.GetGameTime()
        end
      elseif Ability.GetCastRange(NPC.GetItem(myHero, item, true)) == 0 then
        if NPC.IsEntityInRange(myHero, enemy, NPC.GetAttackRange(myHero)) then
          Ability.CastNoTarget(NPC.GetItem(myHero, item, true))
          --Ability.GetName(NPC.GetItem(myHero, item, true))
          AutoChen.ItemUseTime = GameRules.GetGameTime()
        end
      end
    end
  end
end
function AutoChen.UseUnitAbilities(myHero, enemy, myMana)
  if not enemy or not Entity.IsAlive(enemy) or Entity.IsDormant(enemy) or Entity.GetHealth(enemy) <= 0 or not NPC.IsPositionInRange(enemy, Input.GetWorldCursorPos(), 500, 0) then return end
  if GameRules.GetGameTime() - AutoChen.UnitAbilityUseTime < AutoChen.Delay then return end
  for _, npc in ipairs(NPC.GetUnitsInRadius(myHero, 99999, Enum.TeamType.TEAM_FRIEND)) do
    if Entity.IsAlive(npc) and not Entity.IsDormant(npc) and Entity.GetHealth(npc) and (Entity.GetOwner(myHero) == Entity.GetOwner(npc) or Entity.OwnedBy(npc, myHero)) then
      for _, ability in ipairs(AutoChen.InteractiveAbilities) do
        if ability ~= "dark_troll_warlord_raise_dead" and ability ~= "forest_troll_high_priest_heal" and ability ~= "enraged_wildkin_tornado" and ability ~= "ogre_magi_frost_armor" and ability ~= "big_thunder_lizard_frenzy" then
          if NPC.HasAbility(npc, ability) and Ability.IsCastable(NPC.GetAbility(npc, ability), NPC.GetMana(npc)) and Ability.IsReady(NPC.GetAbility(npc, ability)) and not Ability.IsInAbilityPhase(NPC.GetAbility(npc, ability)) and not NPC.IsLinkensProtected(enemy) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
            if Ability.GetCastRange(NPC.GetAbility(npc, ability)) > 0 then
              if NPC.IsEntityInRange(npc, enemy, Ability.GetCastRange(NPC.GetAbility(npc, ability)) + NPC.GetCastRangeBonus(npc)) then
                if ability == "black_dragon_fireball" then
                  Ability.CastPosition(NPC.GetAbility(npc, ability), Entity.GetAbsOrigin(enemy))
                  AutoChen.UnitAbilityUseTime = GameRules.GetGameTime()
                  return
                end
                if ability == "spawnlord_master_freeze" or ability == "dark_troll_warlord_ensnare" or ability == "mud_golem_hurl_boulder" then
                  if ((NPC.IsStunned(enemy) or NPC.HasModifier(enemy, "modifier_rooted") or NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_ROOTED)) and GameRules.GetGameTime() < AutoChen.StunTime + AutoChen.StunDuration) or GameRules.GetGameTime() < AutoChen.StunTime + AutoChen.StunDuration then
                    return
                  end
                  if GameRules.GetGameTime() >= AutoChen.StunTime + AutoChen.StunDuration then
                    Ability.CastTarget(NPC.GetAbility(npc, ability), enemy)
                    AutoChen.StunTime = GameRules.GetGameTime()
                    if ability == "spawnlord_master_freeze" then
                      AutoChen.StunDuration = 2
                    end
                    if ability == "dark_troll_warlord_ensnare" then
                      AutoChen.StunDuration = 1.75
                    end
                    if ability == "mud_golem_hurl_boulder" then
                      AutoChen.StunDuration = 0.6
                    end
                    AutoChen.UnitAbilityUseTime = GameRules.GetGameTime()
                    return
                  end
                end
                Ability.CastTarget(NPC.GetAbility(npc, ability), enemy)
                AutoChen.UnitAbilityUseTime = GameRules.GetGameTime()
                return
              end
            end

            if Ability.GetCastRange(NPC.GetAbility(npc, ability)) == 0 then
              --if ability == "dark_troll_warlord_raise_dead" then
              --Log.Write("test " .. tostring(GameRules.GetGameTime()))
              --Ability.CastNoTarget(NPC.GetAbility(npc, ability))
              --AutoChen.UnitAbilityUseTime = GameRules.GetGameTime()
              --return
              --end
              if ability == "big_thunder_lizard_slam" then
                if NPC.IsEntityInRange(npc, enemy, 250) then
                  Ability.CastNoTarget(NPC.GetAbility(npc, ability))
                  AutoChen.UnitAbilityUseTime = GameRules.GetGameTime()
                  return
                end
              end
              if ability == "centaur_khan_war_stomp" then
                if ((NPC.IsStunned(enemy) or NPC.HasModifier(enemy, "modifier_rooted") or NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_ROOTED)) and GameRules.GetGameTime() < AutoChen.StunTime + AutoChen.StunDuration) or GameRules.GetGameTime() < AutoChen.StunTime + AutoChen.StunDuration then
                  return
                end
                if GameRules.GetGameTime() >= AutoChen.StunTime + AutoChen.StunDuration and NPC.IsPositionInRange(npc, AutoChen.GetPredictedPosition(enemy, 0.5), 240) then
                  Ability.CastNoTarget(NPC.GetAbility(npc, ability))
                  AutoChen.StunTime = GameRules.GetGameTime()
                  AutoChen.StunDuration = 2
                  AutoChen.UnitAbilityUseTime = GameRules.GetGameTime()
                  return
                end
              end
              if NPC.IsEntityInRange(npc, enemy, NPC.GetAttackRange(npc)) then
                Ability.CastNoTarget(NPC.GetAbility(npc, ability))
                AutoChen.UnitAbilityUseTime = GameRules.GetGameTime()
                return
              end
            end
          end
        end
      end
    end
  end
end

function AutoChen.UseUnitAbilitiesOnNPC(myHero, enemy, myMana)
  if not enemy or not Entity.IsAlive(enemy) or Entity.IsDormant(enemy) or Entity.GetHealth(enemy) <= 0 or not NPC.IsPositionInRange(enemy, Input.GetWorldCursorPos(), 500, 0) and GameRules.GetGameTime() - AutoChen.MoveNPCOrderTime > 0.05 then
    Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, nil, Input.GetWorldCursorPos(), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_SELECTED_UNITS, nil)
    AutoChen.MoveNPCOrderTime = GameRules.GetGameTime()
    return 
  end
  if enemy and NPC.IsPositionInRange(enemy, Input.GetWorldCursorPos(), 500, 0) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_ATTACK_IMMUNE) and GameRules.GetGameTime() - AutoChen.AttackNPCOrderTime > 0.96  then
    Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET, enemy, Vector(0, 0, 0), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_SELECTED_UNITS, nil)
    AutoChen.AttackNPCOrderTime = GameRules.GetGameTime()
    return
  end
  if GameRules.GetGameTime() - AutoChen.UnitAbilityUseTime < AutoChen.Delay then return end
  for _, npc in ipairs(NPC.GetUnitsInRadius(myHero, 99999, Enum.TeamType.TEAM_FRIEND)) do
    if Entity.IsAlive(npc) and not Entity.IsDormant(npc) and Entity.GetHealth(npc) and (Entity.GetOwner(myHero) == Entity.GetOwner(npc) or Entity.OwnedBy(npc, myHero)) then
      for _, ability in ipairs(AutoChen.InteractiveAbilities) do
        if ability ~= "dark_troll_warlord_raise_dead" and ability ~= "forest_troll_high_priest_heal" and ability ~= "enraged_wildkin_tornado" and ability ~= "ogre_magi_frost_armor" and ability ~= "big_thunder_lizard_frenzy" and ability ~= "dark_troll_warlord_ensnare" then
          if NPC.HasAbility(npc, ability) and Ability.IsCastable(NPC.GetAbility(npc, ability), NPC.GetMana(npc)) and Ability.IsReady(NPC.GetAbility(npc, ability)) and not Ability.IsInAbilityPhase(NPC.GetAbility(npc, ability)) and not NPC.IsLinkensProtected(enemy) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
            if Ability.GetCastRange(NPC.GetAbility(npc, ability)) > 0 then
              if NPC.IsEntityInRange(npc, enemy, Ability.GetCastRange(NPC.GetAbility(npc, ability)) + NPC.GetCastRangeBonus(npc)) then
                if ability == "black_dragon_fireball" then
                  Ability.CastPosition(NPC.GetAbility(npc, ability), Entity.GetAbsOrigin(enemy))
                  AutoChen.UnitAbilityUseTime = GameRules.GetGameTime()
                  return
                end
                if ability == "spawnlord_master_freeze" or ability == "dark_troll_warlord_ensnare" or ability == "mud_golem_hurl_boulder" then
                  if ((NPC.IsStunned(enemy) or NPC.HasModifier(enemy, "modifier_rooted") or NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_ROOTED)) and GameRules.GetGameTime() < AutoChen.StunTime + AutoChen.StunDuration) or GameRules.GetGameTime() < AutoChen.StunTime + AutoChen.StunDuration then
                    return
                  end
                  if GameRules.GetGameTime() >= AutoChen.StunTime + AutoChen.StunDuration then
                    Ability.CastTarget(NPC.GetAbility(npc, ability), enemy)
                    AutoChen.StunTime = GameRules.GetGameTime()
                    if ability == "spawnlord_master_freeze" then
                      AutoChen.StunDuration = 2
                    end
                    if ability == "dark_troll_warlord_ensnare" then
                      AutoChen.StunDuration = 1.75
                    end
                    if ability == "mud_golem_hurl_boulder" then
                      AutoChen.StunDuration = 0.6
                    end
                    AutoChen.UnitAbilityUseTime = GameRules.GetGameTime()
                    return
                  end
                end
                Ability.CastTarget(NPC.GetAbility(npc, ability), enemy)
                AutoChen.UnitAbilityUseTime = GameRules.GetGameTime()
                return
              end
            end

            if Ability.GetCastRange(NPC.GetAbility(npc, ability)) == 0 then
              --if ability == "dark_troll_warlord_raise_dead" then
              --Log.Write("test " .. tostring(GameRules.GetGameTime()))
              --Ability.CastNoTarget(NPC.GetAbility(npc, ability))
              --AutoChen.UnitAbilityUseTime = GameRules.GetGameTime()
              --return
              --end
              if ability == "big_thunder_lizard_slam" then
                if NPC.IsEntityInRange(npc, enemy, 250) then
                  Ability.CastNoTarget(NPC.GetAbility(npc, ability))
                  AutoChen.UnitAbilityUseTime = GameRules.GetGameTime()
                  return
                end
              end
              if ability == "centaur_khan_war_stomp" then
                if ((NPC.IsStunned(enemy) or NPC.HasModifier(enemy, "modifier_rooted") or NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_ROOTED)) and GameRules.GetGameTime() < AutoChen.StunTime + AutoChen.StunDuration) or GameRules.GetGameTime() < AutoChen.StunTime + AutoChen.StunDuration then
                  return
                end
                if GameRules.GetGameTime() >= AutoChen.StunTime + AutoChen.StunDuration and NPC.IsPositionInRange(npc, AutoChen.GetPredictedPosition(enemy, 0.5), 200) then
                  Ability.CastNoTarget(NPC.GetAbility(npc, ability))
                  AutoChen.StunTime = GameRules.GetGameTime()
                  AutoChen.StunDuration = 2
                  AutoChen.UnitAbilityUseTime = GameRules.GetGameTime()
                  return
                end
              end
              if NPC.IsEntityInRange(npc, enemy, NPC.GetAttackRange(npc)) then
                Ability.CastNoTarget(NPC.GetAbility(npc, ability))
                AutoChen.UnitAbilityUseTime = GameRules.GetGameTime()
                return
              end
            end
          end
        end
      end
    end
  end
end

function AutoChen.UseChenAbilities(myHero, enemy, myMana, faith, penitence, faith_max_damage, penitence_amp, attackPoint)
  if not enemy or not Entity.IsAlive(enemy) or Entity.IsDormant(enemy) or Entity.GetHealth(enemy) <= 0 or not NPC.IsPositionInRange(enemy, Input.GetWorldCursorPos(), 500, 0) and GameRules.GetGameTime() - AutoChen.MoveOrderTime > 0.05 then
    Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, nil, Input.GetWorldCursorPos(), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_SELECTED_UNITS, nil)
    AutoChen.MoveOrderTime = GameRules.GetGameTime()
    return 
  end
  if Entity.IsAlive(myHero) and not Entity.IsDormant(myHero) and Entity.GetHealth(myHero) and AutoChen.IsSuitableToCastSpell(myHero) and AutoChen.CanCastSpellOn(enemy) and not AutoChen.IsDisabled(myHero) and enemy and Entity.IsAlive(enemy) and not Entity.IsDormant(enemy) and Entity.GetHealth(enemy) > 0 and NPC.IsPositionInRange(enemy, Input.GetWorldCursorPos(), 500, 0) then
    if penitence and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(penitence)) and not Ability.IsChannelling(penitence) and Ability.IsReady(penitence) and not Ability.IsInAbilityPhase(penitence) and GameRules.GetGameTime() - AutoChen.ChenAbilityUseTime > AutoChen.Delay then
      Ability.CastTarget(penitence, enemy)
      AutoChen.ChenAbilityUseTime = GameRules.GetGameTime()
      return 
    end
    if faith and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(faith)) and not Ability.IsChannelling(faith) and Ability.IsReady(faith) and not Ability.IsInAbilityPhase(faith) and GameRules.GetGameTime() - AutoChen.ChenAbilityUseTime > AutoChen.Delay then
      Ability.CastTarget(faith, enemy) 
      AutoChen.ChenAbilityUseTime = GameRules.GetGameTime()
      return 
    end
    if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_ATTACK_IMMUNE) and AutoChen.ProjectileTime and GameRules.GetGameTime() - AutoChen.ProjectileTime > attackPoint / (1 + (Hero.GetAgilityTotal(myHero)/100)) and GameRules.GetGameTime() - AutoChen.AttackOrderTime > 0.05  then
      Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET, enemy, Vector(0, 0, 0), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_SELECTED_UNITS, nil)
      AutoChen.AttackOrderTime = GameRules.GetGameTime()
      return
    end
  end
end
function AutoChen.UnitsTryToBuffHeroes(myHero, myMana)
  AutoChen.HeroToBuff = nil
  AutoChen.NeutralToBuffWithOgre = nil
  AutoChen.HeroToBuffWithPriest = nil
  AutoChen.HeroToBuffWithOgre = nil
  AutoChen.HeroToBuffWithLizard = nil  
  if GameRules.GetGameTime() - AutoChen.UnitAbilityUseTime < AutoChen.Delay then return end
  for _, npc in ipairs(NPC.GetUnitsInRadius(myHero, 99999, Enum.TeamType.TEAM_FRIEND)) do
    if NPC.GetUnitName(npc) == "npc_dota_neutral_forest_troll_high_priest" and Entity.IsAlive(npc) and not Entity.IsDormant(npc) and Entity.GetHealth(npc) and (Entity.GetOwner(myHero) == Entity.GetOwner(npc) or Entity.OwnedBy(npc, myHero)) and NPC.HasAbility(npc, "forest_troll_high_priest_heal") and Ability.IsCastable(NPC.GetAbility(npc, "forest_troll_high_priest_heal"), NPC.GetMana(npc)) and Ability.IsReady(NPC.GetAbility(npc, "forest_troll_high_priest_heal")) then
      for _, hero in ipairs(NPC.GetHeroesInRadius(npc, Ability.GetCastRange(NPC.GetAbility(npc, "forest_troll_high_priest_heal")), Enum.TeamType.TEAM_FRIEND)) do 
        if Entity.IsAlive(hero) and not Entity.IsDormant(hero) and not NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) and not NPC.IsStructure(hero) and Entity.GetHealth(hero) < Entity.GetMaxHealth(hero) and not NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_ATTACK_IMMUNE) then
          if not lowestHealth or not AutoChen.HeroToBuffWithPriest then
            local lowestHealth = Entity.GetHealth(hero)
            AutoChen.HeroToBuffWithPriest = hero
          end
          if lowestHealth and AutoChen.HeroToBuffWithPriest and Entity.GetHealth(hero) < lowestHealth then
            lowestHealth = Entity.GetHealth(hero)
            AutoChen.HeroToBuffWithPriest = hero
          end
        end
      end
      if AutoChen.HeroToBuffWithPriest then
        Ability.CastTarget(NPC.GetAbility(npc, "forest_troll_high_priest_heal"), AutoChen.HeroToBuffWithPriest)
        AutoChen.UnitAbilityUseTime = GameRules.GetGameTime()
        AutoChen.HeroToBuffWithPriest = nil
        return
      end
    end

    if NPC.GetUnitName(npc) == "npc_dota_neutral_big_thunder_lizard" and Entity.IsAlive(npc) and not Entity.IsDormant(npc) and Entity.GetHealth(npc) and (Entity.GetOwner(myHero) == Entity.GetOwner(npc) or Entity.OwnedBy(npc, myHero)) and NPC.HasAbility(npc, "big_thunder_lizard_frenzy") and Ability.IsCastable(NPC.GetAbility(npc, "big_thunder_lizard_frenzy"), NPC.GetMana(npc)) and Ability.IsReady(NPC.GetAbility(npc, "big_thunder_lizard_frenzy")) then
      for _, hero in ipairs(NPC.GetHeroesInRadius(npc, Ability.GetCastRange(NPC.GetAbility(npc, "big_thunder_lizard_frenzy")), Enum.TeamType.TEAM_FRIEND)) do 
        if Entity.IsAlive(hero) and not Entity.IsDormant(hero) and not NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) and not NPC.IsStructure(hero) and Entity.GetHealth(hero) and not NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_ATTACK_IMMUNE) and not NPC.HasModifier(hero, "modifier_big_thunder_lizard_frenzy") then
          if not lowestHealth or not AutoChen.HeroToBuffWithLizard then
            local lowestHealth = Entity.GetHealth(hero)
            AutoChen.HeroToBuffWithLizard = hero
          end
          if lowestHealth and AutoChen.HeroToBuffWithLizard and Entity.GetHealth(hero) < lowestHealth then
            lowestHealth = Entity.GetHealth(hero)
            AutoChen.HeroToBuffWithLizard = hero
          end
        end
      end
      if AutoChen.HeroToBuffWithLizard then
        local enemyAround = NPC.GetHeroesInRadius(AutoChen.HeroToBuffWithLizard, NPC.GetAttackRange(AutoChen.HeroToBuffWithLizard), Enum.TeamType.TEAM_ENEMY)
        if #enemyAround > 0 then
          Ability.CastTarget(NPC.GetAbility(npc, "big_thunder_lizard_frenzy"), AutoChen.HeroToBuffWithLizard)
          AutoChen.UnitAbilityUseTime = GameRules.GetGameTime()
          AutoChen.HeroToBuffWithLizard = nil
          return
        end
      end
    end
    if NPC.GetUnitName(npc) == "npc_dota_neutral_ogre_magi" and Entity.IsAlive(npc) and not Entity.IsDormant(npc) and Entity.GetHealth(npc) and (Entity.GetOwner(myHero) == Entity.GetOwner(npc) or Entity.OwnedBy(npc, myHero)) and NPC.HasAbility(npc, "ogre_magi_frost_armor") and Ability.IsCastable(NPC.GetAbility(npc, "ogre_magi_frost_armor"), NPC.GetMana(npc)) and Ability.IsReady(NPC.GetAbility(npc, "ogre_magi_frost_armor")) then
      for _, hero in ipairs(NPC.GetHeroesInRadius(npc, Ability.GetCastRange(NPC.GetAbility(npc, "ogre_magi_frost_armor")), Enum.TeamType.TEAM_FRIEND)) do
        if Entity.IsAlive(hero) and not Entity.IsDormant(hero) and not NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) and not NPC.IsStructure(hero) and Entity.GetHealth(hero) <= Entity.GetMaxHealth(hero) and not NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_ATTACK_IMMUNE) and not NPC.HasModifier(hero, "modifier_ogre_magi_frost_armor") and not Ability.IsInAbilityPhase(NPC.GetAbility(npc, "ogre_magi_frost_armor")) then
          if not lowestHealth or not AutoChen.HeroToBuffWithOgre then
            local lowestHealth = Entity.GetHealth(hero)
            AutoChen.HeroToBuffWithOgre = hero
          end
          if lowestHealth and AutoChen.HeroToBuffWithOgre and Entity.GetHealth(hero) < lowestHealth then
            lowestHealth = Entity.GetHealth(hero)
            AutoChen.HeroToBuffWithOgre = hero
          end
        end
      end
      if AutoChen.HeroToBuffWithOgre and not Ability.IsInAbilityPhase(NPC.GetAbility(npc, "ogre_magi_frost_armor")) and not NPC.HasModifier(AutoChen.HeroToBuffWithOgre, "modifier_ogre_magi_frost_armor") then
        Ability.CastTarget(NPC.GetAbility(npc, "ogre_magi_frost_armor"), AutoChen.HeroToBuffWithOgre)
        AutoChen.UnitAbilityUseTime = GameRules.GetGameTime()
        AutoChen.HeroToBuffWithOgre = nil
        return
      end
    end
    if NPC.GetUnitName(npc) == "npc_dota_neutral_ogre_magi" and Entity.IsAlive(npc) and not Entity.IsDormant(npc) and Entity.GetHealth(npc) and (Entity.GetOwner(myHero) == Entity.GetOwner(npc) or Entity.OwnedBy(npc, myHero)) and NPC.HasAbility(npc, "ogre_magi_frost_armor") and Ability.IsCastable(NPC.GetAbility(npc, "ogre_magi_frost_armor"), NPC.GetMana(npc)) and Ability.IsReady(NPC.GetAbility(npc, "ogre_magi_frost_armor")) then
      for _, neutral in ipairs(NPC.GetUnitsInRadius(npc, Ability.GetCastRange(NPC.GetAbility(npc, "ogre_magi_frost_armor")), Enum.TeamType.TEAM_FRIEND)) do 
        if Entity.IsAlive(neutral) and not Entity.IsDormant(neutral) and not Entity.IsHero(neutral) and not NPC.HasState(neutral, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) and not NPC.IsStructure(neutral) and Entity.GetHealth(neutral) <= Entity.GetMaxHealth(neutral) and not NPC.HasState(neutral, Enum.ModifierState.MODIFIER_STATE_ATTACK_IMMUNE) and not NPC.HasModifier(neutral, "modifier_ogre_magi_frost_armor") and NPC.GetMana(npc) >= NPC.GetMaxMana(npc) * .5 and not Ability.IsInAbilityPhase(NPC.GetAbility(npc, "ogre_magi_frost_armor")) and NPC.GetUnitName(neutral) ~= "npc_dota_dark_troll_warlord_skeleton_warrior" and NPC.GetUnitName(neutral) ~= "npc_dota_creep_goodguys_melee" and NPC.GetUnitName(neutral) ~= "npc_dota_creep_goodguys_melee_upgraded" and NPC.GetUnitName(neutral) ~= "npc_dota_creep_goodguys_melee_upgraded_mega" and NPC.GetUnitName(neutral) ~= "npc_dota_goodguys_siege" and NPC.GetUnitName(neutral) ~= "npc_dota_creep_goodguys_ranged" and NPC.GetUnitName(neutral) ~= "npc_dota_creep_goodguys_ranged_upgraded" and NPC.GetUnitName(neutral) ~= "npc_dota_creep_goodguys_ranged_upgraded_mega" then
          if not lowestHealthNeutral or not AutoChen.NeutralToBuffWithOgre then
            local lowestHealthNeutral = Entity.GetHealth(neutral)
            AutoChen.NeutralToBuffWithOgre = neutral
          end
          if lowestHealthNeutral and AutoChen.NeutralToBuffWithOgre and Entity.GetHealth(neutral) < lowestHealthNeutral then
            lowestHealthNeutral = Entity.GetHealth(neutral)
            AutoChen.NeutralToBuffWithOgre = neutral
          end
        end
      end
      if AutoChen.NeutralToBuffWithOgre and not AutoChen.HeroToBuffWithOgre and not Ability.IsInAbilityPhase(NPC.GetAbility(npc, "ogre_magi_frost_armor")) and not NPC.HasModifier(AutoChen.NeutralToBuffWithOgre, "modifier_ogre_magi_frost_armor") then
        Ability.CastTarget(NPC.GetAbility(npc, "ogre_magi_frost_armor"), AutoChen.NeutralToBuffWithOgre)
        AutoChen.UnitAbilityUseTime = GameRules.GetGameTime()
        AutoChen.NeutralToBuffWithOgre = nil
        return
      end
      if not AutoChen.HeroToBuffWithOgre and not Ability.IsInAbilityPhase(NPC.GetAbility(npc, "ogre_magi_frost_armor")) and not NPC.HasModifier(npc, "modifier_ogre_magi_frost_armor") then
        Ability.CastTarget(NPC.GetAbility(npc, "ogre_magi_frost_armor"), npc)
        AutoChen.UnitAbilityUseTime = GameRules.GetGameTime()
        AutoChen.NeutralToBuffWithOgre = nil
        return
      end
    end
  end
end
function AutoChen.AutoSave(myHero, myMana, hand, hand_heal_amount)
  if GameRules.GetGameTime() - AutoChen.ChenAbilityUseTime < AutoChen.Delay then return end
  if Entity.GetHealth(myHero) <= Entity.GetMaxHealth(myHero) * 0.17 and Ability.IsReady(hand) and Ability.IsCastable(hand, myMana) and not NPC.IsIllusion(myHero) then
    Ability.CastNoTarget(hand)
    AutoChen.ChenAbilityUseTime = GameRules.GetGameTime()
    return
  end
  for _, npc in pairs(NPC.GetHeroesInRadius(myHero, 99999, Enum.TeamType.TEAM_FRIEND)) do
    if Entity.IsHero(npc) and not NPC.IsIllusion(npc) and Entity.GetHealth(npc) <= Entity.GetMaxHealth(npc) * 0.17 and Ability.IsReady(hand) and Ability.IsCastable(hand, myMana) then
      Ability.CastNoTarget(hand)
      AutoChen.ChenAbilityUseTime = GameRules.GetGameTime()
      return
    end
  end
end
function AutoChen.AutoUseItems(myHero, myMana)
  local stick = NPC.GetItem(myHero, "item_magic_stick", true)
  local wand = NPC.GetItem(myHero, "item_magic_wand", true)
  local mekansm = NPC.GetItem(myHero, "item_mekansm", true)
  local greaves = NPC.GetItem(myHero, "item_guardian_greaves", true)
  local arcane = NPC.GetItem(myHero, "item_arcane_boots", true)

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
function AutoChen.round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end


AutoChen.AncientCreepNameList = {
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
function AutoChen.BestPosition(unitsAround, radius)
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
function AutoChen.GetPredictedPosition(npc, delay)
    local pos = Entity.GetAbsOrigin(npc)
    if AutoChen.CantMove(npc) then return pos end
    if not NPC.IsRunning(npc) or not delay then return pos end

    local dir = Entity.GetRotation(npc):GetForward():Normalized()
    local speed = AutoChen.GetMoveSpeed(npc)

    return pos + dir:Scaled(speed * delay)
end

function AutoChen.GetMoveSpeed(npc)
    local base_speed = NPC.GetBaseSpeed(npc)
    local bonus_speed = NPC.GetMoveSpeed(npc) - NPC.GetBaseSpeed(npc)

    -- when affected by ice wall, assume move speed as 100 for convenience
    if NPC.HasModifier(npc, "modifier_invoker_ice_wall_slow_debuff") then return 100 end

    -- when get hexed,  move speed = 140/100 + bonus_speed
    if AutoChen.GetHexTimeLeft(npc) > 0 then return 140 + bonus_speed end

    return base_speed + bonus_speed
end

-- return true if is protected by lotus orb or AM's aghs
function AutoChen.IsLotusProtected(npc)
  if NPC.HasModifier(npc, "modifier_item_lotus_orb_active") then return true end

  local shield = NPC.GetAbility(npc, "antimage_spell_shield")
  if shield and Ability.IsReady(shield) and NPC.HasItem(npc, "item_ultimate_scepter", true) then
    return true
  end

  return false
end

-- return true if this npc is disabled, return false otherwise
function AutoChen.IsDisabled(npc)
  if not Entity.IsAlive(npc) then return true end
  if NPC.IsStunned(npc) then return true end
  if NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_HEXED) then return true end

    return false
end

-- return true if can cast spell on this npc, return false otherwise
function AutoChen.CanCastSpellOn(npc)
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
function AutoChen.IsSafeToCast(myHero, enemy, magic_damage)
    if not myHero or not enemy or not magic_damage then return true end
    if magic_damage <= 0 then return true end

    local counter = 0
    if NPC.HasModifier(enemy, "modifier_item_lotus_orb_active") then counter = counter + 1 end
    if NPC.HasModifier(enemy, "modifier_item_blade_mail_reflect") then counter = counter + 1 end

    local reflect_damage = counter * magic_damage * NPC.GetMagicalArmorDamageMultiplier(myHero)
    return Entity.GetHealth(myHero) > reflect_damage
end

-- situations that ally need to be saved
function AutoChen.NeedToBeSaved(npc)
  if not npc or NPC.IsIllusion(npc) or not Entity.IsAlive(npc) then return false end

  if NPC.IsStunned(npc) or NPC.IsSilenced(npc) then return true end
  if NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_ROOTED) then return true end
  if NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_DISARMED) then return true end
  if NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_HEXED) then return true end
  if NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_PASSIVES_DISABLED) then return true end
  if NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_BLIND) then return true end

  if Entity.GetHealth(npc) <= 0.2 * Entity.GetMaxHealth(npc) then return true end

  return false
end

-- pop all defensive items
function AutoChen.PopDefensiveItems(myHero)
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

function AutoChen.IsAncientCreep(npc)
    if not npc then return false end

    for i, name in ipairs(AutoChen.AncientCreepNameList) do
        if name and NPC.GetUnitName(npc) == name then return true end
    end

    return false
end

function AutoChen.CantMove(npc)
    if not npc then return false end

    if NPC.IsRooted(npc) or AutoChen.GetStunTimeLeft(npc) >= 1 then return true end
    if NPC.HasModifier(npc, "modifier_axe_berserkers_call") then return true end
    if NPC.HasModifier(npc, "modifier_legion_commander_duel") then return true end

    return false
end

-- only able to get stun modifier. no specific modifier for root or hex.
function AutoChen.GetStunTimeLeft(npc)
    local mod = NPC.GetModifier(npc, "modifier_stunned")
    if not mod then return 0 end
    return math.max(Modifier.GetDieTime(mod) - GameRules.GetGameTime(), 0)
end

-- hex only has three types: sheepstick, lion's hex, shadow shaman's hex
function AutoChen.GetHexTimeLeft(npc)
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
function AutoChen.IsSuitableToCastSpell(myHero)
    if NPC.IsSilenced(myHero) or NPC.IsStunned(myHero) or not Entity.IsAlive(myHero) then return false end
    --if NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) then return false end
    if NPC.HasModifier(myHero, "modifier_teleporting") then return false end
    if NPC.IsChannellingAbility(myHero) then return false end
    return true
end

function AutoChen.IsSuitableToUseItem(myHero)
    if NPC.IsStunned(myHero) or not Entity.IsAlive(myHero) then return false end
    if NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) then return false end
    if NPC.HasModifier(myHero, "modifier_teleporting") then return false end
    if NPC.IsChannellingAbility(myHero) then return false end
    return true
end

-- return true if: (1) channeling ability; (2) TPing
function AutoChen.IsChannellingAbility(npc, target)
    if NPC.HasModifier(npc, "modifier_teleporting") then return true end
    if NPC.IsChannellingAbility(npc) then return true end
    
    return false
end

function AutoChen.IsAffectedByDoT(npc)
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
return AutoChen