extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func get_label(name):
	return get_node(name)

func center():
	return get_viewport().size / 2

func gap():
	return get_viewport().size.x / 2 / 5

func increment(left=0, right=0):
	if left != 0:
		var label_left = get_label("Left") as Label
		label_left.text = str(value("Left") + left)
	if right != 0:
		var label_right = get_label("Right") as Label
		label_right.text = str(value("Right") + right)

func value(label):
	return int(get_node(label).text)

func _ready():
	modulate.a = 0.3
	_set_label_position(get_label("Right") as Label, gap())
	_set_label_position(get_label("Left") as Label, -gap())

func _set_label_position(label, gap):
	var size = label.rect_size
	label.rect_position = center() + Vector2(gap, -center().y / 2) - size / 2
	label.text = "0"

func _process(delta):
	if Input.is_key_pressed(KEY_R):
		increment(-value("Left"), -value("Right"))
