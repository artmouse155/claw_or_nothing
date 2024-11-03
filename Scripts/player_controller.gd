class_name PlayerController extends CharacterBody2D

const THRUST : float = 600.0
const WATER_RESISTANCE : float = 3.0
#var velocity := Vector2.ZERO
const GRAVITY : float = 4.0
const BOUNCE_STRENGTH : float = 1.6
const COLLISION_DAMAGE_MIN : float = 20.0
var prev_velocity : Vector2
var speed : float:
	get:
		return velocity.length()

signal took_damage(int)

func _input(event : InputEvent) -> void:
	return
	
func snappedv2(v : Vector2, step : float) -> Vector2:
	return Vector2(snappedf(v.x, step), snappedf(v.y, step))

func is_equal_approx_v2(v1 : Vector2, v2: Vector2) -> bool:
	return is_equal_approx(v1.x, v2.x) and is_equal_approx(v1.y, v2.y)

func _physics_process(delta : float) -> void:
	var a = Input.is_action_pressed
	var moving_vertical : bool = false
	if a.call("left"):
		velocity += (Vector2.LEFT * THRUST * delta)
	if a.call("right"):
		velocity += (Vector2.RIGHT * THRUST * delta)
	if a.call("up"):
		moving_vertical = true
		velocity += (Vector2.UP * THRUST * delta)
	if a.call("down"):
		moving_vertical = true
		velocity += (Vector2.DOWN * THRUST * delta)
	velocity *= 1 - (WATER_RESISTANCE * delta)
	#if abs(velocity.y) <= 2.0: velocity += GRAVITY * delta
	if not moving_vertical: velocity.y += GRAVITY
	if not is_equal_approx_v2(velocity, Vector2.ZERO):
		prev_velocity = velocity
	move_and_slide()
	
	if get_slide_collision_count():
		print("collision v: ", prev_velocity)
		var collision : KinematicCollision2D = get_slide_collision(0)
		#velocity = velocity.bounce(collision.get_normal())
		velocity = prev_velocity.bounce(collision.get_normal()) * BOUNCE_STRENGTH
		take_damage()
	
	$Label.text = "Speed: " + str(snappedv2(velocity, 0.1))
	return

func take_damage() -> void:
	# Flash color
	modulate = Color.RED
	await get_tree().create_timer(0.2).timeout
	modulate = Color.WHITE
	
	print("speed: ", speed)
	if speed > COLLISION_DAMAGE_MIN:
		took_damage.emit(1)
	
	return
