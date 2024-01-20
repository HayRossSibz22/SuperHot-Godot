extends Control

var _is_paused:bool = false:
	set(value):
		_is_paused = value
		get_tree().paused = _is_paused
		visible = _is_paused
		
		
func _set_pause():
	_is_paused = !_is_paused
	if _is_paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event: InputEvent)-> void:
	if event.is_action_pressed("pause"):
		_set_pause()

func _on_resume_btn_pressed():
		_set_pause()
	
func _on_settings_btn_pressed():
	$SettingsMenu.visible = true

func _on_respawn_btn_pressed():
	_set_pause()
	ScoreLabel.level = 0
	get_tree().reload_current_scene()

func _on_quit_btn_pressed():
	get_tree().quit()

