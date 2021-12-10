extends KinematicBody2D


#Basic movement vars
const UP = Vector2(0, -1)

const staticx = 700
var basex = 700
var xspeed = 700

const staticy = 40
var grav = 40
var gravchange = grav
var gravup = -gravchange
var gravdown = gravchange
var isGravUp = false

var motion = Vector2()

var touchingCurrent 
var powerupBool = false
var powerupCurrent = "base"
var modeCurrent 

var bluex = 300

var purplex = -300

var yellowtoggle = false

var isPowerupPink = false

var scoreIncrement = 1

onready var scoreTimer = get_node("Camera2D/TimerScore")
onready var scoreLabel = get_node("Camera2D/CanvasLayer/scorePanel/valueLabel")
var score = 0

onready var powerdownTimer = get_node("Camera2D/TimerPowerdown")
onready var powerupTimer = get_node("Camera2D/TimerPowerup")
onready var powerupBar = get_node("Camera2D/CanvasLayer/Powerup")
var powerupValue = 50
var powerupMode = false

func _ready():
	powerupTimer.start()
	scoreTimer.start()

func _process(delta):
	
	scoreLabel.text = str(score)
	powerupBar.value = powerupValue
	motion.y += grav
	motion.x = xspeed
	
	playerInput()
	
	playerTouch()
	
	playerEffects()
	
	motion = move_and_slide(motion, UP)

func playerInput():
	#User input changes gravity
	if (is_on_floor() or is_on_ceiling()) && Input.is_action_just_pressed("move"):
		isGravUp = !isGravUp
	
	if isGravUp == true:
		grav = gravup
	else:
		grav = gravdown
	
	if Input.is_action_just_pressed("esc"):
		get_tree().change_scene("res://0 Scenes/menu.tscn")
	
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
			
			scoreTimer.wait_time = 2
		"purple":
			xspeed = purplex
			basex = staticx
			
			scoreIncrement = -1
			scoreTimer.wait_time = 2
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
	
func playerDeath():
	get_tree().reload_current_scene()

func powerupStatus():
	if powerupValue == 100:
		return "FULL"
	elif powerupValue < 1:
		return "EMPTY"

func _on_TimerPowerup_timeout():
	powerupValue += 0.1

func _on_TimerPowerdown_timeout():
	powerupValue -= 0.1

func timerScoreReset():
	scoreIncrement = 1
	scoreTimer.wait_time = 1

func _on_TimerScore_timeout():
	score += scoreIncrement
