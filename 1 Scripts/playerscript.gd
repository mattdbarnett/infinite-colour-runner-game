extends KinematicBody2D


#Basic movement vars
const UP = Vector2(0, -1)

var xspeed = 700

var grav = 40
var gravup = -40
var gravdown = 40
var isGravUp = false

var motion = Vector2()

#func _ready():
#	pass 

func _process(delta):
	
	motion.y += grav
	motion.x = xspeed
	
	playerInput()
	
	playerTouch()
	
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
			_:
				pass

func playerDeath():
	get_tree().reload_current_scene()
