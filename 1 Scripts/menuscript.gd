extends Node2D

"""
Variable Initalisation
"""

#Menu Node Variables
onready var menuwelcome = get_node("menucanvas/menuwelcome")
onready var menumainPath = "menucanvas/menumain"
onready var menumain = get_node(menumainPath)
onready var menuplayPath = "menucanvas/menuplay"
onready var menuplay = get_node(menuplayPath)
onready var menucustomPath = "menucanvas/menucustom"
onready var menucustom = get_node(menucustomPath)
onready var menustorePath = "menucanvas/menustore"
onready var menustore = get_node(menustorePath)
onready var menusettingsPath = "menucanvas/menusettings"
onready var menusettings = get_node(menusettingsPath)
onready var menuhelpPath = "menucanvas/menuhelp"
onready var menuhelp = get_node(menuhelpPath)

onready var transitionroot = get_node("transitioncanvas/transitionroot")

#Main Menu Vars
onready var currentmenu = menuwelcome

onready var mainCustom = get_node(menumainPath + "/mm_custombtn")

#Play Menu Vars

onready var playStart = get_node(menuplayPath + "/mp_start")

onready var playScore = get_node(menuplayPath + "/mp_scorepanel/mp_scorevalue")
onready var playCoins = get_node(menuplayPath + "/mp_coinpanel/mp_coinvalue")

onready var currentmode = 0
onready var mpbuttons = []

onready var mpbuttonscorevalues = [
	0, 3, 5, 7, 10, 20, 25, 50, 75, 100
]

onready var mpinfoBase = get_node(menuplayPath + "/mp_infopanel/mp_infobase")
onready var mpinfoArray = []

onready var mpcolourDict = {}

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

onready var storeMoneyDialog = get_node("menucanvas/menustore/mt_moneydialog")
onready var storeScoreDialog = get_node("menucanvas/menustore/mt_pointdialog")

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

#Help Menu Vars

onready var helpCont1 = get_node("menucanvas/menuhelp/mh_cont1")
onready var helpCont2 = get_node("menucanvas/menuhelp/mh_cont2")
onready var helpCont3 = get_node("menucanvas/menuhelp/mh_cont3")

#Focus Buttons

onready var mainFocus = get_node("menucanvas/menumain/mm_playbtn")
onready var playFocus = get_node("menucanvas/menuplay/mp_back")
onready var customFocus = get_node("menucanvas/menucustom/mc_back")
onready var storeFocus = get_node("menucanvas/menustore/mt_back")
onready var settingsFocus = get_node("menucanvas/menusettings/ms_back")


#For more efficent initalisation of nodes than hardcoding:
func NodeInitalise():
	
	#Play Menu Vars
	var btn_containers = get_tree().get_nodes_in_group("btn_containers")
	
	var mpbuttonsprefix = "menucanvas/menuplay/mp_scollcont/mp_hboxcont/mp_btncontainer"
	for i in range(btn_containers.size()):
		mpbuttons.append(get_node(mpbuttonsprefix + str(i + 1) + "/mp_op" + str(i + 1)))
	
	var mpinfosprefix = "menucanvas/menuplay/mp_infopanel/mp_info"
	for i in range(btn_containers.size()):
		mpinfoArray.append(get_node(mpinfosprefix + str(i + 1)))
	
	var mpcoloursprefix = "menucanvas/menuplay/mp_infopanel/"
	var mpcolournames = ["red", "blue", "purple", "green", "yellow", "pink"]
	for i in range(mpcolournames.size()):
		mpcolourDict[mpcolournames[i]] = get_node(mpcoloursprefix + mpcolournames[i])

# Called when the node enters the scene tree for the first time.
func _ready():
	
	NodeInitalise()
	
	if globalsettings.GetFirstload() == true:
		menuwelcome.visible = true
		globalsettings.SetFirstload(false)
	else:
		transitionroot.TransitionIn("transition_in", null)
		menumain.visible = true
		currentmenu = menumain
	
	
	mainFocus.grab_focus()
	resolution.add_item("Default")
	resolution.add_item("1366x768")
	resolution.add_item("1920x1080")
	
	UpdateProgression()
	
	UpdateStats()
	
	UpdateStore()
	
	# -- Settings Checks
	# - Graphics Checks
	VsyncCheck()
	ResolutionCheck()
	# - Gui Checks
	SpdgravCheck()
	FpsCheck()
	MoveCheck()
	StatusCheck()
	# - Gameplay Checks
	HoldmodeCheck()
	globalsettings.SaveGame()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	# Changes button status and allows for fullscreen change through f key
	FullscreenCheck()
	
	# Store Checks for when a purchase is made without enough currency
	NoMoneyCheck()
	NoScoreCheck()
	
	#Checks if a the player has just finished transitioning into a new menu
	TransitionedOut()

