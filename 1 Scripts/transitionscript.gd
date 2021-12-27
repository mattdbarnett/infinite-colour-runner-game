extends Node

onready var rect = get_node("ColorRect")
onready var player = get_node("ColorRect/AnimationPlayer")
var currentIn;
var currentOut;
var currentMenu;
var transitionedOut = false
var menu = load("res://1 Scripts/menuscript.gd")

var shaderMat = load("res://4 Styling/8 Shaders/transition.tres")
const transition1 = preload("res://2 Sprites/1 Transitions/transition1.png")
const transition2 = preload("res://2 Sprites/1 Transitions/transition2.png")
const transition3 = preload("res://2 Sprites/1 Transitions/transition3.png")
const transition4 = preload("res://2 Sprites/1 Transitions/transition4.png")
var transitionArray = [transition1, transition2, transition3, transition4]
var usedTransitions = []
var currentTransition

# Called when the node enters the scene tree for the first time.
func _ready():
	rect.visible = false

func changeMask():
	currentTransition = transitionArray[randi() % transitionArray.size()]
	transitionArray.erase(currentTransition)
	usedTransitions.append(currentTransition)
	shaderMat.set_shader_param("mask", currentTransition)

func play(transitionIn, transitionOut, menu):
	rect.visible = true
	currentIn = transitionIn
	currentOut = transitionOut
	currentMenu = menu
	changeMask()
	player.play(transitionOut)

func transitionIn(mode):
	rect.visible = true
	changeMask()
	currentIn = mode
	player.play("transition_in")

func transitionOut(mode, menu):
	rect.visible = true
	changeMask()
	currentIn = mode
	currentMenu = menu
	player.play("transition_out")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == currentOut:
		transitionedOut = true
		changeMask()
		transitionArray += usedTransitions
		usedTransitions.clear()
		player.play(currentIn)
	elif anim_name == currentIn:
		transitionedOut = false
		rect.visible = false
	elif currentIn == "1Way":
		transitionArray += usedTransitions
		usedTransitions.clear()
		rect.visible = false
	
	shaderMat.set_shader_param("smooth_size", 0.001)
