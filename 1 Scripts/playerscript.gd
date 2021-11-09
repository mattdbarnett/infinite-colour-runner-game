extends KinematicBody2D


#Basic movement vars
const UP = Vector2(0, -1)

var xspeed = 700

var grav = 30
var gravup = 30
var gravdown = -30
var isGravUp = false

var motion = Vector2()

func _ready():
	pass 

func _process(delta):
	motion.y += grav
	
	if (is_on_floor() or is_on_ceiling()) && Input.is_action_just_pressed("move"):
		isGravUp = !isGravUp
	
	motion = move_and_slide(motion, UP)