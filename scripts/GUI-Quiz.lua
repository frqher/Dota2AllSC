local DotaQuiz = {}
DotaQuiz.Identity = "dota_quiz"
DotaQuiz.Locale = {
	["name"] = {
		["english"] = "Dota Quiz",
		["russian"] = "Викторина",
		["chinese"] = "测验",
	},
	["desc"] = {
		["english"] = "Quiz #1 in Dota 2",
		["russian"] = "Викторина #1 в Dota 2",
		["chinese"] = "Dota 2中的测验＃1"
	},
	["delay_before_quiz_load"] = {
		["english"] = "Delay before quiz load",
		["russian"] = "Задержка перед загрузкой викторины",
		["chinese"] = "下载测验之前延迟"
	},
	["delay_before_quiz_start"] = {
		["english"] = "Delay before quiz start",
		["russian"] = "Задержка перед началом викторины",
		["chinese"] = "在测验开始之前延迟"
	},
	["message_delay"] = {
		["english"] = "Delay in message send (ms)",
		["russian"] = "Задержка при отправке сообщений (мс)",
		["chinese"] = "延迟发送消息"
	},
	["repeat_delay"] = {
		["english"] = "Delay before question repeated",
		["russian"] = "Задержка перед повторением вопроса",
		["chinese"] = "延迟问题重复"
	},
	["delay_before_new_question"] = {
		["english"] = "Delay before a new question",
		["russian"] = "Задержка перед новым вопросом",
		["chinese"] = "在一个新问题之前延迟"
	},
	
	--
	["welcome"] = {
		["english"] = "Welcome to Dota 2 Quiz.",
		["russian"] = "Добро пожаловать в виктору Dota 2",
		["chinese"] = "欢迎来到维克多·达塔2"
	},
	["willstart"] = {
		["english"] = "Quiz will start in ",
		["russian"] = "Викторина начнётся через ",
		["chinese"] = "维克多开始了 "
	},
	["second"] = {
		["english"] = " second.",
		["russian"] = " секунд.",
		["chinese"] = " 秒。"
	},
	["repeat"] = {
		["english"] = "Repeat question:",
		["russian"] = "Повтор вопроса:",
		["chinese"] = "重复这个问题："
	},
	["inthelead"] = {
		["english"] = "In the lead: ",
		["russian"] = "Лидирует: ",
		["chinese"] = "领先："
	},
	["stat"] = {
		["english"] = "Quiz stat:",
		["russian"] = "Статистика викторины:",
		["chinese"] = "测验统计："
	},
	["qend"] = {
		["english"] = "Our quiz has ended. Winner is: ",
		["russian"] = "Викторина закончилась. Победитель: ",
		["chinese"] = "测验结束了。赢家："
	},
	["qend"] = {
		["english"] = "Our quiz has ended. Winner is: ",
		["russian"] = "Викторина закончилась. Победитель: ",
		["chinese"] = "测验结束了。赢家："
	},
	["next"] = {
		["english"] = "Next question in ",
		["russian"] = "Следующий вопрос через: ",
		["chinese"] = "下一个问题是： "
	},
	["correct"] = {
		["english"] = "Correctly answered '",
		["russian"] = "Правильно ответил '",
		["chinese"] = "正确回答 '"
	},
	["score"] = {
		["english"] = "' he got +1 score",
		["russian"] = "' и получает +1 балл",
		["chinese"] = "' 并获得+1点“"
	},
	["commands"] = {
		["english"] = "The list of available commands can be viewed by entering in the chat 'dq!help'.",
		["russian"] = "Список доступных команд можно посмотреть введя в чат 'dq!help'.",
		["chinese"] = "可以通过输入聊天 “dq!help” 来查看可用命令的列表."
	},
	["helper"] = {
		["english"] = "dq!stat - for statistics\r\ndq!lead - to see whos leading now",
		["russian"] = "dq!stat - чтобы посмотреть статистику\r\ndq!lead - чтобы посмотреть кто сейчас побеждает",
		["chinese"] = "dq!stat - 查看统计信息\r\ndq!lead - 看看谁现在赢了"
	}
}

