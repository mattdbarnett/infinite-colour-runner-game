extends KinematicBody2D


#Basic movement vars
const UP = Vector2(0, -1)

var basex = 700
var xspeed = 700

var grav = 40
var gravup = -40
var gravdown = 40
var isGravUp = false

var motion = Vector2()

var bluex = 300
var bluemode = false

var purplex = -300
var purplemode = false

var greenmode = false
#func _ready():
#	pass 

func _process(delta):
	
	print(xspeed)
	
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
			_:
				pass
		
		if collision.collider.name != "BlueLBody":
			bluemode = false
		
		if collision.collider.name != "PurpleLBody":
			purplemode = false
		
		if collision.collider.name != "GreenLBody":
			greenmode = false

func playerEffects():
	if bluemode == true:
		xspeed = bluex
		basex = 700
	elif purplemode == true:
		xspeed = purplex
		basex = 700
	elif greenmode == true:
		xspeed += 1
		basex = xspeed
	else:
		xspeed = basex
	
func playerDeath():
	get_tree().reload_current_scene()
