extends Label


func _process(delta) -> void:
	self.text = "Level: %s" % ScoreLabel.level