function DotaQuiz.OnDraw()
	if GUI == nil then return end
	if GUI.SelectedLanguage == nil then return end
	if not GUI.Exist(DotaQuiz.Identity) then
		local GUI_Object = {}
		GUI_Object["perfect_name"] = DotaQuiz.Locale["name"]
		GUI_Object["perfect_desc"] = DotaQuiz.Locale["desc"]
		GUI_Object["perfect_author"] = 'paroxysm'
		GUI_Object["category"] = GUI.Category.General
		GUI.Initialize(DotaQuiz.Identity, GUI_Object)

		GUI.AddMenuItem(DotaQuiz.Identity, DotaQuiz.Identity .. "delay_before_quiz_load", DotaQuiz.Locale["delay_before_quiz_load"], GUI.MenuType.Slider, 1, 360, 60)
		GUI.AddMenuItem(DotaQuiz.Identity, DotaQuiz.Identity .. "delay_before_quiz_start", DotaQuiz.Locale["delay_before_quiz_start"], GUI.MenuType.Slider, 1, 360, 60)
		GUI.AddMenuItem(DotaQuiz.Identity, DotaQuiz.Identity .. "message_delay", DotaQuiz.Locale["message_delay"], GUI.MenuType.Slider, 64, 2048, 256)
		GUI.AddMenuItem(DotaQuiz.Identity, DotaQuiz.Identity .. "repeat_delay", DotaQuiz.Locale["repeat_delay"], GUI.MenuType.Slider, 1, 120, 60)
		GUI.AddMenuItem(DotaQuiz.Identity, DotaQuiz.Identity .. "delay_before_new_question", DotaQuiz.Locale["delay_before_new_question"], GUI.MenuType.Slider, 1, 360, 60)
	end
end

DotaQuiz.CurrentQuestion = nil
DotaQuiz.GameQuestions = {}
DotaQuiz.Say = {}
DotaQuiz.Players = {}

function DotaQuiz.DoQuiz()
	if GUI.SelectedLanguage == nil then return end
	if not GUI.IsEnabled(DotaQuiz.Identity) then return end

	if DotaQuiz.CurrentQuestion == nil then
		if DotaQuiz.GameQuestions ~= nil and Length(DotaQuiz.GameQuestions) > 0 then
			DotaQuiz.CurrentQuestion = DotaQuiz.GameQuestions[1]
			table.remove(DotaQuiz.GameQuestions, 1)
			DotaQuiz.CurrentQuestion["c"] = os.clock()
			local temp_ans = DotaQuiz.CurrentQuestion["a"][DotaQuiz.CurrentQuestion["r"]]
			DotaQuiz.Shake(DotaQuiz.CurrentQuestion["a"])
			
			local i = 1
			for _, v in pairs(DotaQuiz.CurrentQuestion["a"]) do
				if temp_ans == v then
					DotaQuiz.CurrentQuestion["r"] = i
				end
				i = i + 1
			end
			DotaQuiz.SayQuestion()
		end
	end
end

DotaQuiz.Runing = false
DotaQuiz.GameStart = false

function DotaQuiz.SayQuestion()
	if not GUI.IsEnabled(DotaQuiz.Identity) then return end
	local t = DotaQuiz.Explode("\r\n", DotaQuiz.CurrentQuestion["q"])
	for k, v in pairs(t) do 
		DotaQuiz.Write(v)
	end
	
	local i = 1
	for _, v in pairs(DotaQuiz.CurrentQuestion["a"]) do
		DotaQuiz.Write(i .. ") " .. v)
		i = i + 1
	end
end

function DotaQuiz.OnGameStart()
	DotaQuiz.Runing = true
