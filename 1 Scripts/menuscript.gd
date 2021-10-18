extends Node2D

"""
Variable Initalisation
"""

#Menu Variables
onready var menumain = get_node("menucanvas/menumain")
onready var menuplay = get_node("menucanvas/menuplay")
onready var menucustom = get_node("menucanvas/menucustom")
onready var menustore = get_node("menucanvas/menustore")
onready var menusettings = get_node("menucanvas/menusettings")
onready var menuhelp = get_node("menucanvas/menuhelp")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

"""
Main Menu Signals
"""

func _on_mm_playbtn_pressed():
	menumain.visible = false
	menuplay.visible = true

func _on_mm_custombtn_pressed():
	menumain.visible = false
	menucustom.visible = true

func _on_mm_storebtn_pressed():
	menumain.visible = false
	menustore.visible = true

func _on_mm_settingsbtn_pressed():
	menumain.visible = false
	menusettings.visible = true

func _on_mm_helpbtn_pressed():
	menumain.visible = false
	menuhelp.visible = true

func _on_mm_quitbtn_pressed():
	get_tree().quit()

"""
Play Menu Signals
"""

"""
Custom Menu Signals
"""

"""
Store Menu Signals
"""

"""
Settings Menu Signals
"""

"""
Help Menu Signals
"""
