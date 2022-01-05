"""
- - - - - - - - - - - - - - -
 Title: Player Class Script
 Author: Matt Barnett
 Created: 9/11/2021
- - - - - - - - - - - - - - -

 Desc:
	Script for instances of the player object. Handles input, gravity, 
	movespeed and reaction to colours. Currently only one exists, but more 
	could be instanced in the future for multiplayer modes etc, which is why 
	the player is a class rather than a part of the the game scene.
"""

extends KinematicBody2D

const UP = Vector2(0, -1)
var motion = Vector2()

"""
 Horizontal Speed Vars:
	staticx - Stays the same throughout the game. Used to reset player speed.
	basex - Xspeed is consistently equal to this. Resets to staticx when needed.
	xspeed - Raw current speed of the player.
"""
var staticx = 700
var basex = 700
var xspeed = 700

"""
 Vertical Speed Vars:
	grav - Raw, actual gravity of the player.
	gravchange - The base gravity - grav is changed based around this in gameplay.
	gravup - The value of gravity when the player falls up.
	gravdown - The value of gravity when the player falls down.
"""
var grav = 40
var gravchange = grav
var gravup = -gravchange
var gravdown = gravchange
var isGravUp = false

#Colour Vars
var touchingCurrent
var modeCurrent
var powerupBool = false 
var bluex = 300
var purplex = -300
var yellowtoggle = false
var isPowerupPink = false

#Misc Vars
var scoreIncrement = 1
var currentHold = false
onready var gameroot = get_node("..")

#Speed + Grav UI
onready var speedGravPanels = get_node("Camera2D/CanvasLayer/speed+gravPanels")
onready var movePanel = get_node("Camera2D/CanvasLayer/movePanel")
onready var statusPanel = get_node("Camera2D/CanvasLayer/statusPanel")
onready var statusArrow = get_node("Camera2D/CanvasLayer/statusPanel/statusArrow")

#Score UI
onready var scoreTimer = get_node("Camera2D/TimerScore")
onready var scoreLabel = get_node("Camera2D/CanvasLayer/scorePanel/valueLabel")
var score = 0

#Powerup UI
onready var powerdownTimer = get_node("Camera2D/TimerPowerdown")
onready var powerupTimer = get_node("Camera2D/TimerPowerup")
onready var powerupBar = get_node("Camera2D/CanvasLayer/Powerup")
var powerupValue = 50

#Trails
onready var trailGhost = get_node("sprite/trail_ghost")
onready var trailSnake = get_node("sprite/trail_snake")
onready var trailSmoke = get_node("sprite/trail_smoke")
onready var trailFlames = get_node("sprite/trail_flames")
onready var trailRainbow = get_node("sprite/trail_rainbow")

#Backgrounds
onready var bgPlain = get_node("sprite/backgrounds/bg_plain")
onready var bgFade = get_node("sprite/backgrounds/bg_fade")
onready var bgRainbow = get_node("sprite/backgrounds/bg_rainbowlayer/bg_rainbow")

# Pre-Built Functions (ready + process)

func _ready():
	powerupTimer.start()
	scoreTimer.start()
	
	PlayerTrail()
	PlayerBg()
	PlayerUIInitalise()

func _physics_process(_delta):
	scoreLabel.text = str(int(score))
	powerupBar.value = powerupValue
	motion.y += grav
	motion.x = xspeed
	
	PlayerInput()
	PlayerTouch()
	PlayerEffects()
	PlayerUIConst()
	
	motion = move_and_slide(motion, UP)

# Custom Functions

func PlayerInput():
	#User input changes gravity
	if (is_on_floor() or is_on_ceiling()) && Input.is_action_just_pressed("move"):
		isGravUp = !isGravUp
	
	if isGravUp == true:
		grav = gravup
	else:
		grav = gravdown
	
	#Hold-mode Input
	if globalsettings.GetHoldmode() == true:
		
		if Input.is_action_pressed("move"):
			currentHold = true
		else:
			currentHold = false
		
		if is_on_floor() or is_on_ceiling():
			if currentHold == true:
				if is_on_floor():
					isGravUp = true
				if is_on_ceiling():
					isGravUp = false
		
	#Powerup Inout
	if Input.is_action_just_pressed("powerup"):
		if powerupValue >= 100:
			isPowerupPink = false
			powerupBool = true

func PlayerTouch():
	
	if is_on_wall():
		PlayerDeath()
	
	#Detect Touch
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		match collision.collider.name:
			"RedLBody": 
				PlayerDeath()
			"BlueLBody":
				touchingCurrent = "blue"
				modeCurrent = "blue"
			"PurpleLBody":
				modeCurrent = "purple"
				touchingCurrent = "purple"
			"GreenLBody":
				modeCurrent = "green"
				touchingCurrent = "green"
			"YellowLBody":
				modeCurrent = "yellow"
				touchingCurrent = "yellow"
			"PinkLBody":
				modeCurrent = "pink"
				touchingCurrent = "pink"
			_:
				if modeCurrent == "yellow":
					yellowtoggle = !yellowtoggle
				if modeCurrent != "powerup":
					modeCurrent = "base"
				touchingCurrent = "base"
				
		
