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
	get_node("menucanvas/menuplay/mp_scollcont/mp_hboxcont/mp_btncontainer7/mp_op7"),
	get_node("menucanvas/menuplay/mp_scollcont/mp_hboxcont/mp_btncontainer8/mp_op8"),
	get_node("menucanvas/menuplay/mp_scollcont/mp_hboxcont/mp_btncontainer9/mp_op9"),
	get_node("menucanvas/menuplay/mp_scollcont/mp_hboxcont/mp_btncontainer10/mp_op10")
	
]

#Settings Menu Vars
onready var msbuttons = [
	get_node("menucanvas/menusettings/ms_g+d"),
	get_node("menucanvas/menusettings/ms_gui"),
	get_node("menucanvas/menusettings/ms_sound"),
	get_node("menucanvas/menusettings/ms_gameplay"),
]

onready var settinggd = get_node("menucanvas/menusettings/ms_g+d/ms_g+d_menu")
onready var settinggui = get_node("menucanvas/menusettings/ms_gui/ms_gui_menu")
onready var settingsound = get_node("menucanvas/menusettings/ms_sound/ms_sound_menu")
onready var settinggameplay = get_node("menucanvas/menusettings/ms_gameplay/ms_gameplay_menu")

onready var fullscreenbutton = get_node("menucanvas/menusettings/ms_g+d/ms_g+d_menu/ms_fullscreen")
onready var resolution = get_node("menucanvas/menusettings/ms_g+d/ms_g+d_menu/ms_resolution")

onready var hold = false
onready var pressholdbtn = get_node("menucanvas/menusettings/ms_gameplay/ms_gameplay_menu/ms_presshold")

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("menucanvas/menumain/mm_playbtn").grab_focus()
	resolution.add_item("1366x768")
	resolution.add_item("1920x1080")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fullscreenCheck()
	holdmodeCheck()

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
		menustore:
			get_node("menucanvas/menustore/mt_back").grab_focus()
		menusettings:
			get_node("menucanvas/menusettings/ms_back").grab_focus()
		menuhelp:
			pass
			
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
	get_node("menucanvas/menuhelp/mh_cont1").visible = true
	get_node("menucanvas/menuhelp/mh_cont2").visible = false
	get_node("menucanvas/menuhelp/mh_cont3").visible = false

func _on_mm_quitbtn_pressed():
	get_tree().quit()

"""
Play Menu Signals
"""

func _on_mp_back_pressed():
	currentmenu_update(menumain)

func togglemodecheck(num):
	$menucanvas/menuplay/mp_start.disabled = false
	for but in mpbuttons:
		but.pressed = false
	
	currentmode = num + 1
	mpbuttons[num].pressed = true

func _on_mp_op1_pressed():
	globalsettings.gamemode = "Standard"
	togglemodecheck(0)

func _on_mp_op2_pressed():
	globalsettings.gamemode = "Take It Slow"
	togglemodecheck(1)

func _on_mp_op3_pressed():
	globalsettings.gamemode = "Reverse"
	togglemodecheck(2)

func _on_mp_op4_pressed():
	globalsettings.gamemode = "Lava"
	togglemodecheck(3)

func _on_mp_op5_pressed():
	globalsettings.gamemode = "Rapid"
	togglemodecheck(4)

func _on_mp_op6_pressed():
	globalsettings.gamemode = "Fluctuant"
	togglemodecheck(5)

func _on_mp_op7_pressed():
	globalsettings.gamemode = "Gravity"
	togglemodecheck(6)

func _on_mp_op8_pressed():
	globalsettings.gamemode = "Powerup"
	togglemodecheck(7)

func _on_mp_op9_pressed():
	globalsettings.gamemode = "Lunacy"
	togglemodecheck(8)

func _on_mp_op10_pressed():
	globalsettings.gamemode = "Rainbow"
	togglemodecheck(9)


func _on_mp_start_pressed():
	get_tree().change_scene("res://0 Scenes/game.tscn")

"""
Custom Menu Signals
"""

func _on_mc_back_pressed():
	currentmenu_update(menumain)

func _on_mc_sliderblue_value_changed(value):
	var label = get_node("menucanvas/menucustom/mc_colours/mc_sliderblue/mc_lblval")
	var slider = get_node("menucanvas/menucustom/mc_colours/mc_sliderblue")
	
	label.text = str(slider.value) + "%"

func _on_mc_sliderpurple_value_changed(value):
	var label = get_node("menucanvas/menucustom/mc_colours/mc_sliderpurple/mc_lblval")
	var slider = get_node("menucanvas/menucustom/mc_colours/mc_sliderpurple")
	
	label.text = str(slider.value) + "%"

func _on_mc_slidergreen_value_changed(value):
	var label = get_node("menucanvas/menucustom/mc_colours/mc_slidergreen/mc_lblval")
	var slider = get_node("menucanvas/menucustom/mc_colours/mc_slidergreen")
	
	label.text = str(slider.value) + "%"

