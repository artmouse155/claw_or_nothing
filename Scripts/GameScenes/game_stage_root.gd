extends GameScene

## The root node for displaying game stages.
class_name GameStageRoot

@export var level_viewport: SubViewport

var current_level = -1

func load_level(level: int):
	if level in Game.levelDict.keys():
		var old_level = get_current_level()
		var new_level = Game.levelDict[level].instantiate()
		level_viewport.add_child(new_level)
		level_viewport.move_child(new_level, 0)
		if old_level:
			old_level.queue_free()
			await old_level.tree_exited
		current_level = level
	else:
		print("Error: level %s" % [str(level)])
		
func get_current_level():
	for child in level_viewport.get_children():
		if child is Stage:
			return child
	print("No Level Found!")
	return null

func main_menu():
	Game.load_main_menu()
