extends Node

onready var rect = get_node("ColorRect")
onready var player = get_node("ColorRect/AnimationPlayer")
var currentIn;
var currentOut;
var currentMenu;
var transitionedOut = false
var menu = load("res://1 Scripts/menuscript.gd")


# Called when the node enters the scene tree for the first time.
func _ready():
	rect.visible = false

func startIn():
	$AnimationPlayer.play("transition_in")

func startOut():
	$AnimationPlayer.play("transition_out")

func play(transitionIn, transitionOut, menu):
	rect.visible = true
	currentIn = transitionIn
	currentOut = transitionOut
	currentMenu = menu
	player.play(transitionOut)


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == currentOut:
		transitionedOut = true
		player.play(currentIn)
	elif anim_name == currentIn:
		transitionedOut = false
		rect.visible = false
