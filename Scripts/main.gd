extends Control
## The main scene of the Game. This scene is always loaded.
class_name MainScene

# The first scene we will load in in our game
const FIRST_SCENE = Game.Scenes.MAIN_MENU

# The screen that appears as our loading screen
@export var transition_screen: Node

# 'Game.Scenes' enum value of current scene
var current_scene = -1

func _ready():
	Game.main_scene = self
	switch_scene(FIRST_SCENE, false)

## Function to switch the current scene.
func switch_scene(scene: int, do_transition: bool = true):
		# Pause the game while we make the transition
		Game.is_transition_running = true
		Game.set_paused(true, false)
		
		# Do transition if required
		if do_transition:
			await transition_screen.load_in()
		
		# Do the scene switch
		var old_scene = get_current_game_scene()
		var new_scene = await Game.sceneDict[scene].instantiate()
		add_child(new_scene)
		move_child(new_scene, 0)
		if old_scene:
			old_scene.queue_free()
			await old_scene.tree_exited
		current_scene = scene
		
		# Do transition if required
		if do_transition:
			await transition_screen.load_out()
		
		# Stop pausing the game
		Game.is_transition_running = false
		Game.set_paused(false, false)


## Function to get the currently active GameScene.
func get_current_game_scene():
	for child in get_children():
		if child is GameScene:
			return child
	print("No Scene Found!")
	return null
