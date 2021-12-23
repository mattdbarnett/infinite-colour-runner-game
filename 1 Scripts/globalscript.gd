extends Node

#--Temp Vars

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
	var save_dict = save()
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
	
	#Settings Vars
	holdmode = save_dict["holdmode"]
	vsync = save_dict["vsync"]
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
