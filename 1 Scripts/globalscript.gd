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

#--Locally Saved Vars

var holdmode;
var spdgravInfo = false;
var fpsInfo = false;
var moveInfo = false;
var currency = 1025;
var highscore = 500;
var currentTrail = "none" #none/ghost/snake/smoke/flames/rainbow

var trailsBought = {
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
	pass # Replace with function body.


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