end

function DotaQuiz.OnGameEnd()
	DotaQuiz.QuizEnd()
end

DotaQuiz.CurrentSay = ""

function DotaQuiz.Write(text)
	table.insert(DotaQuiz.Say, text)
end

function DotaQuiz.Talk()
	if Length(DotaQuiz.Say) > 0 then
		if DotaQuiz.CurrentSay == "" then
			Engine.ExecuteCommand("say " .. DotaQuiz.Say[1])
			DotaQuiz.CurrentSay = DotaQuiz.Say[1]
		else
			Engine.ExecuteCommand("say " .. DotaQuiz.CurrentSay)
		end
	end
end

function DotaQuiz.OnUpdate()
	if GUI.SelectedLanguage == nil then return end
	if not GUI.IsEnabled(DotaQuiz.Identity) then return end
	if DotaQuiz.Runing == true then 
		if GUI.SleepReady("game_start") then 
			if DotaQuiz.GameStart then
				DotaQuiz.Runing = false
				DotaQuiz.Write(DotaQuiz.Locale["welcome"][GUI.SelectedLanguage])
				DotaQuiz.Write(DotaQuiz.Locale["willstart"][GUI.SelectedLanguage] .. GUI.Get(DotaQuiz.Identity .. "delay_before_quiz_start") .. DotaQuiz.Locale["second"][GUI.SelectedLanguage])
				DotaQuiz.Write(DotaQuiz.Locale["commands"][GUI.SelectedLanguage])
				if Length(DotaQuizDB.Questions[GUI.SelectedLanguage]) == 0 then
					DotaQuiz.GameQuestions = DotaQuizDB.Questions["english"]
				else
					DotaQuiz.GameQuestions = DotaQuizDB.Questions[GUI.SelectedLanguage]
				end
				
				
				GUI.Write("DotaQuizDB -> " .. DotaQuizDB.Version)
				DotaQuiz.Shake(DotaQuiz.GameQuestions)
				GUI.Sleep("lets_quiz", tonumber(GUI.Get(DotaQuiz.Identity .. "delay_before_quiz_start")))
			else
				DotaQuiz.GameStart = true
				GUI.Sleep("game_start", tonumber(GUI.Get(DotaQuiz.Identity .. "delay_before_quiz_load")))
			end
		end
	end
	
	if DotaQuiz.CurrentQuestion == nil and GUI.SleepReady("lets_quiz") then 
		DotaQuiz.DoQuiz()
	end
	
	if GUI.SleepReady("lets_talk") then 
		DotaQuiz.Talk()
		GUI.Sleep("lets_talk", math.floor(tonumber(GUI.Get(DotaQuiz.Identity .. "message_delay")) / 1000))
	end
	
	if GUI.SleepReady("repeat_delay") then 
		if DotaQuiz.CurrentQuestion ~= nil 
			and DotaQuiz.CurrentQuestion["c"] ~= nil 
			and os.clock() > (DotaQuiz.CurrentQuestion["c"] + tonumber(GUI.Get(DotaQuiz.Identity .. "repeat_delay"))) 
		then
			DotaQuiz.Write(DotaQuiz.Locale["repeat"][GUI.SelectedLanguage])
			DotaQuiz.SayQuestion()
		end
		GUI.Sleep("repeat_delay", tonumber(GUI.Get(DotaQuiz.Identity .. "repeat_delay")))
	end
end

