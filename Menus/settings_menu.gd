extends Control

var _in_settings:bool = false:
	set(value):
		_in_settings = value
		get_tree().paused = _in_settings
		visible = _in_settings


func _on_back_btn_pressed():
	_in_settings = false


