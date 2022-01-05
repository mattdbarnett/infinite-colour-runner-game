extends Node

#--Temp Vars

var firstload = true
var globalgrav = 40;
var gamemode;
var noMoney = false;
var noScore = false;

var customData = {
	"redvalue": 0,
	"bluevalue": 0,
	"purplevalue": 0,
	"greenvalue": 0,
	"yellowvalue": 0,
	"pinkvalue": 0,
	"speedvalue": 100,
	"gravityvalue": 100
}

var save_dict

#--Locally Saved Vars

var firstrun = true;
var holdmode = false;
var spdgravInfo = false;
var fpsInfo = false;
var moveInfo = false;
var statusInfo = false;
var vsync = true;
var currency = 0;
var highscore = 0;
var currentTrail = "none" #none/ghost/snake/smoke/flames/rainbow

var trailsBought = {
	"none": true,
	"ghost": false,
	"snake": false,
	"smoke": false,
	"flames": false,
	"rainbow": false
}

var currentBg = "plain" #plain/fade/disco

var bgsUnlocked = {
	"plain": true,
	"fade": false,
	"disco": false
}

# Called when the node enters the scene tree for the first time.
func _ready():
	LoadGame()

# - - Getters and Setters

# - Temp Vars

func GetFirstload():
	return firstload

func SetFirstload(input):
	firstload = input

func GetGlobalgrav():
	return globalgrav

func SetGlobalgrav(input):
	globalgrav = input

func GetGamemode():
	return gamemode

func SetGamemode(input):
	gamemode = input

func GetNoMoney():
	return noMoney

func SetNoMoney(input):
	noMoney = input

func GetNoScore():
	return noScore

func SetNoScore(input):
	noScore = input

func GetCustomData():
	return customData

func SetCustomData(input):
	customData = input

# - Saved Vars

func GetFirstrun():
	return firstrun

func SetFirstrun(input):
	firstrun = input

func GetHoldmode():
	return holdmode

func SetHoldmode(input):
	holdmode = input

func GetSpdGravInfo():
	return spdgravInfo

func SetSpdGravInfo(input):
	spdgravInfo = input

func GetFpsInfo():
	return fpsInfo

func SetFpsInfo(input):
	fpsInfo = input

func GetMoveInfo():
	return moveInfo

func SetMoveInfo(input):
	moveInfo = input

func GetStatusInfo():
	return statusInfo

func SetStatusInfo(input):
	statusInfo = input

func GetVSync():
	return vsync

func SetVSync(input):
	vsync = input

func GetCurrency():
	return currency

func SetCurrency(input):
	currency = input

func GetHighscore():
	return highscore

func SetHighscore(input):
	highscore = input

func GetCurrentTrail():
	return currentTrail

func SetCurrentTrail(input):
	currentTrail = input

func GetTrailsBought():
	return trailsBought

func SetTrailsBought(input):
	trailsBought = input

func GetCurrentBg():
	return currentBg

func SetCurrentBg(input):
	currentBg = input

func GetBgsUnlocked():
	return bgsUnlocked

func SetBgsUnlocked(input):
	bgsUnlocked = input

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func Fullscreen():
	OS.window_fullscreen = !OS.window_fullscreen

func BuyTrail(trail, price):
	if trailsBought[trail] == true:
		currentTrail = trail
	elif currency >= price:
		currency -= price
		trailsBought[trail] = true
		currentTrail = trail
	else:
		noMoney = true

func UnlockBg(bg, neededscore):
	if bgsUnlocked[bg] == true:
		currentBg = bg
	elif highscore >= neededscore:
		bgsUnlocked[bg] = true
		currentBg = bg
	else:
		noScore = true

func Save():
	save_dict = {
		#Flags
		"firstrun" : firstrun,
		
		#Settings
		"holdmode" : holdmode,
		"vsync" : vsync,
		"spdgravInfo" : spdgravInfo,
		"fpsInfo" : fpsInfo,
		"moveInfo" : moveInfo,
		"statusInfo" : statusInfo,

		#Records
		"currency" : currency,
		"highscore" : highscore,
		
		#Purchases
		"currentTrail" : currentTrail,
		"currentBg" : currentBg,
		"trailsBought-none" : true,
		"trailsBought-ghost" : trailsBought["ghost"],
		"trailsBought-snake" : trailsBought["snake"],
		"trailsBought-smoke" : trailsBought["smoke"],
		"trailsBought-flames" : trailsBought["flames"],
		"trailsBought-rainbow" : trailsBought["rainbow"],
		"bgsUnlocked-plain" : true,
		"bgsUnlocked-fade" : bgsUnlocked["fade"],
		"bgsUnlocked-disco" : bgsUnlocked["disco"],
	}
	return save_dict

func SaveGame():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	save_dict = Save()
	for i in save_dict.keys():
		#save_game.store_line(to_json(i))
		save_game.store_line(to_json(save_dict[i]))
	save_game.close()

func LoadGame():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return
	
	save_game.open("user://savegame.save", File.READ)
	Save()
	for i in save_dict.keys():
		var data = parse_json(save_game.get_line())
		save_dict[i] = data
	
	#Flag Vars
	firstrun = save_dict["firstrun"]
	
	#Settings Vars
	holdmode = save_dict["holdmode"]
	vsync = save_dict["vsync"]
	OS.set_use_vsync(vsync)
	spdgravInfo = save_dict["spdgravInfo"]
	fpsInfo = save_dict["fpsInfo"]
	moveInfo = save_dict["moveInfo"]
	statusInfo = save_dict["statusInfo"]
	
	#Record Vars
	currency = save_dict["currency"]
	highscore = save_dict["highscore"]
	
	#Purchase Vars
	currentTrail = save_dict["currentTrail"]
	currentBg = save_dict["currentBg"]
	
	for i in trailsBought.keys():
		trailsBought[i] = save_dict["trailsBought-" + i]
	
	for i in bgsUnlocked.keys():
		bgsUnlocked[i] = save_dict["bgsUnlocked-" + i]
	
	save_game.close()