function DotaQuiz.OnSayText(textEvent)
	if not GUI.IsEnabled(DotaQuiz.Identity) then return end

	local who = textEvent.params[1]
	local what = textEvent.params[2]

	if what == DotaQuiz.CurrentSay then
		table.remove(DotaQuiz.Say, 1)
		DotaQuiz.CurrentSay = ""
		DotaQuiz.TimeToSay = 1
	else
		if DotaQuiz.CurrentQuestion ~= nil and what == tostring(DotaQuiz.CurrentQuestion["r"]) and who ~= nil then
			DotaQuiz.Write(DotaQuiz.Locale["correct"][GUI.SelectedLanguage] .. who .. DotaQuiz.Locale["score"][GUI.SelectedLanguage])
			if DotaQuiz.Players[who] == nil then
				DotaQuiz.Players[who] = 1
			else
				DotaQuiz.Players[who] = DotaQuiz.Players[who] + 1
			end
			DotaQuiz.CurrentQuestion = nil
			if Length(DotaQuiz.GameQuestions) > 0 then
				table.insert(DotaQuiz.Say, DotaQuiz.Locale["inthelead"][GUI.SelectedLanguage] .. DotaQuiz.GetWinner())
				table.insert(DotaQuiz.Say, DotaQuiz.Locale["next"][GUI.SelectedLanguage] .. GUI.Get(DotaQuiz.Identity .. "delay_before_new_question") .. DotaQuiz.Locale["second"][GUI.SelectedLanguage])
				GUI.Sleep("lets_quiz", tonumber(GUI.Get(DotaQuiz.Identity .. "delay_before_new_question")))
			else
				DotaQuiz.Write(DotaQuiz.Locale["qend"][GUI.SelectedLanguage] .. DotaQuiz.GetWinner())
			end
		end
	end

	if GUI.SleepReady("dq_stat") then 
		if what == "dq!stat" then
			DotaQuiz.Write(DotaQuiz.Locale["stat"][GUI.SelectedLanguage])
			DotaQuiz.DrawAll()
			GUI.Sleep("dq_stat", 10)
		return end
	end
	
	if GUI.SleepReady("dq_lead") then 
		if what == "dq!lead" then
			DotaQuiz.Write(DotaQuiz.Locale["inthelead"][GUI.SelectedLanguage] .. DotaQuiz.GetWinner())
			GUI.Sleep("dq_lead", 10)
		return end
	end
		
	if GUI.SleepReady("dq_help") then 
		if what == "dq!help" then
			local t = DotaQuiz.Explode("\r\n", DotaQuiz.Locale["helper"][GUI.SelectedLanguage])
			for k, v in pairs(t) do 
				DotaQuiz.Write(v)
			end
			GUI.Sleep("dq_help", 10)
		return end
	end
end

function DotaQuiz.QuizEnd()
	DotaQuiz.GameStart = false
	DotaQuiz.CurrentQuestion = nil
	DotaQuiz.Say = {}
	DotaQuiz.Players = {}
	DotaQuiz.GameQuestions = {}
	DotaQuiz.Runing = false
end

function DotaQuiz.DrawAll()
	for k, v in pairs(DotaQuiz.Players) do
		DotaQuiz.Write(k .. " >> " .. v)
	end
end

function DotaQuiz.GetWinner()
	local winner = ""
	local temp_score = 0
	
	for k, v in pairs(DotaQuiz.Players) do
		if v > temp_score then
			temp_score = v
			winner = k
		end
	end
	
	return winner
end

function DotaQuiz.RemoveKey(t, key)
	local new = {}
	for k, v in pairs(t) do
		if k ~= key then
			new[k] = v
		end
	end
	return new
end

function DotaQuiz.Explode(div, str)
  if (div=='') then return false end
  local pos,arr = 0,{}

  for st,sp in function() return string.find(str,div,pos,true) end do
	table.insert(arr,string.sub(str,pos,st-1))
	pos = sp + 1
  end
  
  table.insert(arr,string.sub(str,pos))
  return arr
end

function DotaQuiz.Swap(array, index1, index2)
  array[index1], array[index2] = array[index2], array[index1]
end

function DotaQuiz.Shake(array)
  local counter = #array

  while counter > 1 do
    local index = math.random(counter)

    DotaQuiz.Swap(array, index, counter)		
    counter = counter - 1
  end
end

return DotaQuiz