extends GameScene

## The root node for displaying game stages.
class_name GameStageRoot

# NOTE:
# Let's try to use this for the structure of communicating between the level and the root:
# https://gameprogrammingpatterns.com/observer.html
# Basically, the level emits signals and the root catches them and updates the UI and level variables accordingly.

@export var level_viewport: SubViewport

var current_level = -1

#region player_vars
enum {HEALTH, MONEY}
var max_health = 10
var health = max_health
var money = 0
#endregion

func load_level(level: int):
	if level in Game.levelDict.keys():
		var old_level = get_current_level()
		var new_level: Stage = Game.levelDict[level].instantiate()
		%GameOver.hide()
		#set variables
		health = max_health
		# bind signals
		new_level.took_damage.connect(func(x): took_damage(x))
		# update UI
		update_UI(HEALTH)
		# unpause
		Game.set_paused(false, false)
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

func took_damage(damage):
	health -= damage
	health = max(health,0)
	update_UI(HEALTH)
	if health <= 0:
		you_died()
		

func update_UI(element):
	match element:
		HEALTH:
			print("My new health is " + str(health))
			%Health.text = "Health\n" + "🖤".repeat(max_health - health) + "❤️".repeat(health)
	print("UI updated.")
	#TODO: Do something

func you_died():
	%GameOver.show()
	print("YOU DIED")
	Game.set_paused(true, false)

func try_again_button():
	load_level(current_level)
