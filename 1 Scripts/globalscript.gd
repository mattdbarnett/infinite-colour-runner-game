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
	load_game()

# - - Getters and Setters

# - Temp Vars

func getFirstload():
	return firstload

func setFirstload(input):
	firstload = input

func getGlobalgrav():
	return globalgrav

func setGlobalgrav(input):
	globalgrav = input

func getGamemode():
	return gamemode

func setGamemode(input):
	gamemode = input

func getNoMoney():
	return noMoney

func setNoMoney(input):
	noMoney = input

func getNoScore():
	return noScore

func setNoScore(input):
	noScore = input

func getCustomData():
	return customData

func setCustomData(input):
	customData = input

# - Saved Vars

func getFirstrun():
	return firstrun

func setFirstrun(input):
	firstrun = input

func getHoldmode():
	return holdmode

func setHoldmode(input):
	holdmode = input

func getSpdGravInfo():
	return spdgravInfo

func setSpdGravInfo(input):
	spdgravInfo = input

func getFpsInfo():
	return fpsInfo

func setFpsInfo(input):
	fpsInfo = input

func getMoveInfo():
	return moveInfo

func setMoveInfo(input):
	moveInfo = input

func getStatusInfo():
	return statusInfo

func setStatusInfo(input):
	statusInfo = input

func getVSync():
	return vsync

func setVSync(input):
	vsync = input

func getCurrency():
	return currency

func setCurrency(input):
	currency = input

func getHighscore():
	return highscore

func setHighscore(input):
	highscore = input

func getCurrentTrail():
	return currentTrail

func setCurrentTrail(input):
	currentTrail = input

func getTrailsBought():
	return trailsBought

func setTrailsBought(input):
	trailsBought = input

func getCurrentBg():
	return currentBg

func setCurrentBg(input):
	currentBg = input

func getBgsUnlocked():
	return bgsUnlocked

func setBgsUnlocked(input):
	bgsUnlocked = input

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func fullscreen():
	OS.window_fullscreen = !OS.window_fullscreen

func buyTrail(trail, price):
	if trailsBought[trail] == true:
		currentTrail = trail
	elif currency >= price:
		currency -= price
		trailsBought[trail] = true
		currentTrail = trail
	else:
		noMoney = true

func unlockBg(bg, neededscore):
	if bgsUnlocked[bg] == true:
		currentBg = bg
	elif highscore >= neededscore:
		bgsUnlocked[bg] = true
		currentBg = bg
	else:
		noScore = true

func save():
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

func save_game():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	save_dict = save()
	for i in save_dict.keys():
		#save_game.store_line(to_json(i))
		save_game.store_line(to_json(save_dict[i]))
	save_game.close()

func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return
	
	save_game.open("user://savegame.save", File.READ)
	save()
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