func UpdateStats():
	storeScore.text = str(globalsettings.GetHighscore())
	playScore.text = str(globalsettings.GetHighscore())
	storeCoins.text = str(globalsettings.GetCurrency())
	playCoins.text = str(globalsettings.GetCurrency())

"""
Menu Update Signals
"""

func CurrentmenuUpdate(newcurrent):
	match newcurrent:
		menumain:
			mainFocus.grab_focus()
		menuplay:
			playFocus.grab_focus()
		menucustom:
			customFocus.grab_focus()
		menustore:
			storeFocus.grab_focus()
		menusettings:
			settingsFocus.grab_focus()
		menuhelp:
			pass
	
	currentmenu.visible = false
	newcurrent.visible = true
	currentmenu = newcurrent

func _unhandled_input(event):
	if menuwelcome.visible == true:
		if event is InputEventKey:
			transitionroot.ResetSmooth()
			currentmenu = menuwelcome
			if globalsettings.GetFirstrun() == true:
				transitionroot.Play("fade_in", "fade_out", menuhelp)
				globalsettings.SetFirstrun(false)
			elif transitionroot.animationPlaying == false:
				transitionroot.Play("transition_in", "fade_out", menumain)

func TransitionedOut():
	if transitionroot.transitionedOut == true:
		CurrentmenuUpdate(transitionroot.currentMenu)

	
"""
Main Menu Signals
"""

func _on_mm_playbtn_pressed():
	globalsettings.SetGlobalgrav(40)
	transitionroot.Play("transition_in", "transition_out", menuplay)

func _on_mm_custombtn_pressed():
	transitionroot.Play("transition_in", "transition_out", menucustom)

func _on_mm_storebtn_pressed():
	transitionroot.Play("transition_in", "transition_out", menustore)

func _on_mm_settingsbtn_pressed():
	transitionroot.Play("fade_in", "transition_out", menusettings)

func _on_mm_helpbtn_pressed():
	transitionroot.Play("fade_in", "transition_out", menuhelp)
	helpCont1.visible = true
	helpCont2.visible = false
	helpCont3.visible = false

func _on_mm_quitbtn_pressed():
	globalsettings.SaveGame()
	get_tree().quit()

"""
Play Menu Signals
"""

func _on_mp_back_pressed():
	transitionroot.Play("transition_in", "transition_out", menumain)

func TogglemodeCheck(num):
	playStart.disabled = false
	for but in mpbuttons:
		but.pressed = false
	
	currentmode = num + 1
	
	ColourpanelCheck(currentmode)
	
	mpbuttons[num].pressed = true

func ColourpanelCheck(num):
	
	mpinfoBase.text = ""
	
	for colour in mpcolourDict:
		mpcolourDict[colour].visible = false
	
	for info in mpinfoArray:
		info.visible = false
	
	match num:
		1:
			mpinfoArray[num - 1].visible = true
			mpcolourDict["red"].visible = true
		2:
			mpinfoArray[num - 1].visible = true
			mpcolourDict["red"].visible = true
			mpcolourDict["blue"].visible = true
		3:
			mpinfoArray[num - 1].visible = true
			mpcolourDict["red"].visible = true
			mpcolourDict["blue"].visible = true
			mpcolourDict["purple"].visible = true
		4:
			mpinfoArray[num - 1].visible = true
			mpcolourDict["red"].visible = true
		5:
			mpinfoArray[num - 1].visible = true
			mpcolourDict["green"].visible = true
		6:
			mpinfoArray[num - 1].visible = true
			mpcolourDict["blue"].visible = true
			mpcolourDict["green"].visible = true
		7:
			mpinfoArray[num - 1].visible = true
			mpcolourDict["red"].visible = true
			mpcolourDict["yellow"].visible = true
		8:
			mpinfoArray[num - 1].visible = true
			mpcolourDict["pink"].visible = true
		9:
			mpinfoArray[num - 1].visible = true
			mpcolourDict["green"].visible = true
			mpcolourDict["yellow"].visible = true
			mpcolourDict["pink"].visible = true
		10:
			mpinfoArray[num - 1].visible = true
			mpcolourDict["red"].visible = true
			mpcolourDict["blue"].visible = true
			mpcolourDict["purple"].visible = true
			mpcolourDict["green"].visible = true
			mpcolourDict["yellow"].visible = true
			mpcolourDict["pink"].visible = true

func _on_mp_op1_pressed():
	globalsettings.SetGamemode("Standard")
	TogglemodeCheck(0)

func _on_mp_op2_pressed():
	globalsettings.SetGamemode("Take It Slow")
	TogglemodeCheck(1)

func _on_mp_op3_pressed():
	globalsettings.SetGamemode("Reverse")
	TogglemodeCheck(2)

