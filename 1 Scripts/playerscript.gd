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

var powerupBool = false
var powerupCurrent = "base"
var modeCurrent 

var bluex = 300

var purplex = -300

var yellowtoggle = false

onready var powerdownTimer = get_node("Camera2D/TimerPowerdown")
onready var powerupTimer = get_node("Camera2D/TimerPowerup")
onready var powerupBar = get_node("Camera2D/CanvasLayer/Powerup")
var powerupValue = 50
var powerupMode = false

func _ready():
	powerupTimer.start()

func _process(delta):
	
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
				modeCurrent = "blue"
			"PurpleLBody":
				modeCurrent = "purple"
			"GreenLBody":
				modeCurrent = "green"
			"YellowLBody":
				modeCurrent = "yellow"
			_:
				if modeCurrent == "yellow":
					yellowtoggle = !yellowtoggle
				if modeCurrent != "powerup":
					modeCurrent = "base"
				
		
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
		"purple":
			xspeed = purplex
			basex = staticx
		"green":
			xspeed += 1
			basex = xspeed
		"yellow":
			if yellowtoggle == false:
				gravchange += 1
			elif yellowtoggle == true:
				gravchange -= 1
			gravup = -gravchange
			gravdown = gravchange
		"pink":
			pass
		"powerup":
			xspeed = 200
			basex = staticx
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
		_:
			xspeed = basex
	
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
