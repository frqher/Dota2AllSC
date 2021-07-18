local AbilityAlert2 = {}
--resource\flash3\images\miniheroes\lina.png
AbilityAlert2.option = Menu.AddOption({ "Awareness", "Ability Alert Advanced"}, "Enable", "Alerts you when certain abilities are used.")
AbilityAlert2.boxSizeOption = Menu.AddOption({ "Awareness", "Ability Alert Advanced" }, "Map Display Size", "", 30, 100, 1)
AbilityAlert2.miniBoxSizeOption = Menu.AddOption({ "Awareness", "Ability Alert Advanced" }, "MiniMap Display Size", "", 10, 50, 1)
AbilityAlert2.font = Renderer.LoadFont("Tahoma", 30, Enum.FontWeight.EXTRABOLD)
AbilityAlert2.mapFont = Renderer.LoadFont("Tahoma", 22, Enum.FontWeight.NORMAL)
AbilityAlert2.miniHero = "resource/flash3/images/miniheroes/"
-- current active alerts.
AbilityAlert2.alerts = {}
AbilityAlert2.mapOrigin = {x=-7000, y=7000}
AbilityAlert2.cachedIcons = {}

AbilityAlert2.ratioOffset = Menu.AddOption({ "Awareness", "Ability Alert Advanced" }, "Ratio", "", -300, 300, 2)
AbilityAlert2.xOffset = Menu.AddOption({ "Awareness", "Ability Alert Advanced" }, "x Offset", "", -25, 25, 1)
AbilityAlert2.yOffset = Menu.AddOption({ "Awareness", "Ability Alert Advanced" }, "y Offset", "", -25, 25, 1)