func PlayerEffects():
	
	#Powerup Effects
	if powerupValue >= 100:
		powerupTimer.stop()
		powerupValue = 100
	
	if powerupBool == true:
		modeCurrent = "powerup"

	#Apply effects of last terrain touched
	match modeCurrent:
		"blue":
			xspeed = bluex
			basex = staticx
			scoreIncrement = 0.5
		"purple":
			xspeed = purplex
			basex = staticx
			scoreIncrement = -1
		"green":
			xspeed += 1
			basex = xspeed
			TimerScoreReset()
		"yellow":
			if yellowtoggle == false:
				gravchange += 0.5
			elif yellowtoggle == true:
				gravchange -= 0.5
			gravup = -gravchange
			gravdown = gravchange
			TimerScoreReset()
		"pink":
			powerupValue = 100
			isPowerupPink = true
			xspeed = 200
			basex = staticx
			modeCurrent = "powerup"
			scoreIncrement = 0
		"powerup":
			xspeed = 200
			basex = staticx
			
			if isPowerupPink == true and touchingCurrent != "pink":
				powerupValue = 0
			
			if PowerupStatus() == "EMPTY" or Input.is_action_just_released("powerup"): 
				powerupBool = false
				basex = staticx
				powerdownTimer.stop()
				powerupTimer.start()
				modeCurrent = "base"
				powerupValue -= 10
				if powerupValue < 0:
					powerupValue = 0
			else:
				powerdownTimer.start()
			
			scoreIncrement = 0
		_:
			xspeed = basex
			TimerScoreReset()

func PlayerUIConst():
	
	# Speed + Gravity Panels
	if globalsettings.GetSpdGravInfo() == true:
		var speedValueLabel = get_node(str(speedGravPanels.get_path()) + "/speedPanel/valueLabel")
		speedValueLabel.text = str(xspeed)
		var gravValueLabel = get_node(str(speedGravPanels.get_path()) + "/gravPanel/valueLabel")
		gravValueLabel.text = str(int(gravchange))
	
	# Move Panel
	if globalsettings.GetMoveInfo() == true:
		if (is_on_floor() or is_on_ceiling()):
			movePanel.get_stylebox("panel", "").set_bg_color("#00FF21")
		else:
			movePanel.get_stylebox("panel", "").set_bg_color("#000000")
	
	# Status Panel
	if globalsettings.GetStatusInfo() == true:
		match modeCurrent:
			"base": statusPanel.get_stylebox("panel", "").set_bg_color("#000000")
			"blue": statusPanel.get_stylebox("panel", "").set_bg_color("#0016ff")
			"purple": statusPanel.get_stylebox("panel", "").set_bg_color("#4800ff")
			"green": statusPanel.get_stylebox("panel", "").set_bg_color("#06ff00")
			"yellow": statusPanel.get_stylebox("panel", "").set_bg_color("#ffef00")
			"pink": statusPanel.get_stylebox("panel", "").set_bg_color("#f400ff")
			"powerup": statusPanel.get_stylebox("panel", "").set_bg_color("#f400ff")
		if modeCurrent == "yellow":
			statusArrow.visible = true
			if yellowtoggle == false:
				statusArrow.rotation_degrees = 0
			elif yellowtoggle == true:
				statusArrow.rotation_degrees = 180
		else:
			statusArrow.visible = false

func PlayerDeath():
	#If game is not custom, check if highscore and add currency
	if globalsettings.GetGamemode() != "Custom":
		if score > globalsettings.GetHighscore():
			globalsettings.SetHighscore(score)
		
		score = int(score/5)
		globalsettings.SetCurrency(globalsettings.GetCurrency() + score)
	
	#Reload scene
	if gameroot.ending != true:
		if get_tree().reload_current_scene() != OK:
			print("An unexpected error occured when trying to restart the scene")

func PlayerTrail():
	match globalsettings.GetCurrentTrail():
		"ghost":
			trailGhost.visible = true
		"snake":
			trailSnake.visible = true
		"smoke":
			trailSmoke.visible = true
		"flames":
			trailFlames.visible = true
		"rainbow":
			trailRainbow.visible = true

func PlayerBg():
	match globalsettings.GetCurrentBg():
		"plain":
			bgPlain.visible = true
		"fade":
			bgFade.visible = true
		"disco":
			bgRainbow.visible = true

func PlayerUIInitalise():
	if globalsettings.GetSpdGravInfo() == true:
		speedGravPanels.visible = true
	
	if globalsettings.GetMoveInfo() == true:
		movePanel.visible = true
	
	if globalsettings.GetStatusInfo() == true:
		statusPanel.visible = true

func PowerupStatus():
	if powerupValue == 100:
		return "FULL"
	elif powerupValue < 1:
		return "EMPTY"

func SetGrav():
	grav = globalsettings.GetGlobalgrav()
	gravchange = grav
	gravup = -gravchange
	gravdown = gravchange
	isGravUp = false

# Node Functions

func _on_TimerPowerup_timeout():
	powerupValue += 0.1

func _on_TimerPowerdown_timeout():
	powerupValue -= 0.1

func TimerScoreReset():
	scoreIncrement = 1
	scoreTimer.wait_time = 1

func _on_TimerScore_timeout():
	score += scoreIncrement
