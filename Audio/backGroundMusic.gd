extends AudioStreamPlayer

func _ready():
	if not is_playing():
		play()
	