AbilityAlert2.ambiguous =
{
    {  
        name = "nyx_assassin_vendetta_start",
        msg = " has used Vendetta",
        ability = "nyx_assassin_vendetta",
        duration = 15,
        unique = true
    },
    {
        name = "smoke_of_deceit",
        shortName = "smoke",
        msg = "Smoke of Deceit has been used",
        ability ="",
        duration = 35,
        unique = false
    },
    -- {
    --     name = "blink_dagger_start",
    --     shortName = "dagger",
    --     msg = "dagger",
    --     ability ="",
    --     duration = 4,
    --     unique = false
    -- },
    {  
        name = "queen_blink_start",
        msg ='',
        ability = "queenofpain_blink",
        duration = 4,
        unique = true
    },
    {  
        name = "bounty_hunter_windwalk",
        msg ='bounty is invisiable',
        ability = "bounty_hunter_wind_walk",
        duration = 8,
        unique = true
    },
    {  
        name = "antimage_blink_start",
        msg ='',
        ability = "antimage_blink",
        duration = 4,
        unique = true
    },
    {  
        name = "invoker_ice_wall",
        msg ='',
        ability = "invoker_ice_wall",
        duration = 4,
        unique = true
    },
    {  
        name = "invoker_emp",
        msg ='',
        ability = "invoker_emp",
        duration = 4,
        unique = true
    },
    {  
        name = "invoker_quas_orb",
        msg ='',
        ability = "invoker_quas",
        duration = 4,
        unique = true
    },
    {  
        name = "invoker_wex_orb",
        msg ='',
        ability = "invoker_wex",
        duration = 4,
        unique = true
    },
    {  
        name = "invoker_exort_orb",
        msg ='',
        ability = "invoker_exort",
        duration = 4,
        unique = true
    },
    {  
        name = "legion_commander_odds",
        msg ='',
        ability = "legion_commander_overwhelming_odds",
        duration = 4,
        unique = true
    },
    {  
        name = "roshan_spawn",
        msg ='Roshan respawned',
        ability = "",
        duration = 4,
        unique = true
    },
    {  
        name = "roshan_slam",
        shortName = "rosh",
        msg ='Roshan is under attack',
        ability = "",
        duration = 4,
        unique = true
    },
    {  
        name = "tiny_avalanche",
        msg ='',
        ability = "tiny_avalanche",
        duration = 4,
        unique = true
    },
    {  
        name = "tiny_toss",
        msg ='',
        ability = "tiny_toss",
        duration = 4,
        unique = true
    },
    {  
        name = "earthshaker_fissure",
        msg ='',
        ability = "earthshaker_fissure",
        duration = 4,
        unique = true
    },
    {  
        name = "shredder_tree_dmg",
        msg ='',
        ability = "shredder_timber_chain",
        duration = 4,
        unique = true
    },
    {  
        name = "shredder_chakram_stay",
        msg ='',
        ability = "shredder_chakram",
        duration = 4,
        unique = true
    },
    {  
        name = "shredder_chakram_return",
        msg ='',
        ability = "shredder_chakram",
        duration = 4,
        unique = true
    },
    {  
        name = "sandking_burrowstrike",
        msg ='',
        ability = "sandking_burrowstrike",
        duration = 4,
        unique = true
    },
    {  
        name = "sandking_sandstorm",
        msg ='',
        ability = "sandking_sand_storm",
        duration = 10,
        unique = true
    },
    {  
        name = "alchemist_unstable_concoction_timer",
        msg ='Alchemist has started unstable ',
        ability = "alchemist_unstable_concoction",
        duration = 10,
        unique = true
    },
    {  
        name = "alchemist_acid_spray",
        msg ='',
        ability = "alchemist_acid_spray",
        duration = 10,
        unique = true
    },
    {  
        name = "clinkz_windwalk",
        msg ='clinkz is invisble',
        ability = "clinkz_wind_walk",
        duration = 35,
        unique = true
    },
    {  
        name = "clinkz_death_pact",
        msg ='',
        ability = "clinkz_death_pact",
        duration = 4,
        unique = true
    },
    {  
        name = "razor_plasmafield",
        msg ='',
        ability = "razor_plasma_field",
        duration = 4,
        unique = true
    },
    {  
        name = "venomancer_ward_cast",
        msg ='',
        ability = "venomancer_plague_ward",
        duration = 4,
        unique = true
    },
    {  
        name = "meepo_poof_end",
        msg ='',
        ability = "meepo_poof",
        duration = 4,
        unique = true
    },
    {  
        name = "slark_dark_pact_pulses",
        msg ='',
        ability = "slark_dark_pact",
        duration = 4,
        unique = true
    },
    {  
        name = "slark_pounce_start",
        msg ='',
        ability = "slark_pounce",
        duration = 4,
        unique = true
    },
    {  
        name = "ember_spirit_sleight_of_fist_cast",
        msg ='',
        ability = "ember_spirit_sleight_of_fist",
        duration = 4,
        unique = true
    },
    {  
        name = "zuus_arc_lightning_head",
        msg ='',
        ability = "zuus_arc_lightning",
        duration = 4,
        unique = true
    },
    {  
        name = "zuus_thundergods_wrath_start",
        msg ='',
        ability = "zuus_thundergods_wrath",
        duration = 4,
        unique = true
    },
    {  
        name = "zuus_lightning_bolt",
        msg ='',
        ability = "zuus_lightning_bolt",
        duration = 4,
        unique = true
    },
    {  
        name = "lina_spell_light_strike_array",
        msg ='',
        ability = "lina_light_strike_array",
        duration = 4,
        unique = true
    },
    {  
        name = "leshrac_split_earth",
        msg ='',
        ability = "leshrac_split_earth",
        duration = 4,
        unique = true
    },
    {  
        name = "disruptor_kineticfield_formation",
        msg ='',
        ability = "disruptor_kinetic_field",
        duration = 4,
        unique = true
    },
    {  
        name = "jakiro_ice_path",
        msg ='',
        ability = "jakiro_ice_path",
        duration = 4,
        unique = true
    },
    {  
        name = "jakiro_dual_breath_ice",
        msg ='',
        ability = "jakiro_dual_breath",
        duration = 4,
        unique = true
    },
    {  
        name = "maiden_crystal_nova",
        msg ='',
        ability = "crystal_maiden_crystal_nova",
        duration = 4,
        unique = true
    },
    {  
        name = "phantom_assassin_phantom_strike_start",
        msg ='',
        ability = "phantom_assassin_phantom_strike",
        duration = 4,
        unique = true
    },
    {  
        name = "phantom_assassin_phantom_strike_end",
        msg ='',
        ability = "phantom_assassin_phantom_strike",
        duration = 4,
        unique = true
    },
    {  
        name = "stormspirit_ball_lightning",
        msg ='',
        ability = "storm_spirit_ball_lightning",
        duration = 4,
        unique = true
    },
    {  
        name = "ancient_apparition_ice_blast_final",
        msg ='has Ulted!!',
        ability = "ancient_apparition_ice_blast",
        duration = 4,
        unique = true
    },
    {  
        name = "ancient_apparition_chilling_touch",
        msg ='',
        ability = "ancient_apparition_chilling_touch",
        duration = 4,
        unique = true
    },
    {  
        name = "ancient_ice_vortex",
        msg ='',
        ability = "ancient_apparition_ice_vortex",
        duration = 4,
        unique = true
    },
    {  
        name = "weaver_shukuchi_damage",
        msg ='',
        ability = "weaver_shukuchi",
        duration = 4,
        unique = true
    },
    {  
        name = "weaver_shukuchi_start",
        msg ='',
        ability = "weaver_shukuchi",
        duration = 4,
        unique = true
    },
    {  
        name = "pudge_meathook",
        msg ='',
        ability = "pudge_meat_hook",
        duration = 4,
        unique = true
    },
    {  
        name = "rattletrap_cog_ambient",
        msg ='',
        ability = "rattletrap_power_cogs",
        duration = 4,
        unique = true
    },
    {  
        name = "rattletrap_hookshot",
        msg ='',
        ability = "rattletrap_hookshot",
        duration = 4,
        unique = true
    },
    {  
        name = "rattletrap_rocket_flare",
        msg ='',
        ability = "rattletrap_rocket_flare",
        duration = 4,
        unique = true
    },
    {  
        name = "tinker_rearm",
        msg ='',
        ability = "tinker_rearm",
        duration = 4,
        unique = true
    },
    {  
        name = "luna_lucent_beam",
        msg ='',
        ability = "luna_lucent_beam",
        duration = 4,
        unique = true
    },
    {  
        name = "pugna_netherblast",
        msg ='',
        ability = "pugna_nether_blast",
        duration = 4,
        unique = true
    },
    {  
        name = "monkey_king_strike_cast",
        msg ='',
        ability = "monkey_king_boundless_strike",
        duration = 4,
        unique = true
    },
    {  
        name = "monkey_king_jump_trail",
        msg ='',
        ability = "monkey_king_tree_dance",
        duration = 4,
        unique = true
    },
    {  
        name = "monkey_king_jump_launch_ring",
        msg ='',
        ability = "monkey_king_tree_dance",
        duration = 4,
        unique = true
    },
     {  
        name = "monkey_king_spring_channel",
        msg ='',
        ability = "monkey_king_primal_spring",
        duration = 4,
        unique = true
    },
    {  
        name = "axe_counterhelix",
        msg ='',
        ability = "axe_counter_helix",
        duration = 4,
        unique = true
    },
    {  
        name = "legion_commander_courage_hit",
        msg ='',
        ability = "legion_commander_moment_of_courage",
        duration = 4,
        unique = true
    },
    {  
        name = "legion_commander_press_owner",
        msg ='',
        ability = "legion_commander_press_the_attack",
        duration = 4,
        unique = true
    },
    {  
        name = "stormspirit_overload_discharge",
        msg ='',
        ability = "storm_spirit_overload",
        duration = 4,
        unique = true
    },
    {  
        name = "tinker_missile_dud",
        msg ='',
        ability = "tinker_heat_seeking_missile",
        duration = 4,
        unique = true
    },
    {  
        name = "tidehunter_anchor_hero",
        msg ='',
        ability = "tidehunter_anchor_smash",
        duration = 4,
        unique = true
    },
    {  
        name = "techies_remote_mine_plant",
        msg ='',
        ability = "techies_remote_mines",
        duration = 100,
        unique = true
    },
    {  
        name = "techies_stasis_trap_plant",
        msg ='',
        ability = "techies_stasis_trap",
        duration = 100,
        unique = true
    }
}