func _on_mp_op4_pressed():
	globalsettings.SetGamemode("Lava")
	TogglemodeCheck(3)

func _on_mp_op5_pressed():
	globalsettings.SetGamemode("Rapid")
	TogglemodeCheck(4)

func _on_mp_op6_pressed():
	globalsettings.SetGamemode("Fluctuant")
	TogglemodeCheck(5)

func _on_mp_op7_pressed():
	globalsettings.SetGamemode("Gravity")
	TogglemodeCheck(6)

func _on_mp_op8_pressed():
	globalsettings.SetGamemode("Powerup")
	TogglemodeCheck(7)

func _on_mp_op9_pressed():
	globalsettings.SetGamemode("Lunacy")
	TogglemodeCheck(8)

func _on_mp_op10_pressed():
	globalsettings.SetGamemode("Rainbow")
	TogglemodeCheck(9)

func UpdateProgression():
	for i in range(mpbuttons.size()):
		var currentReqScoreLabel;
		if globalsettings.GetHighscore() >= mpbuttonscorevalues[i]:
			mpbuttons[i].disabled = false
			currentReqScoreLabel = get_node(str(mpbuttons[i].get_path()) + "/mp_score")
			currentReqScoreLabel.visible = false
		else:
			mpbuttons[i].disabled = true
			currentReqScoreLabel = get_node(str(mpbuttons[i].get_path()) + "/mp_score")
			currentReqScoreLabel.visible = true
	
	if globalsettings.GetHighscore() < 100:
		mainCustom.disabled = true
	

func _on_mp_start_pressed():
	transitionroot.TransitionOut("transition_out", "Game")

"""
Custom Menu Signals
"""

func _on_mc_back_pressed():
	transitionroot.Play("transition_in", "transition_out", menumain)

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
	globalsettings.SetCustomData(customDataGet)
	globalsettings.SetGamemode("Custom")
	transitionroot.TransitionOut("transition_out", "Game")

"""
Store Menu Signals
"""

func UpdateStore():
	#Trails
	var storeTrailList = [
	storeTrailNoneButton, storeTrailGhostButton, storeTrailSnakeButton, storeTrailSmokeButton, storeTrailFlamesButton, storeTrailRainbowButton
	]
	for i in range(storeTrailList.size()):
		UpdateStoreTrail(storeTrailList[i], storeTrailNames[i], storeTrailPrices[i])
	#Backgrounds
	var storeBGList = [
	storeBGPlainButton, storeBGFadeButton, storeBGDiscoButton
	]
	for i in range (storeBGList.size()):
		UpdateStoreBg(storeBGList[i], storeBGNames[i], storeBGScoresNeeded[i])
	globalsettings.SaveGame()

func UpdateStoreTrail(button, mode, price):
	var trailsBought = globalsettings.GetTrailsBought()
	if trailsBought[mode] == true:
		if globalsettings.GetCurrentTrail() == mode:
			button.text = "Equipped"
		else:
			button.text = "Unequipped"
	else:
		button.text = str(price) + " Coins" 
	globalsettings.Save()

func UpdateStoreBg(button, mode, scoreneeded):
	var bgsUnlocked = globalsettings.GetBgsUnlocked()
	if bgsUnlocked[mode] == true:
		if globalsettings.GetCurrentBg() == mode:
			button.text = "Equipped"
		else:
			button.text = "Unequipped"
	else:
		button.text = "Score Over " + str(scoreneeded)
	globalsettings.Save()

func NoMoneyCheck():
	if globalsettings.GetNoMoney() == true:
		storeMoneyDialog.popup_centered_clamped()
		globalsettings.SetNoMoney(false)

func NoScoreCheck():
	if globalsettings.GetNoScore() == true:
		storeScoreDialog.popup_centered_clamped()
		globalsettings.SetNoScore(false)

func BuyTrailAttempt(num):
	globalsettings.BuyTrail(storeTrailNames[num], storeTrailPrices[num])
	UpdateStats()
	UpdateStore()

func UnlockBGAttempt(num):
	globalsettings.UnlockBg(storeBGNames[num], storeBGScoresNeeded[num])
	UpdateStore()

#Trail Buttons

func _on_mt_but0_pressed():
	BuyTrailAttempt(0)

func _on_mt_but1_pressed():
	BuyTrailAttempt(1)

func _on_mt_but2_pressed():
	BuyTrailAttempt(2)

func _on_mt_but3_pressed():
	BuyTrailAttempt(3)

func _on_mt_but4_pressed():
	BuyTrailAttempt(4)

func _on_mt_but5_pressed():
	BuyTrailAttempt(5)

#Background Buttons

func _on_mt_but1_bgs_pressed():
	UnlockBGAttempt(0)

