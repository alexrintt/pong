extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var PlayerScn = load("res://Player/Player.tscn")
var BackgroundScn = load("res://Common/Background/SolidBackground.tscn")
var BallScn = load("res://Common/Ball/Ball.tscn")
var CounterScn = load("res://Game/Counter/Counter.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	_set_background_size()
	_set_players_positions()
	_set_ball_position()
	_gen_world_walls()
	_set_counter_position()

func _set_counter_position():
	add_child(CounterScn.instance())

func viewport():
	return get_viewport().size

func _set_players_positions():
	var width = viewport().x
	var OFFSET = width / 10
	add_child(_gen_player_position(OFFSET))
	add_child(_gen_player_position(width - OFFSET, true))

func _gen_player_position(x, arrows=false):
	var player = PlayerScn.instance()
	player.position = Vector2(x, viewport().y / 2)
	player.arrows = arrows
	return player

func _set_ball_position():
	var ball = BallScn.instance()
	add_child(ball)

func _set_background_size():
	var size = get_viewport().size
	var background = BackgroundScn.instance()
	background.texture.width = size.x
	background.texture.height = size.y
	background.transform = background.transform.translated(size / 2)
	add_child(background)

func _gen_world_walls():
	var SIZE = 20
	var OFFSET = 20

	var viewport = get_viewport().size
	var top = _gen_wall(Vector2(OFFSET, OFFSET), Vector2(viewport.x - OFFSET * 2, SIZE))
	var bottom = _gen_wall(Vector2(OFFSET, viewport.y - OFFSET - SIZE), Vector2(viewport.x - OFFSET * 2, SIZE))
	var left = _gen_wall(Vector2(OFFSET, OFFSET), Vector2(SIZE, viewport.y - OFFSET * 2))
	var right = _gen_wall(Vector2(viewport.x - OFFSET - SIZE, OFFSET), Vector2(SIZE, viewport.y - OFFSET * 2))
	
	var container = StaticBody2D.new()
	container.collision_layer = 2
	container.collision_mask = 2
	container.add_child(top)
	container.add_child(bottom)
	container.add_child(left)
	container.add_child(right)
	add_child(container)

func _gen_wall(position: Vector2, size: Vector2):
	var texture = ColorRect.new()
	texture.color = Color.white
	texture.rect_size = size
	texture.rect_position = -size / 2

	var shape = RectangleShape2D.new()
	shape.extents = size / 2
	var collider = CollisionShape2D.new()
	collider.shape = shape
	collider.transform.origin = position + size / 2
	collider.add_child(texture)

	return collider
	
