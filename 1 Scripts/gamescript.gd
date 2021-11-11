extends Node

var fterrain = Array() #Contains all floor piece positions
var cterrain = Array() #Contains all ceiling piece positions
var screensize

var texture = preload("res://2 Sprites/black.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	screensize = get_viewport().get_visible_rect().size
	#Create a random starting point on y axis for both ceiling and floor.
	var startf_y = 100 * 3/4 + (randi() % 100) 
	var startc_y = -700 * 1/2 + (-50 + randi() % 50*2)
	#Add the starting points to arrays so that they are started from.
	fterrain.append(Vector2(0, startf_y))
	cterrain.append(Vector2(0, startc_y))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if fterrain[-1].x < $player.position.x + screensize.x:
		floor_gen()
	
	if cterrain[-1].x < $player.position.x + screensize.x:
		ceiling_gen()

func floor_gen():
	var floor_width = 512 #Size of each piece
	var floor_slices = 2 #Ensures straight line between floors on y axis
	
	var start = fterrain[-1] #The start is startf_y
	var poly = PoolVector2Array() #The shape of the floor piece
	var height = randi() % 50
	var lastx = 0
	var lasty = 0
	for piece in range(floor_slices):
		start.y -= height
		for piecePart in range(0, floor_slices):
			
			var floor_point = Vector2()
			
			#Maintains position if it's the second part of the piece
			floor_point.x = lastx
			
			#Maintains height if it's the second part of the piece
			floor_point.y = lasty
			
			if piecePart == 0:
				#If this is the first section of the piece, define/create position
				floor_point.x = start.x + piecePart + floor_width * piece
				lastx = floor_point.x
			
			if piecePart == 0 and piece == 0:
				#If this is the first section of the piece, define/create height
				floor_point.y = start.y + height * cos(1 * PI / floor_slices * piecePart)
				
				#Limits floor from going too low
				if floor_point.y < 90:
					floor_point.y += 64
				
				#Limits floor from going too high
				if floor_point.y > 300:
					floor_point.y -= 64
				
				lasty = floor_point.y 
				
			fterrain.append(floor_point)
			poly.append(floor_point)
		start.y += height
	var shape = CollisionPolygon2D.new() #The collision shape for the floor
	var ground = Polygon2D.new() #The visual shape for the floor
	var type = $LBody
	type.add_child(shape) #Adds the collision to the level
	#Below closes the shape collision and visual shown from the start of the floor
	#to the bottom of the level
	poly.append(Vector2(fterrain[-1].x, screensize.y))
	poly.append(Vector2(start.x, screensize.y))
	#Below sets the closed shape to be shown visually and in collisions.
	shape.polygon = poly
	ground.polygon = poly
	ground.texture = texture
	add_child(ground)

func ceiling_gen():
	pass
