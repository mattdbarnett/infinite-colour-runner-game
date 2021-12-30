extends KinematicBody2D


#Basic movement vars
const UP = Vector2(0, -1)

var staticx = 700
var basex = 700
var xspeed = 700

var grav = 40
var gravchange = grav
var gravup = -gravchange
var gravdown = gravchange
var isGravUp = false

var motion = Vector2()

var touchingCurrent 
var powerupBool = false
var modeCurrent 

var bluex = 300

var purplex = -300

var yellowtoggle = false

var isPowerupPink = false

var scoreIncrement = 1

var currentHold = false

onready var gameroot = get_node("..")

onready var speedGravPanels = get_node("Camera2D/CanvasLayer/speed+gravPanels")
onready var movePanel = get_node("Camera2D/CanvasLayer/movePanel")
onready var statusPanel = get_node("Camera2D/CanvasLayer/statusPanel")
onready var statusArrow = get_node("Camera2D/CanvasLayer/statusPanel/statusArrow")

onready var scoreTimer = get_node("Camera2D/TimerScore")
onready var scoreLabel = get_node("Camera2D/CanvasLayer/scorePanel/valueLabel")
var score = 0

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

func _ready():
	powerupTimer.start()
	scoreTimer.start()
	
	playerTrail()
	
	playerBg()
	
	playerUIInitalise()

func _physics_process(_delta):

	scoreLabel.text = str(int(score))
	powerupBar.value = powerupValue
	motion.y += grav
	motion.x = xspeed
	
	playerInput()
	
	playerTouch()
	
	playerEffects()
	
	playerUIConst()
	
	motion = move_and_slide(motion, UP)

func playerInput():
	#User input changes gravity
	if (is_on_floor() or is_on_ceiling()) && Input.is_action_just_pressed("move"):
		isGravUp = !isGravUp
	
	if isGravUp == true:
		grav = gravup
	else:
		grav = gravdown
	
	#Hold-mode input
	if globalsettings.getHoldmode() == true:
		
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
		
	#Powerup inout
	if Input.is_action_just_pressed("powerup"):
		if powerupValue >= 100:
			isPowerupPink = false
			powerupBool = true

func playerTouch():
	if is_on_wall():
		playerDeath()
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		match collision.collider.name:
			"RedLBody": 
				playerDeath()
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
				
		
func playerEffects():
	
	#Powerup Effects
	
	if powerupValue >= 100:
		powerupTimer.stop()
		powerupValue = 100
	
	if powerupBool == true:
		modeCurrent = "powerup"

	#Terrian Effects
	
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
			
			timerScoreReset()
		"yellow":
			if yellowtoggle == false:
				gravchange += 0.5
			elif yellowtoggle == true:
				gravchange -= 0.5
			gravup = -gravchange
			gravdown = gravchange
			
			timerScoreReset()
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
			
			if powerupStatus() == "EMPTY" or Input.is_action_just_released("powerup"): 
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
			
			timerScoreReset()

func playerUIConst():
	
	# Speed + Gravity Panels
	
	if globalsettings.getSpdGravInfo() == true:
		var speedValueLabel = get_node(str(speedGravPanels.get_path()) + "/speedPanel/valueLabel")
		speedValueLabel.text = str(xspeed)
		var gravValueLabel = get_node(str(speedGravPanels.get_path()) + "/gravPanel/valueLabel")
		gravValueLabel.text = str(int(gravchange))
	
	# Move Panel
	
	if globalsettings.getMoveInfo() == true:
		if (is_on_floor() or is_on_ceiling()):
			movePanel.get_stylebox("panel", "").set_bg_color("#00FF21")
		else:
			movePanel.get_stylebox("panel", "").set_bg_color("#000000")
	
	# Status Panel
	if globalsettings.getStatusInfo() == true:
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

func playerDeath():
	if globalsettings.getGamemode() != "Custom":
		if score > globalsettings.getHighscore():
			globalsettings.setHighscore(score)
		
		score = int(score/5)
		globalsettings.setCurrency(globalsettings.getCurrency() + score)
	
	if gameroot.ending != true:
		if get_tree().reload_current_scene() != OK:
			print("An unexpected error occured when trying to restart the scene")

func playerTrail():
	match globalsettings.getCurrentTrail():
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

func playerBg():
	match globalsettings.getCurrentBg():
		"plain":
			bgPlain.visible = true
		"fade":
			bgFade.visible = true
		"disco":
			bgRainbow.visible = true

func playerUIInitalise():
	if globalsettings.getSpdGravInfo() == true:
		speedGravPanels.visible = true
	
	if globalsettings.getMoveInfo() == true:
		movePanel.visible = true
	
	if globalsettings.getStatusInfo() == true:
		statusPanel.visible = true

func powerupStatus():
	if powerupValue == 100:
		return "FULL"
	elif powerupValue < 1:
		return "EMPTY"

func setGrav():
	grav = globalsettings.getGlobalgrav()
	gravchange = grav
	gravup = -gravchange
	gravdown = gravchange
	isGravUp = false

func _on_TimerPowerup_timeout():
	powerupValue += 0.1

func _on_TimerPowerdown_timeout():
	powerupValue -= 0.1

func timerScoreReset():
	scoreIncrement = 1
	scoreTimer.wait_time = 1

func _on_TimerScore_timeout():
	score += scoreIncrement
