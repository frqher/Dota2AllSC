local ToxicFlame = {}
ToxicFlame.option = Menu.AddOption({ "Utility", "Toxic Flame" }, "Enable", "Flame all chat to enemy hero when they died.")
ToxicFlame.needsInit = true

ToxicFlame.englishPhrase = {
	"Что-то ты изи",
	"Соляра для меня",
	"Тебе нравится?",
	"НЫЫЫЫЫАААА",
	"Как жизнь братик?",
	"Тебе нравится?",
	"Как 2 пальца",
	"ʕʘ‿ಠʔ",
	"Как 2 пальца",
	"( ͡° ͜ʖ ͡°)",
	"vk.com/cheats_dota"
}

ToxicFlame.enemyData1 = {}
ToxicFlame.enemyData2 = {}
ToxicFlame.enemyData3 = {}
ToxicFlame.enemyData4 = {}
ToxicFlame.enemyData5 = {}

function ToxicFlame.InitVariable()
    local ourHero = Heroes.GetLocal()

    if not ourHero 
	then 
		return 
	end
	
	-- Check my I'm Radiant or Dire side
	local myTeamz  = Entity.GetTeamNum(Players.GetLocal())
	-- Declare local var to store enemy heroes index
	local foo = {}
	
	if myTeamz == 3 then --I'm Dire
		for i=1, Players.Count() 
		do
			if Entity.GetTeamNum(Players.Get(i)) == 2  then
				table.insert(foo, i)
			end
		end
	elseif myTeamz == 2 then --I'm Radiant
		for i=1, Players.Count() 
		do
			if Entity.GetTeamNum(Players.Get(i)) == 3  then
				table.insert(foo, i)
			end
		end
	end
	
	for i=1, 5
	do
		if i == 1 then
			ToxicFlame.enemyData1["id"] = foo[i]
			ToxicFlame.enemyData1["name"] = Player.GetName(Players.Get(foo[i]))
			ToxicFlame.enemyData1["executeMessage"] = false
			ToxicFlame.enemyData1["alive"] = true
		elseif i == 2 then
			ToxicFlame.enemyData2["id"] = foo[i]
			ToxicFlame.enemyData2["name"] = Player.GetName(Players.Get(foo[i]))
			ToxicFlame.enemyData2["executeMessage"] = false
			ToxicFlame.enemyData2["alive"] = true
		elseif i == 3 then
			ToxicFlame.enemyData3["id"] = foo[i]
			ToxicFlame.enemyData3["name"] = Player.GetName(Players.Get(foo[i]))
			ToxicFlame.enemyData3["executeMessage"] = false
			ToxicFlame.enemyData3["alive"] = true
		elseif i == 4 then
			ToxicFlame.enemyData4["id"] = foo[i]
			ToxicFlame.enemyData4["name"] = Player.GetName(Players.Get(foo[i]))
			ToxicFlame.enemyData4["executeMessage"] = false
			ToxicFlame.enemyData4["alive"] = true
		elseif i == 5 then
			ToxicFlame.enemyData5["id"] = foo[i]
			ToxicFlame.enemyData5["name"] = Player.GetName(Players.Get(foo[i]))
			ToxicFlame.enemyData5["executeMessage"] = false
			ToxicFlame.enemyData5["alive"] = true
		end
	end
end

function ToxicFlame.Reset()
    ToxicFlame.needsInit = true
    for k in pairs (ToxicFlame.enemyData1) do
		ToxicFlame.enemyData1[k] = nil
	end
	
	for k in pairs (ToxicFlame.enemyData2) do
		ToxicFlame.enemyData2[k] = nil
	end
	
	for k in pairs (ToxicFlame.enemyData3) do
		ToxicFlame.enemyData3[k] = nil
	end
	
	for k in pairs (ToxicFlame.enemyData4) do
		ToxicFlame.enemyData4[k] = nil
	end
	
	for k in pairs (ToxicFlame.enemyData5) do
		ToxicFlame.enemyData5[k] = nil
	end
end

