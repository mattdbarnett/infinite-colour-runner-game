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

var bluex = 300
var bluemode = false

var purplex = -300
var purplemode = false

var greenmode = false

var yellowmode = false
var yellowtoggle = false

onready var powerupTimer = get_node("Camera2D/TimerPowerup")
onready var powerupBar = get_node("Camera2D/CanvasLayer/Powerup")
var powerupValue = 0
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
	
	if powerupValue > 99.5:
		powerupTimer.stop()
	
	if Input.is_action_just_pressed("powerup"):
		if powerupValue > 99.5:
			powerupValue = 0
			powerupTimer.start()

func playerTouch():
	if is_on_wall():
		playerDeath()
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		match collision.collider.name:
			"RedLBody": 
				playerDeath()
			"BlueLBody":
				bluemode = true
			"PurpleLBody":
				purplemode = true
			"GreenLBody":
				greenmode = true
			"YellowLBody":
				yellowmode = true
			_:
				if yellowmode == true:
					yellowtoggle = !yellowtoggle
		
		if collision.collider.name != "BlueLBody":
			bluemode = false
		
		if collision.collider.name != "PurpleLBody":
			purplemode = false
		
		if collision.collider.name != "GreenLBody":
			greenmode = false
		
		if collision.collider.name != "YellowLBody":
			yellowmode = false
		
func playerEffects():
	if bluemode == true:
		xspeed = bluex
		basex = staticx
	elif purplemode == true:
		xspeed = purplex
		basex = staticx
	elif greenmode == true:
		xspeed += 1
		basex = xspeed
	elif yellowmode == true:
		if yellowtoggle == false:
			gravchange += 1
		elif yellowtoggle == true:
			gravchange -= 1
		gravup = -gravchange
		gravdown = gravchange
	else:
		xspeed = basex
	
func playerDeath():
	get_tree().reload_current_scene()

func _on_TimerPowerup_timeout():
	powerupValue += 0.5
