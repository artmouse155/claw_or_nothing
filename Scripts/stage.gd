extends Control
class_name Stage

#TODO: Flesh this system out
@export var player: PlayerController

signal coins_collected(amt)
signal took_damage(amt)
signal started_dialog(dialog)

func _ready():
	player.took_damage.connect(func(x): took_damage.emit(x))
