extends Label

var level = 0

func _process(delta) -> void:
	text = "Level: %s" % level

