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

onready var mpcolours_red = get_node("menucanvas/menuplay/mp_infopanel/red")
onready var mpcolours_blue = get_node("menucanvas/menuplay/mp_infopanel/blue")
onready var mpcolours_purple = get_node("menucanvas/menuplay/mp_infopanel/purple")
onready var mpcolours_green = get_node("menucanvas/menuplay/mp_infopanel/green")
onready var mpcolours_yellow = get_node("menucanvas/menuplay/mp_infopanel/yellow")
onready var mpcolours_pink = get_node("menucanvas/menuplay/mp_infopanel/pink")
onready var mpcolours = [
	mpcolours_red, mpcolours_blue, mpcolours_purple, mpcolours_green, mpcolours_yellow, mpcolours_pink
]

onready var mpinfo1 = get_node("menucanvas/menuplay/mp_infopanel/mp_info1")
onready var mpinfo2 = get_node("menucanvas/menuplay/mp_infopanel/mp_info2")
onready var mpinfo3 = get_node("menucanvas/menuplay/mp_infopanel/mp_info3")
onready var mpinfo4 = get_node("menucanvas/menuplay/mp_infopanel/mp_info4")
onready var mpinfo5 = get_node("menucanvas/menuplay/mp_infopanel/mp_info5")
onready var mpinfo6 = get_node("menucanvas/menuplay/mp_infopanel/mp_info6")
onready var mpinfo7 = get_node("menucanvas/menuplay/mp_infopanel/mp_info7")
onready var mpinfo8 = get_node("menucanvas/menuplay/mp_infopanel/mp_info8")
onready var mpinfo9 = get_node("menucanvas/menuplay/mp_infopanel/mp_info9")
onready var mpinfo10 = get_node("menucanvas/menuplay/mp_infopanel/mp_info10")
onready var mpinfobase = get_node("menucanvas/menuplay/mp_infopanel/mp_infobase")
onready var mpinfos = [
	mpinfo1, mpinfo2, mpinfo3, mpinfo4, mpinfo5, mpinfo6, mpinfo7, mpinfo8, mpinfo9, mpinfo10, mpinfobase
]


#Custom Menu Vars

onready var bluelabel = get_node("menucanvas/menucustom/mc_colours/mc_sliderblue/mc_lblval")
onready var blueslider = get_node("menucanvas/menucustom/mc_colours/mc_sliderblue")

onready var purplelabel = get_node("menucanvas/menucustom/mc_colours/mc_sliderpurple/mc_lblval")
onready var purpleslider =  get_node("menucanvas/menucustom/mc_colours/mc_sliderpurple")

onready var greenlabel = get_node("menucanvas/menucustom/mc_colours/mc_slidergreen/mc_lblval")
onready var greenslider =  get_node("menucanvas/menucustom/mc_colours/mc_slidergreen")

onready var yellowlabel = get_node("menucanvas/menucustom/mc_colours/mc_slideryellow/mc_lblval")
onready var yellowslider =  get_node("menucanvas/menucustom/mc_colours/mc_slideryellow")

onready var pinklabel = get_node("menucanvas/menucustom/mc_colours/mc_sliderpink/mc_lblval")
onready var pinkslider =  get_node("menucanvas/menucustom/mc_colours/mc_sliderpink")

onready var redlabel = get_node("menucanvas/menucustom/mc_colours/mc_sliderred/mc_lblval")
onready var redslider =  get_node("menucanvas/menucustom/mc_colours/mc_sliderred")

onready var speedlabel = get_node("menucanvas/menucustom/mc_spdgrav/mc_lbl_spd/mc_sliderspd/mc_lblval")
onready var speedslider = get_node("menucanvas/menucustom/mc_spdgrav/mc_lbl_spd/mc_sliderspd")

onready var gravlabel = get_node("menucanvas/menucustom/mc_spdgrav/mc_lbl_grav/mc_slidergrav/mc_lblval")
onready var gravslider = get_node("menucanvas/menucustom/mc_spdgrav/mc_lbl_grav/mc_slidergrav")

