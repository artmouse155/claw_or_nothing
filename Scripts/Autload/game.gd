extends Node
## Game Autoload. Handles scene switching events and interfaces between the MainScene and game_scenes.

enum Scenes {MAIN_MENU, STAGE_1, SHOP, CREDITS}

var sceneDict = {
	Scenes.MAIN_MENU : load("res://Scenes/GameScenes/main_menu.tscn"),
	Scenes.STAGE_1 : load("res://Scenes/GameScenes/stage_1.tscn"),
	Scenes.SHOP : load("res://Scenes/GameScenes/shop.tscn"),
	Scenes.CREDITS : load("res://Scenes/GameScenes/credits.tscn"),
}

var main_scene : MainScene
var is_transition_running: bool = false

var paused: bool = false

func set_paused(pause_value: bool = true, show_pause_screen: bool = true):
	paused = pause_value
	#TODO: Implement pause screen

#region Load Functions
func load_main_menu():
	main_scene.switch_scene(Scenes.MAIN_MENU)
	
func load_stage_1():
	main_scene.switch_scene(Scenes.STAGE_1)
	
func load_shop():
	main_scene.switch_scene(Scenes.SHOP)

func load_credits():
	main_scene.switch_scene(Scenes.CREDITS)
#endregion

func quit_game():
	get_tree().quit()

func _input(ev):
	if Input.is_action_just_pressed("quit"):
		quit_game()
