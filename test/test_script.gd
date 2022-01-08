extends "res://addons/gut/test.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func test_essential_scenes_present():
	assert_file_exists('res://0 Scenes/game.tscn')
	assert_file_exists('res://0 Scenes/menu.tscn')
	assert_file_exists('res://0 Scenes/player.tscn')
	assert_file_exists('res://0 Scenes/transition.tscn')

func test_scripts_present():
	assert_file_exists('res://1 Scripts/gamescript.gd')
	assert_file_exists('res://1 Scripts/globalscript.gd')
	assert_file_exists('res://1 Scripts/menuscript.gd')
	assert_file_exists('res://1 Scripts/playerscript.gd')
	assert_file_exists('res://1 Scripts/transitionscript.gd')

func test_savefile_present():
	globalsettings.SaveGame()
	assert_file_exists('user://savegame.save')

func test_temp_global_vars_notnull():
	assert_not_null(globalsettings.GetFirstload())
	assert_not_null(globalsettings.GetGlobalgrav())
	assert_not_null(globalsettings.GetNoMoney())
	assert_not_null(globalsettings.GetNoScore())
	assert_not_null(globalsettings.GetCustomData())

func test_local_global_vars_notnull():
	assert_not_null(globalsettings.GetFirstrun())
	assert_not_null(globalsettings.GetHoldmode())
	assert_not_null(globalsettings.GetSpdGravInfo())
	assert_not_null(globalsettings.GetFpsInfo())
	assert_not_null(globalsettings.GetMoveInfo())
	assert_not_null(globalsettings.GetStatusInfo())
	assert_not_null(globalsettings.GetVSync())
	assert_not_null(globalsettings.GetHighscore())
	assert_not_null(globalsettings.GetCurrentTrail())

func test_local_global_vars_post_load_notnull():
	globalsettings.LoadGame()
	test_local_global_vars_notnull()
