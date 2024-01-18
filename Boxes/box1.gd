extends StaticBody3D # Or RigidBody, depending on your setup

var velocity = Vector3()  # The movement velocity of the box
var move_speed = 5  # Adjust the speed as needed
var start_position = Vector3()
var max_height = 10


func _ready():
	start_position = global_transform.origin
	if $Area:
		print("Area node found")
	else:
		print("Area node not found")


func _process(delta):
	if is_player_on_top:
		if global_transform.origin.y - start_position.y < max_height:
			velocity.y = move_speed
		else:
			velocity.y = 0
	else:
		velocity.y = 0

	translate(velocity * delta)

var is_player_on_top = false 


func _on_area_body_entered(body):
	if body.is_in_group("Player"):
		is_player_on_top = true
		ScoreLabel.level += 1


func _on_area_body_exited(body):
	if body.is_in_group("Player"):
		is_player_on_top = false
