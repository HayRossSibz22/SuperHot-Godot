extends Node

var current_floor = 1
var loaded_floors = []
var floors = ["res://Floors/Floor1.tscn", "res://Floors/Floor2.tscn", "res://Floors/Floor3.tscn"]  # Path to your floor scenes
var score = 0

func _process(delta):
	var player_y = $Player.global_transform.origin.y  # Adjust based on your player node's path
	var new_floor = calculate_floor_based_on_height(player_y)
#	if new_floor>score:
#		$UI/ScoreLabel._new_floor.bind()
#		score = new_floor
#	

func calculate_floor_based_on_height(player_y):
	# Implement logic based on your game's floor heights
	var floor_number = int(1 + player_y/10)
	return floor_number


