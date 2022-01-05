extends Node

var fterrain = Array() #Contains all floor piece positions
var cterrain = Array() #Contains all ceiling piece positions
var randomlist = [-32, 32]
var screensize

var floor_width = 512 #Size of each piece
var floor_slices = 2 #Ensures straight line between floors on y axis

var ceiling_width = 512
var ceiling_slices = 2

var shape
var ground
var type

var rng = RandomNumberGenerator.new()
var ftype
var ctype
var lastTypeUnique = true #if true, can't be another colour piece
	
var typedict = {}
var typelist = Array()
var texture = preload("res://2 Sprites/0 Basic/black.png")
var texturered = preload("res://2 Sprites/0 Basic/red.png")
var textureblue = preload("res://2 Sprites/0 Basic/blue.png")
var texturepurple = preload("res://2 Sprites/0 Basic/purple.png")
var texturegreen = preload("res://2 Sprites/0 Basic/green.png")
var textureyellow = preload("res://2 Sprites/0 Basic/yellow.png")
var texturepink = preload("res://2 Sprites/0 Basic/pink.png")

onready var transitionroot = get_node("transitioncanvas/transitionroot")

onready var fpsLabel = get_node("player/Camera2D/CanvasLayer/fpsLabel")

onready var player = get_node("player")

onready var globalsettings = get_node("/root/globalsettings")
var customDataGet
var customDataSum = 0

var ending = false
# Called when the node enters the scene tree for the first time.
func _ready():
	
	transitionroot.TransitionIn("fade_in", null)
	if globalsettings.GetFpsInfo() == true:
		fpsLabel.visible = true
	typedict = {
		texture: $LBody,
		texturered: $RedLBody,
		textureblue: $BlueLBody,
		texturepurple: $PurpleLBody,
		texturegreen: $GreenLBody,
		textureyellow: $YellowLBody,
		texturepink: $PinkLBody
	}
	randomize()
	screensize = get_viewport().get_visible_rect().size
	#Create a random starting point on y axis for both ceiling and floor.
	var startf_y = 100 * 3/4 + (randi() % 100) 
	var startc_y = -700 * 1/2 + (-50 + randi() % 50*2)
	#Add the starting points to arrays so that they are started from.
	fterrain.append(Vector2(0, startf_y))
	cterrain.append(Vector2(0, startc_y))
	
	match globalsettings.gamemode:
		"Standard":
			for _i in range(20):
				typelist.append(texture)
			for _i in range(5):
				typelist.append(texturered)
		"Take It Slow":
			for _i in range(25):
				typelist.append(texture)
			for _i in range(10):
				typelist.append(textureblue)
			for _i in range(5):
				typelist.append(texturered)
		"Reverse":
			for _i in range(30):
				typelist.append(texture)
			for _i in range(12):
				typelist.append(texturepurple)
			for _i in range(4):
				typelist.append(textureblue)
			for _i in range(4):
				typelist.append(texturered) 
		"Lava":
			for _i in range(30):
				typelist.append(texture)
			for _i in range(30):
				typelist.append(texturered) 
		"Rapid":
			for _i in range(30):
				typelist.append(texture)
			for _i in range(10):
				typelist.append(texturegreen)
		"Fluctuant":
			for _i in range(30):
				typelist.append(texture)
			for _i in range(10):
				typelist.append(textureblue)
			for _i in range(10):
				typelist.append(texturegreen)
		"Gravity":
			for _i in range(30):
				typelist.append(texture)
			for _i in range(6):
				typelist.append(textureyellow)
			for _i in range(4):
				typelist.append(texturered)
		"Powerup":
			for _i in range(34):
				typelist.append(texture)
			for _i in range(6):
				typelist.append(texturepink)
		"Lunacy":
			for _i in range(25):
				typelist.append(texture)
			for _i in range(10):
				typelist.append(texturegreen)
			for _i in range(10):
				typelist.append(textureyellow)
			for _i in range(5):
				typelist.append(texturepink)
		"Rainbow":
			for _i in range(40):
				typelist.append(texture)
			for _i in range(10):
				typelist.append(textureblue)
			for _i in range(10):
				typelist.append(texturered)
			for _i in range(10):
				typelist.append(texturepurple)
			for _i in range(10):
				typelist.append(texturegreen)
			for _i in range(10):
				typelist.append(textureyellow)
			for _i in range(10):
				typelist.append(texturepink)
		"Custom":
			customDataGet = globalsettings.customData
			globalsettings.SetGlobalgrav(40 * (customDataGet.gravityvalue/100))
			player.SetGrav()
			player.staticx = 700 * (customDataGet.speedvalue/100)
			player.basex = 700 * (customDataGet.speedvalue/100)
			var sum = 0
			for value in customDataGet:
				sum += int(value)
			customDataSum = sum - customDataGet.speedvalue - customDataGet.gravityvalue
			for _i in range(20):
				typelist.append(texture)
			for _i in range(customDataSum):
				typelist.append(texture)
			for _i in range(customDataGet.bluevalue):
				typelist.append(textureblue)
			for _i in range(customDataGet.redvalue):
				typelist.append(texturered)
			for _i in range(customDataGet.purplevalue):
				typelist.append(texturepurple)
			for _i in range(customDataGet.greenvalue):
				typelist.append(texturegreen)
			for _i in range(customDataGet.yellowvalue):
				typelist.append(textureyellow)
			for _i in range(customDataGet.pinkvalue):
				typelist.append(texturepink)
		_:
			for _i in range(20):
				typelist.append(texture)
			for _i in range(6):
				typelist.append(texturered)
	
	for _i in range(3):
		FloorGen(texture)
		CeilingGen(texture)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	ExtraFeatures()
		
	if fterrain[-1].x < player.position.x + screensize.x:
		TextureGen()
		FloorGen(ftype)
	
	if cterrain[-1].x < player.position.x + screensize.x:
		CeilingGen(ctype)