var customDataGet = {
	"redvalue": 0,
	"bluevalue": 0,
	"purplevalue": 0,
	"greenvalue": 0,
	"yellowvalue": 0,
	"pinkvalue": 0,
	"speedvalue": 100,
	"gravityvalue": 100
}

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
	get_node("menucanvas/menustore/mt_score/mp_scorevalue").text = str(globalsettings.highscore)
	get_node("menucanvas/menuplay/mp_scorepanel/mp_scorevalue").text = str(globalsettings.highscore)
	get_node("menucanvas/menustore/mt_coins/mp_coinvalue").text = str(globalsettings.currency)
	get_node("menucanvas/menuplay/mp_coinpanel/mp_coinvalue").text = str(globalsettings.currency)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fullscreenCheck()
	holdmodeCheck()
	noMoneyCheck()

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
	globalsettings.globalgrav = 40
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
	
	colourpanelcheck(currentmode)
	
	mpbuttons[num].pressed = true

func colourpanelcheck(num):
	
	for colour in mpcolours:
		colour.visible = false
	
	for info in mpinfos:
		info.visible = false
	
	match num:
		1:
			mpinfo1.visible = true
			mpcolours_red.visible = true
		2:
			mpinfo2.visible = true
			mpcolours_red.visible = true
			mpcolours_blue.visible = true
		3:
			mpinfo3.visible = true
			mpcolours_red.visible = true
			mpcolours_blue.visible = true
			mpcolours_purple.visible = true
		4:
			mpinfo4.visible = true
			mpcolours_red.visible = true
		5:
			mpinfo5.visible = true
			mpcolours_green.visible = true
		6:
			mpinfo6.visible = true
			mpcolours_blue.visible = true
			mpcolours_green.visible = true
		7:
			mpinfo7.visible = true
			mpcolours_red.visible = true
			mpcolours_yellow.visible = true
		8:
			mpinfo8.visible = true
			mpcolours_pink.visible = true
		9:
			mpinfo9.visible = true
			mpcolours_green.visible = true
			mpcolours_yellow.visible = true
			mpcolours_pink.visible = true
		10:
			mpinfo10.visible = true
			mpcolours_red.visible = true
			mpcolours_blue.visible = true
			mpcolours_purple.visible = true
			mpcolours_green.visible = true
			mpcolours_yellow.visible = true
			mpcolours_pink.visible = true

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
	bluelabel.text = str(blueslider.value) + "%"

func _on_mc_sliderpurple_value_changed(value):
	purplelabel.text = str(purpleslider.value) + "%"

func _on_mc_slidergreen_value_changed(value):
	greenlabel.text = str(greenslider.value) + "%"

func _on_mc_slideryellow_value_changed(value):
	yellowlabel.text = str(yellowslider.value) + "%"

func _on_mc_sliderpink_value_changed(value):
	pinklabel.text = str(pinkslider.value) + "%"

func _on_mc_sliderred_value_changed(value):
	redlabel.text = str(redslider.value) + "%"

func _on_mc_sliderspd_value_changed(value):
	speedlabel.text = str(speedslider.value) + "%"

func _on_mc_slidergrav_value_changed(value):
	gravlabel.text = str(gravslider.value) + "%"

func _on_mc_start_pressed():
	customDataGet.redvalue = redslider.value
	customDataGet.bluevalue = blueslider.value
	customDataGet.purplevalue = purpleslider.value
	customDataGet.greenvalue = greenslider.value
	customDataGet.yellowvalue = yellowslider.value
	customDataGet.pinkvalue = pinkslider.value
	customDataGet.speedvalue = speedslider.value
	customDataGet.gravityvalue = gravslider.value
	globalsettings.customData = customDataGet
	globalsettings.gamemode = "Custom"
	get_tree().change_scene("res://0 Scenes/game.tscn")

"""
Store Menu Signals
"""

func noMoneyCheck():
	if globalsettings.noMoney == true:
		get_node("menucanvas/menustore/mt_moneydialog").popup_centered_clamped()
		globalsettings.noMoney = false

func _on_mt_but1_pressed():
	globalsettings.buyTrail("ghost", 25)

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
