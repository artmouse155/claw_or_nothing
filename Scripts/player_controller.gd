extends RigidBody2D

const THRUST = 15
const WATER_RESISTANCE = 3
var velocity = Vector2.ZERO

func _input(event):
	pass
	
func _physics_process(delta):
	var a = Input.is_action_pressed
	if a.call("left"):
		velocity += (Vector2.LEFT * THRUST * delta)
	if a.call("right"):
		velocity += (Vector2.RIGHT * THRUST * delta)
	if a.call("up"):
		velocity += (Vector2.UP * THRUST * delta)
	if a.call("down"):
		velocity += (Vector2.DOWN * THRUST * delta)
	velocity *= 1 - (WATER_RESISTANCE * delta)
	move_and_collide(velocity)
	$Label.text = "Speed: " + str(velocity)