func TextureGen():
	if lastTypeUnique == false:
		ftype = typelist[randi() % typelist.size()]
		ctype = typelist[randi() % typelist.size()]
		if ftype != texture or ctype != texture:
			lastTypeUnique = true
		if ftype != texture and ctype != texture:
			rng.randomize()
			var randTypeChoice = rng.randi_range(0, 1)
			if randTypeChoice == 0:	ftype = texture; else: ctype = texture
	else:
		ftype = texture
		ctype = texture
		lastTypeUnique = false
	
func FloorGen(ftypeinp):
	var random = randomlist[randi() % randomlist.size()]
	
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
				floor_point.y = start.y + height * cos(1 / floor_slices * piecePart) + random
				
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
	shape = CollisionPolygon2D.new() #The collision shape for the floor
	ground = Polygon2D.new() #The visual shape for the floor
	type = typedict[ftypeinp]
	type.add_child(shape) #Adds the collision to the level
	#Below closes the shape collision and visual shown from the start of the floor
	#to the bottom of the level
	poly.append(Vector2(fterrain[-1].x, screensize.y))
	poly.append(Vector2(start.x, screensize.y))
	#Below sets the closed shape to be shown visually and in collisions.
	shape.polygon = poly
	ground.polygon = poly
	ground.texture = ftypeinp
	add_child(ground)

func CeilingGen(ctypeinp):
	var random = randomlist[randi() % randomlist.size()]
	
	var start = cterrain[-1]
	var poly = PoolVector2Array()
	var height = randi() % 50
	var lasty = 0
	var lastx = 0
	for piece in range(ceiling_slices):
		start.y -= height
		for piecePart in range(0, ceiling_slices):
			
			var ceiling_point = Vector2()
			
			ceiling_point.y = lasty
			
			ceiling_point.x = lastx
			
			if piecePart == 0:
				#If this is the first section of the piece, define/create position
				ceiling_point.x = start.x + piecePart + ceiling_width * piece
				lastx = ceiling_point.x
				
			if piecePart == 0 and piece == 0:
				#If this is the first section of the piece, define/create height
				ceiling_point.y = start.y + height * cos(1 / ceiling_slices * piecePart) + random
				
				if ceiling_point.y > -90:
					ceiling_point.y += -64
					
				if ceiling_point.y < -400:
					ceiling_point.y += 64
				
				lasty = ceiling_point.y 
				
			cterrain.append(ceiling_point)
			poly.append(ceiling_point)
		start.y += height
	shape = CollisionPolygon2D.new()
	ground = Polygon2D.new()
	type = typedict[ctypeinp]
	type.add_child(shape)
	poly.append(Vector2(cterrain[-1].x, -screensize.y*2))
	poly.append(Vector2(start.x, -screensize.y*2))
	shape.polygon = poly
	ground.polygon = poly
	ground.texture = ctypeinp
	add_child(ground)

func ExtraFeatures():
	
	#Keep FPS label updated
	if globalsettings.fpsInfo == true:
		fpsLabel.text = str(Engine.get_frames_per_second())
	
	#Allow fullscreen to be switched mid-game
	if Input.is_action_just_released("fullscreen"):
		globalsettings.fullscreen()
	
	if Input.is_action_just_pressed("esc"):
		ending = true
		transitionroot.TransitionOut("fade_out", "Quit")
