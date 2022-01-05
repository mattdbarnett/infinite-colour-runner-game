"""
- - - - - - - - - - - - - - -
 Title: Transition Class Script
 Author: Matt Barnett
 Created: 26/12/2021
- - - - - - - - - - - - - - -

 Desc:
	Script for the transition class, used for transitioning between different 
	scenes and menus within the application where instanced. Allows for the 
	input of any newly created transitions when it's functions are called.
	
 Function Documentation:
	changeMask():
		Chooses a new, different animation mask for the next transition. This
		adds variety in style when moving between menus - no same mask will be
		used for both for a transition-in and transition-out.
	
	play(transitionIn, transitionOut, menu):
		Ran when instanced in the menu scene - transitions out of the current
		menu then transitions back into the new, inputted menu.
	
	transitionIn(transition, mode):
		Runs only a transition to enter a scene. Mode denotes specific
		circumstances that accounted for when transition ends.
	
	transitionOut(transition, mode):
		Runs only a transition to leave a scene. Mode denotes specific
		circumstances that accounted for when transition ends.
	
	resetSmooth():
		When a fade-in/out transition is used, smoothness is set to 1. If
		other transitions are ran with smoothness of 1, they become just
		fades. Reseting smoothness allows for other transitions to be used.
	
	(All other functions are in-built node functions and are not called on
	externally on the class)
"""

extends Node

onready var rect = get_node("ColorRect")
onready var player = get_node("ColorRect/AnimationPlayer")

#'Current' variables are inputted via function for use when transitions finish
var currentIn;
var currentOut;
var currentMode;
var currentMenu;

var transitionedOut = false #true when screen is black between transitions

var animationPlaying = false 

var shaderMat = load("res://4 Styling/8 Shaders/transition.tres")
const transition1 = preload("res://2 Sprites/1 Transitions/transition1.png")
const transition2 = preload("res://2 Sprites/1 Transitions/transition2.png")
const transition3 = preload("res://2 Sprites/1 Transitions/transition3.png")
const transition4 = preload("res://2 Sprites/1 Transitions/transition4.png")
var transitionArray = [transition1, transition2, transition3, transition4]
var usedTransitions = []
var currentTransition

# Pre-Built Functions (ready + process)

func _ready():
	rect.visible = false

# Custom Functions

func ChangeMask():
	currentTransition = transitionArray[randi() % transitionArray.size()]
	transitionArray.erase(currentTransition)
	usedTransitions.append(currentTransition)
	shaderMat.set_shader_param("mask", currentTransition)

func Play(transitionIn, transitionOut, menu):
	rect.visible = true
	currentIn = transitionIn
	currentOut = transitionOut
	currentMenu = menu
	ChangeMask()
	player.play(transitionOut)

func TransitionIn(transition, mode):
	rect.visible = true
	currentMode = mode
	player.play(transition)

func TransitionOut(transition, mode):
	rect.visible = true
	currentMode = mode
	player.play(transition)

func ResetSmooth():
	shaderMat.set_shader_param("smooth_size", 0.001)

# Node Functions

func _on_AnimationPlayer_animation_finished(anim_name):
	
	if anim_name == currentOut:
		transitionedOut = true
		ChangeMask()
		transitionArray += usedTransitions
		usedTransitions.clear()
		player.play(currentIn)
	elif anim_name == currentIn:
		transitionedOut = false
		rect.visible = false
	else:
		rect.visible = false
	
	#Unique Circumstances
	match currentMode:
		"Welcome":
			transitionArray += usedTransitions
			usedTransitions.clear()
			rect.visible = false
		"Game":
			if get_tree().change_scene("res://0 Scenes/game.tscn") != OK:
				print ("An unexpected error occured when trying to switch to the game scene")
		"Quit":
			if get_tree().change_scene("res://0 Scenes/menu.tscn") != OK:
				print ("An unexpected error occured when trying to switch to the menu scene")

	animationPlaying = false
	ResetSmooth()

func _on_AnimationPlayer_animation_started(anim_name):
	animationPlaying = true
	return anim_name
