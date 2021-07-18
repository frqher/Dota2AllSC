DotaQuizDB = {}
DotaQuizDB.Version = 1

DotaQuizDB.Questions = {}
DotaQuizDB.Questions["english"] = {}
DotaQuizDB.Questions["russian"] = {}
DotaQuizDB.Questions["chinese"] = {}

table.insert(DotaQuizDB.Questions["english"], {
	["q"] = "When does the first night start?",
	["a"] = {
		[1] = "At minute 4:00",
		[2] = "At minute 5:00",
		[3] = "At minute 6:00",
		[4] = "At minute 10:00"
	},
	["r"] = 1
})

table.insert(DotaQuizDB.Questions["english"], {
	["q"] = "How many melee and ranged creeps spawn in the first wave, for only one lane?\r\nNot counting the enemy creeps in that lane!",
	["a"] = {
		[1] = "4 melee creeps, 1 ranged creep",
		[2] = "3 melee creeps, 1 ranged creep",
		[3] = "4 melee creeps, 2 ranged creep",
		[4] = "3 melee creeps, 2 ranged creep"
	},
	["r"] = 2
})

table.insert(DotaQuizDB.Questions["english"], {
	["q"] = "How many neutral camps are in the Radiant jungle, not counting the Ancients?",
	["a"] = {
		[1] = "1 small camp, 2 medium camps and 2 large camps",
		[2] = "2 small camps, 2 medium camps and 1 large camp",
		[3] = "2 small camps, 2 medium camps and 2 large camp",
		[4] = "1 small camps, 3 medium camps and 2 large camp"
	},
	["r"] = 1
})

table.insert(DotaQuizDB.Questions["english"], {
	["q"] = "Pick one set of the neutral creeps that can't spawn in the medium camp",
	["a"] = {
		[1] = "Centaur camp",
		[2] = "Mud Golems",
		[3] = "Hellbear camp",
		[4] = "Wolf camp"
	},
	["r"] = 3
})

table.insert(DotaQuizDB.Questions["english"], {
	["q"] = "At the start of the game, only Bounty runes can spawn.",
	["a"] = {
		[1] = "True",
		[2] = "False"
	},
	["r"] = 1
})

table.insert(DotaQuizDB.Questions["english"], {
	["q"] = "Once placed, Observer Ward will last for how long?",
	["a"] = {
		[1] = "8 minutes",
		[2] = "6 minutes",
		[3] = "7 minutes",
		[4] = "5 minutes"
	},
	["r"] = 3
})

table.insert(DotaQuizDB.Questions["english"], {
	["q"] = "You can reveal the Wards (Observer and Sentry Wards) with Dust.",
	["a"] = {
		[1] = "True",
		[2] = "False"
	},
	["r"] = 2
})

table.insert(DotaQuizDB.Questions["english"], {
	["q"] = "When can you upgrade the Courier?",
	["a"] = {
		[1] = "At minute 2:00",
		[2] = "At minute 3:00",
		[3] = "At minute 4:00",
		[4] = "At the start of the game"
	},
	["r"] = 2
})

table.insert(DotaQuizDB.Questions["english"], {
	["q"] = "If you deny your lane creep, the enemy Hero in the range gets less experience from it",
	["a"] = {
		[1] = "True",
		[2] = "False"
	},
	["r"] = 1
})

table.insert(DotaQuizDB.Questions["english"], {
	["q"] = "What is the correct amount of experience a Hero has to gain to advance from Level 1 to Level 2?",
	["a"] = {
		[1] = "200",
		[2] = "400",
		[3] = "600",
		[4] = "800"
	},
	["r"] = 1
})

table.insert(DotaQuizDB.Questions["english"], {
	["q"] = "Destroying a Tier 1 Tower refreshes the Glyph of Fortification.",
	["a"] = {
		[1] = "True",
		[2] = "False"
	},
	["r"] = 1
})

table.insert(DotaQuizDB.Questions["english"], {
	["q"] = "First Roshan spawns with how much HP?",
	["a"] = {
		[1] = "2500",
		[2] = "5000",
		[3] = "7500",
		[4] = "10000"
	},
	["r"] = 3
})

table.insert(DotaQuizDB.Questions["english"], {
	["q"] = "Double Damage rune only increases your base damage.",
	["a"] = {
		[1] = "True",
		[2] = "False"
	},
	["r"] = 1
})

table.insert(DotaQuizDB.Questions["english"], {
	["q"] = "Once you activate a Haste rune, your movement speed is set to - ?",
	["a"] = {
		[1] = "550",
		[2] = "522",
		[3] = "322",
		[4] = "650"
	},
	["r"] = 2
})

function DotaQuizDB.LoadDB()
    return DotaQuizDB.Questions
end

return DotaQuizDB