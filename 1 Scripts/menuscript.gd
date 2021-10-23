extends Node2D

"""
Variable Initalisation
"""

#Menu Node Variables
onready var menumain = get_node("menucanvas/menumain")
onready var menuplay = get_node("menucanvas/menuplay")
onready var menucustom = get_node("menucanvas/menucustom")
onready var menustore = get_node("menucanvas/menustore")
onready var menusettings = get_node("menucanvas/menusettings")
onready var menuhelp = get_node("menucanvas/menuhelp")

#Main Menu Vars
onready var currentmenu = menumain

#Play Menu Vars
onready var currentmode = 0
onready var mpbuttons = [
	get_node("menucanvas/menuplay/mp_scollcont/mp_hboxcont/mp_btncontainer1/mp_op1"),
	get_node("menucanvas/menuplay/mp_scollcont/mp_hboxcont/mp_btncontainer2/mp_op2"),
	get_node("menucanvas/menuplay/mp_scollcont/mp_hboxcont/mp_btncontainer3/mp_op3"),
	get_node("menucanvas/menuplay/mp_scollcont/mp_hboxcont/mp_btncontainer4/mp_op4"),
	get_node("menucanvas/menuplay/mp_scollcont/mp_hboxcont/mp_btncontainer5/mp_op5"),
	get_node("menucanvas/menuplay/mp_scollcont/mp_hboxcont/mp_btncontainer6/mp_op6"),
	get_node("menucanvas/menuplay/mp_scollcont/mp_hboxcont/mp_btncontainer7/mp_op7")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("menucanvas/menumain/mm_playbtn").grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

"""
Menu Update Signals
"""

func currentmenu_update(newcurrent):
	match newcurrent:
		menumain:
			get_node("menucanvas/menumain/mm_playbtn").grab_focus()
		menuplay:
			get_node("menucanvas/menuplay/mp_back").grab_focus()
		menucustom:
			get_node("menucanvas/menucustom/mc_back").grab_focus()
			
	newcurrent.visible = true
	currentmenu.visible = false
	currentmenu = newcurrent

"""
Main Menu Signals
"""

func _on_mm_playbtn_pressed():
	currentmenu_update(menuplay)

func _on_mm_custombtn_pressed():
	currentmenu_update(menucustom)

func _on_mm_storebtn_pressed():
	currentmenu_update(menustore)

func _on_mm_settingsbtn_pressed():
	currentmenu_update(menusettings)

func _on_mm_helpbtn_pressed():
	currentmenu_update(menuhelp)

func _on_mm_quitbtn_pressed():
	get_tree().quit()

"""
Play Menu Signals
"""

func _on_mp_back_pressed():
	currentmenu_update(menumain)

func togglemodecheck(num):
	for but in mpbuttons:
		but.pressed = false
	
	currentmode = num + 1
	mpbuttons[num].pressed = true

func _on_mp_op1_pressed():
	togglemodecheck(0)

func _on_mp_op2_pressed():
	togglemodecheck(1)

func _on_mp_op3_pressed():
	togglemodecheck(2)

func _on_mp_op4_pressed():
	togglemodecheck(3)

func _on_mp_op5_pressed():
	togglemodecheck(4)

func _on_mp_op6_pressed():
	togglemodecheck(5)

func _on_mp_op7_pressed():
	togglemodecheck(6)

"""
Custom Menu Signals
"""

func _on_mc_back_pressed():
	currentmenu_update(menumain)

"""
Store Menu Signals
"""

"""
Settings Menu Signals
"""

"""
Help Menu Signals
"""