func _on_mc_slideryellow_value_changed(value):
	var label = get_node("menucanvas/menucustom/mc_colours/mc_slideryellow/mc_lblval")
	var slider = get_node("menucanvas/menucustom/mc_colours/mc_slideryellow")
	
	label.text = str(slider.value) + "%"

func _on_mc_sliderpink_value_changed(value):
	var label = get_node("menucanvas/menucustom/mc_colours/mc_sliderpink/mc_lblval")
	var slider = get_node("menucanvas/menucustom/mc_colours/mc_sliderpink")
	
	label.text = str(slider.value) + "%"

func _on_mc_sliderred_value_changed(value):
	var label = get_node("menucanvas/menucustom/mc_colours/mc_sliderred/mc_lblval")
	var slider = get_node("menucanvas/menucustom/mc_colours/mc_sliderred")
	
	label.text = str(slider.value) + "%"

func _on_mc_sliderspd_value_changed(value):
	var label = get_node("menucanvas/menucustom/mc_spdgrav/mc_lbl_spd/mc_sliderspd/mc_lblval")
	var slider = get_node("menucanvas/menucustom/mc_spdgrav/mc_lbl_spd/mc_sliderspd")
	
	label.text = str(slider.value) + "%"

func _on_mc_slidergrav_value_changed(value):
	var label = get_node("menucanvas/menucustom/mc_spdgrav/mc_lbl_grav/mc_slidergrav/mc_lblval")
	var slider = get_node("menucanvas/menucustom/mc_spdgrav/mc_lbl_grav/mc_slidergrav")
	
	label.text = str(slider.value) + "%"

"""
Store Menu Signals
"""

func _on_mt_back_pressed():
	currentmenu_update(menumain)

"""
Settings Menu Signals
"""

func togglemodesettingscheck(num):
	for but in msbuttons:
		but.pressed = false
	
	msbuttons[num].pressed = true

func _on_ms_gd_pressed():
	togglemodesettingscheck(0)
	settinggd.visible = true
	settinggui.visible = false
	settingsound.visible = false
	settinggameplay.visible = false

func _on_ms_gui_pressed():
	togglemodesettingscheck(1)
	settinggd.visible = false
	settinggui.visible = true
	settingsound.visible = false
	settinggameplay.visible = false

func _on_ms_sound_pressed():
	togglemodesettingscheck(2)
	settinggd.visible = false
	settinggui.visible = false
	settingsound.visible = true
	settinggameplay.visible = false

func _on_ms_gameplay_pressed():
	togglemodesettingscheck(3)
	settinggd.visible = false
	settinggui.visible = false
	settingsound.visible = false
	settinggameplay.visible = true

func _on_ms_presshold_pressed():
	globalsettings.holdmode = !globalsettings.holdmode

func holdmodeCheck():
	if globalsettings.holdmode == false:
		pressholdbtn.text = "Press"
	elif globalsettings.holdmode == true:
		pressholdbtn.text = "Hold"

func _on_ms_slidermusic_value_changed(value):
	var label = get_node("menucanvas/menusettings/ms_sound/ms_sound_menu/ms_slidermusic/ms_lblval")
	var slider = get_node("menucanvas/menusettings/ms_sound/ms_sound_menu/ms_slidermusic")
	
	label.text = str(slider.value) + "%"

func _on_ms_slidereffect_value_changed(value):
	var label = get_node("menucanvas/menusettings/ms_sound/ms_sound_menu/ms_slidereffect/ms_lblval")
	var slider = get_node("menucanvas/menusettings/ms_sound/ms_sound_menu/ms_slidereffect")
	
	label.text = str(slider.value) + "%"

func _on_ms_fullscreen_pressed():
	globalsettings.fullscreen()

func fullscreenCheck():
	if Input.is_action_just_released("fullscreen"):
		globalsettings.fullscreen()
	
	if OS.window_fullscreen == true:
		fullscreenbutton.pressed = true
	else:
		fullscreenbutton.pressed = false

func _on_ms_back_pressed():
	currentmenu_update(menumain)

"""
Help Menu Signals
"""

func _on_mh_next1_pressed():
	get_node("menucanvas/menuhelp/mh_cont1").visible = false
	get_node("menucanvas/menuhelp/mh_cont2").visible = true
	get_node("menucanvas/menuhelp/mh_cont3").visible = false

func _on_mh_next2_pressed():
	get_node("menucanvas/menuhelp/mh_cont1").visible = false
	get_node("menucanvas/menuhelp/mh_cont2").visible = false
	get_node("menucanvas/menuhelp/mh_cont3").visible = true

func _on_mh_next3_pressed():
	get_node("menucanvas/menuhelp/mh_cont1").visible = true
	get_node("menucanvas/menuhelp/mh_cont2").visible = false
	get_node("menucanvas/menuhelp/mh_cont3").visible = false
	currentmenu_update(menumain)
