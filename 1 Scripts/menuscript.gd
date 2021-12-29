extends Node2D

"""
Variable Initalisation
"""

#Menu Node Variables
onready var menuwelcome = get_node("menucanvas/menuwelcome")
onready var menumain = get_node("menucanvas/menumain")
onready var menuplay = get_node("menucanvas/menuplay")
onready var menucustom = get_node("menucanvas/menucustom")
onready var menustore = get_node("menucanvas/menustore")
onready var menusettings = get_node("menucanvas/menusettings")
onready var menuhelp = get_node("menucanvas/menuhelp")

onready var transitionroot = get_node("transitioncanvas/transitionroot")

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

onready var mpbuttonscorelabels = [
	
]

onready var mpbuttonscorevalues = [
	0, 3, 5, 7, 10, 20, 25, 50, 75, 100
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

#Store Menu Vars
onready var storeScore = get_node("menucanvas/menustore/mt_score/mp_scorevalue")
onready var storeCoins = get_node("menucanvas/menustore/mt_coins/mp_coinvalue")

onready var storeTrailNoneButton = get_node("menucanvas/menustore/mt_trails/mt_themescrollcont/mt_hboxscrollcont/mt_item0/mt_but0")
onready var storeTrailGhostButton = get_node("menucanvas/menustore/mt_trails/mt_themescrollcont/mt_hboxscrollcont/mt_item1/mt_but1")
onready var storeTrailSnakeButton = get_node("menucanvas/menustore/mt_trails/mt_themescrollcont/mt_hboxscrollcont/mt_item2/mt_but2")
onready var storeTrailSmokeButton = get_node("menucanvas/menustore/mt_trails/mt_themescrollcont/mt_hboxscrollcont/mt_item3/mt_but3")
onready var storeTrailFlamesButton = get_node("menucanvas/menustore/mt_trails/mt_themescrollcont/mt_hboxscrollcont/mt_item4/mt_but4")
onready var storeTrailRainbowButton = get_node("menucanvas/menustore/mt_trails/mt_themescrollcont/mt_hboxscrollcont/mt_item5/mt_but5")

var storeTrailNames = [
	"none", "ghost", "snake", "smoke", "flames", "rainbow"
]

var storeTrailPrices = [
	0, 25, 75, 150, 500, 1000
]

onready var storeBGPlainButton = get_node("menucanvas/menustore/mt_themes/mt_themescrollcont/mt_hboxscrollcont/mt_item1/mt_but1_bgs")
onready var storeBGFadeButton = get_node("menucanvas/menustore/mt_themes/mt_themescrollcont/mt_hboxscrollcont/mt_item2/mt_but2_bgs")
onready var storeBGDiscoButton = get_node("menucanvas/menustore/mt_themes/mt_themescrollcont/mt_hboxscrollcont/mt_item3/mt_but3_bgs")

var storeBGNames = [
	"plain", "fade", "disco"
]

var storeBGScoresNeeded = [
	0, 100, 500
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
onready var vsyncbutton = get_node("menucanvas/menusettings/ms_g+d/ms_g+d_menu/ms_vsync")
onready var resolution = get_node("menucanvas/menusettings/ms_g+d/ms_g+d_menu/ms_resolution")
var resWidth = 0;
var resHeight = 0;

onready var spdgravbutton = get_node("menucanvas/menusettings/ms_gui/ms_gui_menu/ms_spdgrav")
onready var fpsbutton = get_node("menucanvas/menusettings/ms_gui/ms_gui_menu/ms_fps")
onready var movebutton = get_node("menucanvas/menusettings/ms_gui/ms_gui_menu/ms_movebox")
onready var statusbutton = get_node("menucanvas/menusettings/ms_gui/ms_gui_menu/ms_status")

onready var pressholdbtn = get_node("menucanvas/menusettings/ms_gameplay/ms_gameplay_menu/ms_presshold")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if globalsettings.firstload == true:
		menuwelcome.visible = true
		globalsettings.firstload = false
	else:
		transitionroot.transitionIn("transition_in", null)
		menumain.visible = true
		currentmenu = menumain
	
	get_node("menucanvas/menumain/mm_playbtn").grab_focus()
	resolution.add_item("Default")
	resolution.add_item("1366x768")
	resolution.add_item("1920x1080")
	
	updateProgression()
	
	updateStats()
	
	updateStore()
	
	# -- Settings Checks
	# - Graphics Checks
	vsyncCheck()
	resolutionCheck()
	# - Gui Checks
	spdgravCheck()
	fpsCheck()
	moveCheck()
	statusCheck()
	# - Gameplay Checks
	holdmodeCheck()
	globalsettings.save_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	# Changes button status and allows for fullscreen change through f key
	fullscreenCheck()
	
	# Store Checks for when a purchase is made without enough currency
	noMoneyCheck()
	noScoreCheck()
	
	#Checks if a the player has just finished transitioning into a new menu
	transitionedOut()

func updateStats():
	storeScore.text = str(globalsettings.highscore)
	get_node("menucanvas/menuplay/mp_scorepanel/mp_scorevalue").text = str(globalsettings.highscore)
	storeCoins.text = str(globalsettings.currency)
	get_node("menucanvas/menuplay/mp_coinpanel/mp_coinvalue").text = str(globalsettings.currency)

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
	
	currentmenu.visible = false
	newcurrent.visible = true
	currentmenu = newcurrent

func _unhandled_input(event):
	if menuwelcome.visible == true:
		if event is InputEventKey:
			transitionroot.resetSmooth()
			currentmenu = menuwelcome
			print(transitionroot.animationPlaying)
			if globalsettings.firstrun == true:
				transitionroot.play("fade_in", "fade_out", menuhelp)
				globalsettings.firstrun = false
			elif transitionroot.animationPlaying == false:
				transitionroot.play("transition_in", "fade_out", menumain)

func transitionedOut():
	if transitionroot.transitionedOut == true:
		currentmenu_update(transitionroot.currentMenu)

	
"""
Main Menu Signals
"""

func _on_mm_playbtn_pressed():
	globalsettings.globalgrav = 40
	transitionroot.play("transition_in", "transition_out", menuplay)

func _on_mm_custombtn_pressed():
	transitionroot.play("transition_in", "transition_out", menucustom)

func _on_mm_storebtn_pressed():
	transitionroot.play("transition_in", "transition_out", menustore)

func _on_mm_settingsbtn_pressed():
	transitionroot.play("fade_in", "transition_out", menusettings)

func _on_mm_helpbtn_pressed():
	transitionroot.play("fade_in", "transition_out", menuhelp)
	get_node("menucanvas/menuhelp/mh_cont1").visible = true
	get_node("menucanvas/menuhelp/mh_cont2").visible = false
	get_node("menucanvas/menuhelp/mh_cont3").visible = false

func _on_mm_quitbtn_pressed():
	globalsettings.save_game()
	get_tree().quit()

"""
Play Menu Signals
"""

func _on_mp_back_pressed():
	transitionroot.play("transition_in", "transition_out", menumain)

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

func updateProgression():
	for i in range(mpbuttons.size()):
		if globalsettings.highscore >= mpbuttonscorevalues[i]:
			mpbuttons[i].disabled = false
			get_node(str(mpbuttons[i].get_path()) + "/mp_score").visible = false
		else:
			mpbuttons[i].disabled = true
			get_node(str(mpbuttons[i].get_path()) + "/mp_score").visible = true
	
	if globalsettings.highscore < 100:
		get_node("menucanvas/menumain/mm_custombtn").disabled = true
	

func _on_mp_start_pressed():
	transitionroot.transitionOut("transition_out", "Game")

"""
Custom Menu Signals
"""

func _on_mc_back_pressed():
	transitionroot.play("transition_in", "transition_out", menumain)

func _on_mc_sliderblue_value_changed():	
	bluelabel.text = str(blueslider.value) + "%"

func _on_mc_sliderpurple_value_changed():
	purplelabel.text = str(purpleslider.value) + "%"

func _on_mc_slidergreen_value_changed():
	greenlabel.text = str(greenslider.value) + "%"

func _on_mc_slideryellow_value_changed():
	yellowlabel.text = str(yellowslider.value) + "%"

func _on_mc_sliderpink_value_changed():
	pinklabel.text = str(pinkslider.value) + "%"

func _on_mc_sliderred_value_changed():
	redlabel.text = str(redslider.value) + "%"

func _on_mc_sliderspd_value_changed():
	speedlabel.text = str(speedslider.value) + "%"

func _on_mc_slidergrav_value_changed():
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
	transitionroot.transitionOut("transition_out", "Game")

"""
Store Menu Signals
"""

func updateStore():
	#Trails
	var storeTrailList = [
	storeTrailNoneButton, storeTrailGhostButton, storeTrailSnakeButton, storeTrailSmokeButton, storeTrailFlamesButton, storeTrailRainbowButton
	]
	for i in range(storeTrailList.size()):
		updateStoreTrail(storeTrailList[i], storeTrailNames[i], storeTrailPrices[i])
	#Backgrounds
	var storeBGList = [
	storeBGPlainButton, storeBGFadeButton, storeBGDiscoButton
	]
	for i in range (storeBGList.size()):
		updateStoreBg(storeBGList[i], storeBGNames[i], storeBGScoresNeeded[i])
	globalsettings.save_game()

func updateStoreTrail(button, mode, price):
	if globalsettings.trailsBought[mode] == true:
		if globalsettings.currentTrail == mode:
			button.text = "Equipped"
		else:
			button.text = "Unequipped"
	else:
		button.text = str(price) + " Coins" 
	globalsettings.save()

func updateStoreBg(button, mode, scoreneeded):
	if globalsettings.bgsUnlocked[mode] == true:
		if globalsettings.currentBg == mode:
			button.text = "Equipped"
		else:
			button.text = "Unequipped"
	else:
		button.text = "Score Over " + str(scoreneeded)
	globalsettings.save()

func noMoneyCheck():
	if globalsettings.noMoney == true:
		get_node("menucanvas/menustore/mt_moneydialog").popup_centered_clamped()
		globalsettings.noMoney = false

func noScoreCheck():
	if globalsettings.noScore == true:
		get_node("menucanvas/menustore/mt_pointdialog").popup_centered_clamped()
		globalsettings.noScore = false

func buyTrailAttempt(num):
	globalsettings.buyTrail(storeTrailNames[num], storeTrailPrices[num])
	updateStats()
	updateStore()

func unlockBGAttempt(num):
	globalsettings.unlockBg(storeBGNames[num], storeBGScoresNeeded[num])
	updateStore()

#Trail Buttons

func _on_mt_but0_pressed():
	buyTrailAttempt(0)

func _on_mt_but1_pressed():
	buyTrailAttempt(1)

func _on_mt_but2_pressed():
	buyTrailAttempt(2)

func _on_mt_but3_pressed():
	buyTrailAttempt(3)

func _on_mt_but4_pressed():
	buyTrailAttempt(4)

func _on_mt_but5_pressed():
	buyTrailAttempt(5)

#Background Buttons

func _on_mt_but1_bgs_pressed():
	unlockBGAttempt(0)

func _on_mt_but2_bgs_pressed():
	unlockBGAttempt(1)

func _on_mt_but3_bgs_pressed():
	unlockBGAttempt(2)

func _on_mt_back_pressed():
	transitionroot.play("transition_in", "transition_out", menumain)

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
	if globalsettings.holdmode == false:
		pressholdbtn.text = "Press"
	elif globalsettings.holdmode == true:
		pressholdbtn.text = "Hold"

func holdmodeCheck():
	if globalsettings.holdmode == false:
		pressholdbtn.text = "Press"
	elif globalsettings.holdmode == true:
		pressholdbtn.text = "Hold"

func _on_ms_slidermusic_value_changed():
	var label = get_node("menucanvas/menusettings/ms_sound/ms_sound_menu/ms_slidermusic/ms_lblval")
	var slider = get_node("menucanvas/menusettings/ms_sound/ms_sound_menu/ms_slidermusic")
	
	label.text = str(slider.value) + "%"

func _on_ms_slidereffect_value_changed():
	var label = get_node("menucanvas/menusettings/ms_sound/ms_sound_menu/ms_slidereffect/ms_lblval")
	var slider = get_node("menucanvas/menusettings/ms_sound/ms_sound_menu/ms_slidereffect")
	
	label.text = str(slider.value) + "%"

# Fullscreen Settings Functions

func _on_ms_fullscreen_pressed():
	globalsettings.fullscreen()

func fullscreenCheck():
	if Input.is_action_just_released("fullscreen"):
		globalsettings.fullscreen()
	if OS.window_fullscreen == true:
		fullscreenbutton.pressed = true
	else:
		fullscreenbutton.pressed = false
	resolutionCheck()

# Resoltion Settings Functions

func _on_ms_resolution_item_selected(index):

	match index:
		1:
			resWidth = 1366
			resHeight = 768
		2:
			resWidth = 1920
			resHeight = 1080
	
	if index != 0:
		OS.window_fullscreen = false
		OS.window_size = Vector2(resWidth, resHeight)
	

func resolutionCheck():
	
	match OS.window_size:
		Vector2(1920, 1080):
			resolution.select(2)
		Vector2(1366, 768):
			resolution.select(1)
		_:
			resolution.select(0)

# VSync Settings Functions

func _on_ms_vsync_pressed():
	globalsettings.vsync = !globalsettings.vsync
	
	# --- reference start: https://godotengine.org/qa/27123/set-vsync-from-code-2-1-4
	var vsync = !OS.is_vsync_enabled()
	OS.set_use_vsync(vsync)
	# reference end ---
	

func vsyncCheck():
	if globalsettings.vsync == true:
		vsyncbutton.pressed = true
	else:
		vsyncbutton.pressed = false

# Speed and Gravity Info Settings Functions

func _on_ms_spdgrav_pressed():
	globalsettings.spdgravInfo = !globalsettings.spdgravInfo

func spdgravCheck():
	if globalsettings.spdgravInfo == true:
		spdgravbutton.pressed = true
	else:
		spdgravbutton.pressed = false

# FPS Info Functions

func _on_ms_fps_pressed():
	globalsettings.fpsInfo = !globalsettings.fpsInfo

func fpsCheck():
	if globalsettings.fpsInfo == true:
		fpsbutton.pressed = true
	else:
		fpsbutton.pressed = false

# Move Box Info Functions

func _on_ms_movebox_pressed():
	globalsettings.moveInfo = !globalsettings.moveInfo

func moveCheck():
	if globalsettings.moveInfo == true:
		movebutton.pressed = true
	else:
		movebutton.pressed = false

# Status Box Info Functions

func _on_ms_status_pressed():
	globalsettings.statusInfo = !globalsettings.statusInfo

func statusCheck():
	if globalsettings.statusInfo == true:
		statusbutton.pressed = true
	else:
		statusbutton.pressed = false

func _on_ms_back_pressed():
	transitionroot.play("transition_in", "fade_out", menumain)

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
	transitionroot.play("transition_in", "fade_out", menumain)