func _on_mt_but2_bgs_pressed():
	UnlockBGAttempt(1)

func _on_mt_but3_bgs_pressed():
	UnlockBGAttempt(2)

func _on_mt_back_pressed():
	transitionroot.Play("transition_in", "transition_out", menumain)

"""
Settings Menu Signals
"""

func TogglemodesettingsCheck(num):
	for but in msbuttons:
		but.pressed = false
	
	msbuttons[num].pressed = true

func _on_ms_gd_pressed():
	TogglemodesettingsCheck(0)
	settinggd.visible = true
	settinggui.visible = false
	settingsound.visible = false
	settinggameplay.visible = false

func _on_ms_gui_pressed():
	TogglemodesettingsCheck(1)
	settinggd.visible = false
	settinggui.visible = true
	settingsound.visible = false
	settinggameplay.visible = false

func _on_ms_sound_pressed():
	TogglemodesettingsCheck(2)
	settinggd.visible = false
	settinggui.visible = false
	settingsound.visible = true
	settinggameplay.visible = false

func _on_ms_gameplay_pressed():
	TogglemodesettingsCheck(3)
	settinggd.visible = false
	settinggui.visible = false
	settingsound.visible = false
	settinggameplay.visible = true

func _on_ms_presshold_pressed():
	var holdmode = globalsettings.GetHoldmode()
	globalsettings.SetHoldmode(!holdmode)
	if globalsettings.GetHoldmode() == false:
		pressholdbtn.text = "Press"
	elif globalsettings.GetHoldmode() == true:
		pressholdbtn.text = "Hold"

func HoldmodeCheck():
	if globalsettings.GetHoldmode() == false:
		pressholdbtn.text = "Press"
	elif globalsettings.GetHoldmode() == true:
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
	globalsettings.Fullscreen()

func FullscreenCheck():
	if Input.is_action_just_released("fullscreen"):
		globalsettings.Fullscreen()
	if OS.window_fullscreen == true:
		fullscreenbutton.pressed = true
	else:
		fullscreenbutton.pressed = false
	ResolutionCheck()

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
	

func ResolutionCheck():
	
	match OS.window_size:
		Vector2(1920, 1080):
			resolution.select(2)
		Vector2(1366, 768):
			resolution.select(1)
		_:
			resolution.select(0)

# VSync Settings Functions

func _on_ms_vsync_pressed():
	var vsyncBool = globalsettings.GetVSync()
	globalsettings.SetVSync(vsyncBool)
	
	# --- reference start: https://godotengine.org/qa/27123/set-vsync-from-code-2-1-4
	var vsync = !OS.is_vsync_enabled()
	OS.set_use_vsync(vsync)
	# reference end ---
	

func VsyncCheck():
	if globalsettings.GetVSync() == true:
		vsyncbutton.pressed = true
	else:
		vsyncbutton.pressed = false

# Speed and Gravity Info Settings Functions

func _on_ms_spdgrav_pressed():
	var spdgravInfo = globalsettings.GetSpdGravInfo()
	globalsettings.SetSpdGravInfo(!spdgravInfo)

func SpdgravCheck():
	if globalsettings.GetSpdGravInfo() == true:
		spdgravbutton.pressed = true
	else:
		spdgravbutton.pressed = false

# FPS Info Functions

func _on_ms_fps_pressed():
	var fpsInfo = globalsettings.GetFpsInfo()
	globalsettings.SetFpsInfo(!fpsInfo)

func FpsCheck():
	if globalsettings.GetFpsInfo() == true:
		fpsbutton.pressed = true
	else:
		fpsbutton.pressed = false

# Move Box Info Functions

func _on_ms_movebox_pressed():
	var moveInfo = globalsettings.GetMoveInfo()
	globalsettings.SetMoveInfo(!moveInfo)

func MoveCheck():
	if globalsettings.GetMoveInfo() == true:
		movebutton.pressed = true
	else:
		movebutton.pressed = false

# Status Box Info Functions

func _on_ms_status_pressed():
	var statusInfo = globalsettings.GetStatusInfo()
	globalsettings.SetStatusInfo(!statusInfo)

func StatusCheck():
	if globalsettings.GetStatusInfo() == true:
		statusbutton.pressed = true
	else:
		statusbutton.pressed = false

func _on_ms_back_pressed():
	transitionroot.Play("transition_in", "fade_out", menumain)

"""
Help Menu Signals
"""

func _on_mh_next1_pressed():
	helpCont1.visible = false
	helpCont2.visible = true
	helpCont3.visible = false

func _on_mh_next2_pressed():
	helpCont1.visible = false
	helpCont2.visible = false
	helpCont3.visible = true

func _on_mh_next3_pressed():
	transitionroot.Play("transition_in", "fade_out", menumain)
