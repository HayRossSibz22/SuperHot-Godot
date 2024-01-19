extends Node3D

@onready var animation_player = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():

	animation_player.get_animation("Walking").loop = true


func _process(delta):
	pass