AbilityAlert2.teamSpecific = 
{
    -- unique because this particle gets created for every enemy team hero.
    {  
        name = "mirana_moonlight_recipient",
        msg = "Mirana has used her ult",
        duration = 15,
        unique = true
    }
}

-- Returns true if an alert was created, false otherwise.
function AbilityAlert2.InsertAmbiguous(particle)
    local myHero = Heroes.GetLocal()
    for i, enemyAbility in ipairs(AbilityAlert2.ambiguous) do
        if particle.name == enemyAbility.name then
            local enemy = nill
            local ally = nill
            for i = 1, Heroes.Count() do
                local hero = Heroes.Get(i)
                if not NPC.IsIllusion(hero) then
                    local sameTeam = Entity.GetTeamNum(hero) == Entity.GetTeamNum(myHero)
                    if not sameTeam and NPC.GetAbility(hero, enemyAbility.ability) and not NPC.GetAbility(myHero, enemyAbility.ability) then
                        enemy = hero
                    end
                    if sameTeam and NPC.GetAbility(hero, enemyAbility.ability) then
                        ally = hero
                    end
                end
            end

            local newAlert = {
                index = particle.index,
                name = enemyAbility.name,
                msg = enemyAbility.msg,
                endTime = os.clock() + enemyAbility.duration,
                shortName = enemyAbility.shortName
            }
            if enemy then
                newAlert['enemy'] = NPC.GetUnitName(enemy)
                newAlert['msg'] = string.sub (NPC.GetUnitName(enemy),string.len("npc_dota_hero_")-string.len(NPC.GetUnitName(enemy)))..enemyAbility.msg
                table.insert(AbilityAlert2.alerts, newAlert)
            end 
            if ally then return end
            table.insert(AbilityAlert2.alerts, newAlert)

            return true
        end
    end

    return false
