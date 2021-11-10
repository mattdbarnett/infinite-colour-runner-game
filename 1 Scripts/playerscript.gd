extends KinematicBody2D


#Basic movement vars
const UP = Vector2(0, -1)

var xspeed = 200

var grav = 30
var gravup = -30
var gravdown = 30
var isGravUp = false

var motion = Vector2()

func _ready():
	pass 

func _process(delta):
	
	if is_on_wall():
		playerDeath()
	
	motion.y += grav
	motion.x = xspeed
	
	if (is_on_floor() or is_on_ceiling()) && Input.is_action_just_pressed("move"):
		isGravUp = !isGravUp
	
	if isGravUp == true:
		grav = gravup
	else:
		grav = gravdown
	
	motion = move_and_slide(motion, UP)

func playerDeath():
	get_tree().reload_current_scene()
