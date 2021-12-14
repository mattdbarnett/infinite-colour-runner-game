extends Node

var globalgrav = 40;
var gamemode;
var holdmode;
var currency = 0;
var highscore = 0;

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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func fullscreen():
	OS.window_fullscreen = !OS.window_fullscreen