end

-- Returns true if an alert was created (or an existing one was extended), false otherwise.
function AbilityAlert2.InsertTeamSpecific(particle)
    local myHero = Heroes.GetLocal()

    if particle.entity == nil then return end
    if Entity.GetTeamNum(particle.entity) == Entity.GetTeamNum(myHero) then return end

    for i, enemyAbility in ipairs(AbilityAlert2.teamSpecific) do
        if particle.name == enemyAbility.name then
            local newAlert = {
                index = particle.index,
                name = enemyAbility.name,
                msg = enemyAbility.msg,
                endTime = os.clock() + enemyAbility.duration,
                shortName = enemyAbility.shortName
            }

            if not enemyAbility.unique then
                table.insert(AbilityAlert2.alerts, newAlert)
                
                return true
            else 
                -- Look for an existing alert.
                for k, alert in ipairs(AbilityAlert2.alerts) do
                    if alert.msg == newAlert.msg then
                        alert.endTime = newAlert.endTime -- Just extend the existing time.

                        return true
                    end
                end

                -- Insert the new alert.
                table.insert(AbilityAlert2.alerts, newAlert)

                return true
            end
        end
    end

    return false
end

--
-- Callbacks
--
function AbilityAlert2.OnParticleCreate(particle)
    Log.Write(particle.name .. ",=")
    if not Menu.IsEnabled(AbilityAlert2.option) then return end

    if not AbilityAlert2.InsertAmbiguous(particle) then
        AbilityAlert2.InsertTeamSpecific(particle)
    end
end

function AbilityAlert2.OnParticleUpdate(particle)
    Log.Write("position"..particle.position:__tostring())
    if particle.controlPoint ~= 0 then return end
    for k, alert in ipairs(AbilityAlert2.alerts) do
        if particle.index == alert.index then
            alert.position = particle.position
        end
    end
end

function AbilityAlert2.OnParticleUpdateEntity(particle)
    --Log.Write("position"..particle.position:__tostring())
    for k, alert in ipairs(AbilityAlert2.alerts) do
        if particle.index == alert.index then
            alert.position = particle.position
        end
    end
end 

function AbilityAlert2.OnDraw()
    for i, alert in ipairs(AbilityAlert2.alerts) do
        local timeLeft = alert.endTime - os.clock()

        if timeLeft < 0 then
            table.remove(AbilityAlert2.alerts, i)
        else
            -- Fade out the last 5 seconds of the alert.
            local alpha = 255 * math.min(timeLeft / 5, 1)

            -- Some really obnoxious color to grab your attention.
            Renderer.SetDrawColor(255, 0, 255, math.floor(alpha))

            local w, h = Renderer.GetScreenSize()

            Renderer.DrawTextCentered(AbilityAlert2.font, w / 2, h / 2 + (i - 1) * 22, alert.msg, 1)

            if alert.position then 
                local x, y, onScreen = Renderer.WorldToScreen(alert.position)

                if onScreen then
                    if alert.enemy then
                        AbilityAlert2.DrawMiniHero(x, y, alert.enemy)
                    else  
                        Renderer.DrawTextCentered(AbilityAlert2.mapFont, x, y, alert.name, 1)
                    end 
                    --Renderer.DrawFilledRect(x - 5, y - 5, 10, 10)
                end
                if alert.enemy then
                    AbilityAlert2.drawMiniHeroOnMap(alert.position:GetX(), alert.position:GetY(),alert.enemy)
                else
                    AbilityAlert2.drawPosition(alert.position, alert.shortName)
                end 
            end
        end
    end
