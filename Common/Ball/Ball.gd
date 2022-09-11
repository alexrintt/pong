extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2(0, 0)
onready var rand = load("res://Common/WithRandom.gd").new()
var MIN_VELOCITY = 2.0
var ACCELERATION = MIN_VELOCITY / 20

func center():
	return get_viewport().size / 2

func _ready():
	position = center()

func _random_direction():
	return -1 if rand.rand() >= 0.5 else 1

func _random_vector():
	var x = MIN_VELOCITY / 2 * rand.rand()
	var y = MIN_VELOCITY / 2 * rand.rand()
	
	return Vector2((MIN_VELOCITY + x) * _random_direction(), (MIN_VELOCITY + y) * _random_direction())
	

func _draw():
	var collider = get_node("Collider")
	var radius = collider.shape.radius
	draw_circle(collider.position, radius, Color.red)

func _play_impact():
	var audio = get_parent().get_node("ImpactSfx") as AudioStreamPlayer
	audio.play()

func _play_point():
	var audio = get_parent().get_node("PointSfx") as AudioStreamPlayer
	audio.play()


func _process(delta):
	if Input.is_key_pressed(KEY_SPACE) and velocity == Vector2.ZERO:
		velocity = _random_vector()

	var collision = move_and_collide(velocity)
	if collision != null:
		if abs(collision.normal.x) >= 0.9 and not collision.collider.is_class("KinematicBody2D"):
			_play_point()
			var leftPlayerPoint = sign(collision.normal.x) == -1
			var rightPlayerPoint = sign(collision.normal.x) == 1
			if leftPlayerPoint:
				get_parent().get_node("Counter").increment(1, 0)
			elif rightPlayerPoint:
				get_parent().get_node("Counter").increment(0, 1)
			velocity = Vector2.ZERO
			position = center()
		else:
			_play_impact()
			var reflect = collision.remainder.bounce(collision.normal)
			velocity = velocity.bounce(collision.normal)
			move_and_collide(reflect)
			velocity += Vector2(sign(velocity.x) * ACCELERATION, sign(velocity.y) * ACCELERATION)
