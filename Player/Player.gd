extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var acceleration = Vector2(0, 0)

const ACCELERATION_FACTOR = 3.0

var arrows = false

var WITH_ACCELERATION = 0
var WITH_LINEAR_VELOCITY = 1
var mode = WITH_ACCELERATION

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true) 

func _draw():
	var collider = get_node("Collider")
	var extents = collider.shape.extents
	
	var color = ColorRect.new()
	color.rect_size = extents * 2
	color.rect_position = -extents

	add_child(color)

func _process(delta):
	if Input.is_key_pressed(KEY_1):
		mode = WITH_ACCELERATION
	if Input.is_key_pressed(KEY_2):
		mode = WITH_LINEAR_VELOCITY

	if Input.is_key_pressed(KEY_UP) if arrows else Input.is_key_pressed(KEY_W):
		if mode == WITH_LINEAR_VELOCITY:
			acceleration = Vector2(0, -ACCELERATION_FACTOR)
		else:
			acceleration += Vector2(0, -ACCELERATION_FACTOR / 20)
	elif (Input.is_key_pressed(KEY_DOWN) if arrows else Input.is_key_pressed(KEY_S)):
		if mode == WITH_LINEAR_VELOCITY:
			acceleration = Vector2(0, ACCELERATION_FACTOR)
		else:
			acceleration += Vector2(0, ACCELERATION_FACTOR / 20)
	else:
		if mode == WITH_LINEAR_VELOCITY:
			acceleration = Vector2.ZERO
	var collision = move_and_collide(acceleration)
	if collision != null:
		if not collision.collider.is_class("KinematicBody2D"):
			if collision.normal.y != 0:
				acceleration *= Vector2(1, 0)
			if collision.normal.x != 0:
				acceleration *= Vector2(0, 1)