function ToxicFlame.OnUpdate()
	if not Engine.IsInGame() then ToxicFlame.Reset() end
	if not Menu.IsEnabled(ToxicFlame.option) then return end
	local myHero = Heroes.GetLocal()

    if not myHero then return end
	
	if ToxicFlame.needsInit then
        ToxicFlame.InitVariable()
        ToxicFlame.needsInit = false
    end
	
	--Updating state hero alive or death
	-- Check my I'm Radiant or Dire side
	local myTeamFaction  = Entity.GetTeamNum(Players.GetLocal())
	-- Declare local var to store enemy heroes index
	local foobar = {}
	
	if myTeamFaction == 3 then --I'm Dire
		for i=1, Players.Count() 
		do
			if Entity.GetTeamNum(Players.Get(i)) == 2  then
				table.insert(foobar, i)
			end
		end
	elseif myTeamFaction == 2 then --I'm Radiant
		for i=1, Players.Count() 
		do
			if Entity.GetTeamNum(Players.Get(i)) == 3  then
				table.insert(foobar, i)
			end
		end
	end
	
	for i=1, 5
	do
		if i == 1 then
			if Player.GetTeamData(Players.Get(foobar[i])).respawnTime ~= -1 then --Enemy death
				ToxicFlame.enemyData1["alive"] = false
			elseif Player.GetTeamData(Players.Get(foobar[i])).respawnTime < 0 then --Enemy alive
				ToxicFlame.enemyData1["alive"] = true
				ToxicFlame.enemyData1["executeMessage"] = false
			end
		elseif i == 2 then
			if Player.GetTeamData(Players.Get(foobar[i])).respawnTime ~= -1 then --Enemy death
				ToxicFlame.enemyData2["alive"] = false
			elseif Player.GetTeamData(Players.Get(foobar[i])).respawnTime < 0 then --Enemy alive
				ToxicFlame.enemyData2["alive"] = true
				ToxicFlame.enemyData2["executeMessage"] = false
			end
		elseif i == 3 then
			if Player.GetTeamData(Players.Get(foobar[i])).respawnTime ~= -1 then --Enemy death
				ToxicFlame.enemyData3["alive"] = false
			elseif Player.GetTeamData(Players.Get(foobar[i])).respawnTime < 0 then --Enemy alive
				ToxicFlame.enemyData3["alive"] = true
				ToxicFlame.enemyData3["executeMessage"] = false
			end
		elseif i == 4 then
			if Player.GetTeamData(Players.Get(foobar[i])).respawnTime ~= -1 then --Enemy death
				ToxicFlame.enemyData4["alive"] = false
			elseif Player.GetTeamData(Players.Get(foobar[i])).respawnTime < 0 then --Enemy alive
				ToxicFlame.enemyData4["alive"] = true
				ToxicFlame.enemyData4["executeMessage"] = false
			end
		elseif i == 5 then
			if Player.GetTeamData(Players.Get(foobar[i])).respawnTime ~= -1 then --Enemy death
				ToxicFlame.enemyData5["alive"] = false
			elseif Player.GetTeamData(Players.Get(foobar[i])).respawnTime < 0 then --Enemy alive
				ToxicFlame.enemyData5["alive"] = true
				ToxicFlame.enemyData5["executeMessage"] = false
			end
		end
	end
	
	-- Execute Flame Message
	if not ToxicFlame.enemyData1["alive"] then
		if not ToxicFlame.enemyData1["executeMessage"] then
			Chat.Say("DOTAChannelType_GameAll", 
			ToxicFlame.enemyData1["name"] .. " " ..
			ToxicFlame.englishPhrase[ math.random( #ToxicFlame.englishPhrase ) ] 
			)
			ToxicFlame.enemyData1["executeMessage"] = true
		end
	end
	
	if not ToxicFlame.enemyData2["alive"] then
		if not ToxicFlame.enemyData2["executeMessage"] then
			Chat.Say("DOTAChannelType_GameAll", 
			ToxicFlame.enemyData2["name"] .. " " ..
			ToxicFlame.englishPhrase[ math.random( #ToxicFlame.englishPhrase ) ] 
			)
			ToxicFlame.enemyData2["executeMessage"] = true
		end
	end
	
	if not ToxicFlame.enemyData3["alive"] then
		if not ToxicFlame.enemyData3["executeMessage"] then
			Chat.Say("DOTAChannelType_GameAll", 
			ToxicFlame.enemyData3["name"] .. " " ..
			ToxicFlame.englishPhrase[ math.random( #ToxicFlame.englishPhrase ) ] 
			)
			ToxicFlame.enemyData3["executeMessage"] = true
		end
	end
	
	if not ToxicFlame.enemyData4["alive"] then
		if not ToxicFlame.enemyData4["executeMessage"] then
			Chat.Say("DOTAChannelType_GameAll", 
			ToxicFlame.enemyData4["name"] .. " " ..
			ToxicFlame.englishPhrase[ math.random( #ToxicFlame.englishPhrase ) ] 
			)
			ToxicFlame.enemyData4["executeMessage"] = true
		end
	end
	
	if not ToxicFlame.enemyData5["alive"] then
		if not ToxicFlame.enemyData5["executeMessage"] then
			Chat.Say("DOTAChannelType_GameAll", 
			ToxicFlame.enemyData5["name"] .. " " ..
			ToxicFlame.englishPhrase[ math.random( #ToxicFlame.englishPhrase ) ] 
			)
			ToxicFlame.enemyData5["executeMessage"] = true
		end
	end
	--Log.Write(Player.GetTeamData(Players.GetLocal()).respawnTime)
end



return ToxicFlame