end

function AbilityAlert2.DrawMiniHero(x, y, heroName)
    local shortName =   string.sub (heroName, string.len("npc_dota_hero_")-string.len(heroName))
    local imageHandle = AbilityAlert2.cachedIcons[shortName]

    if imageHandle == nil then
        imageHandle = Renderer.LoadImage(AbilityAlert2.miniHero .. shortName .. ".png")
        AbilityAlert2.cachedIcons[shortName] = imageHandle
    end
    local imageColor = { 255, 255, 255 }
    Renderer.SetDrawColor(imageColor[1], imageColor[2], imageColor[3], 255)
    local size = Menu.GetValue(AbilityAlert2.boxSizeOption)
    Renderer.DrawImage(imageHandle, x-math.floor(size/2), y-math.floor(size/2), size, size)
end
-- function AbilityAlert2.OnEntityCreate(ent)
--     Log.Write(NPC.GetAbsOrigin(ent):__tostring())
-- end 

-- function AbilityAlert2.OnUnitAnimation(animation)

--     Log.Write(NPC.GetAbsOrigin(animation.unit):__tostring())
-- end 

function AbilityAlert2.drawMiniHeroOnMap(x,y,enemyName)
    if not enemyName then return end
    local w, h = Renderer.GetScreenSize()
    local x0 =AbilityAlert2.mapOrigin['x']
    local y0 =AbilityAlert2.mapOrigin['y']

    local ratio = 14000/300

    local ratioOffset = Menu.GetValue(AbilityAlert2.ratioOffset)
    local xOffset = Menu.GetValue(AbilityAlert2.xOffset)
    local yOffset = Menu.GetValue(AbilityAlert2.yOffset)

    local newX = math.floor((x -x0)/(ratio+ratioOffset/10))
    local newY = math.floor((y -y0)/(ratio+ratioOffset/10))

    local shortName =   string.sub (enemyName, string.len("npc_dota_hero_")-string.len(enemyName))
    local imageHandle = AbilityAlert2.cachedIcons[shortName]

    if imageHandle == nil then
        imageHandle = Renderer.LoadImage(AbilityAlert2.miniHero .. shortName .. ".png")
        AbilityAlert2.cachedIcons[shortName] = imageHandle
    end
    local imageColor = { 255, 255, 255 }
    Renderer.SetDrawColor(imageColor[1], imageColor[2], imageColor[3], 255)
    local size = Menu.GetValue(AbilityAlert2.miniBoxSizeOption)

    Renderer.DrawImage(imageHandle, 15+newX-math.floor(size/2)+xOffset, (h-315-newY-math.floor(size/2)-yOffset), size , size)
end

function AbilityAlert2.drawPosition(pos,enemyName)
    if not enemyName then return end
    local w, h = Renderer.GetScreenSize()
    local x0 =AbilityAlert2.mapOrigin['x']
    local y0 =AbilityAlert2.mapOrigin['y']

    local ratio = 14000/300

    local ratioOffset = Menu.GetValue(AbilityAlert2.ratioOffset)
    local xOffset = Menu.GetValue(AbilityAlert2.xOffset)
    local yOffset = Menu.GetValue(AbilityAlert2.yOffset)

    local x = pos:GetX()
    local y = pos:GetY()

    local newX = math.floor((x -x0)/(ratio+ratioOffset/10))
    local newY = math.floor((y -y0)/(ratio+ratioOffset/10))
    --Log.Write('x'..newX)
    --Log.Write('y'..newY)
    Renderer.SetDrawColor(0, 255, 127)
    Renderer.DrawTextCentered(AbilityAlert2.mapFont, 15+newX +xOffset , (h-315-newY-yOffset) , enemyName, 1)
end
return AbilityAlert2
