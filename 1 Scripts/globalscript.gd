extends Node

var globalgrav = 40;
var gamemode;
var holdmode;
var currency = 0;
var highscore = 0;
var currentTrail = "none" #none/ghost/snake/smoke/flames/rainbowv
var noMoney = false;

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

var trailsBought = {
	"ghost": false,
	"snake": false,
	"smoke": false,
	"flames": false,
	"rainbow": false
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
