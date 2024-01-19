extends Control

func _start():
	BackGroundMusic.get_stream_playback()

func _on_start_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().change_scene_to_file("res://Scenes/Level/StartingScene.tscn")


func _on_settings_pressed():
	$SettingsMenu.visible = true


func _on_quit_pressed():
	get_tree().quit()
