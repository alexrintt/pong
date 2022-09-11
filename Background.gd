	extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var points = []

# func generate_point():
#	var x = get_parent()
#	return Vector2(x, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	#for i in range(0, 10):
		#points.append(generate_point())
	pass

func _draw():
	return
	for point in points:
		draw_circle(point, 5, Color.white)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in range(0, len(points)):
		points[i] = Vector2(points[i].x, points[i].y + 1)
