class_name WithRandom

var rand = RandomNumberGenerator.new()

func get_r():
	return RandomNumberGenerator.new()

func rand():
	var r = get_r()
	r.randomize()
	return r.randf()
