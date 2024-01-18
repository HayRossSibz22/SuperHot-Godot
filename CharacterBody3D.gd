extends CharacterBody3D


var score = 0

# Movement vairables
const SPEED = 7
const SPRINTSPEED = 12
const JUMP_VELOCITY = 6
const X_SENSE = .005
const Y_SENSE = .005
const INVERT = false
var SPRINT = false
# Time variables
const minSpeed = 0.8
const multiplierSlow = .2
const multiplierFast = .4
const runSpeed = 2


# Additional variables for smooth movement
var is_decelerating = false
var deceleration_start_position = Vector3.ZERO
const BASE_ACCELERATION = 4
const BASE_DECELERATION = 3
const MIN_EFFECTIVE_ACCELERATION = 0.5  # Minimum acceleration to maintain responsiveness


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var neck :=$Neck
@onready var camera :=$Neck/Camera3D

@export var vel: int

func _unhandled_input(event):

	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		var invert = 1
		if INVERT:
			invert = -1
		if event is InputEventMouseMotion:
			neck.rotate_y(invert*-event.relative.x * X_SENSE)
			camera.rotate_x(invert*-event.relative.y * Y_SENSE)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-30), deg_to_rad(60))

func _physics_process(delta):
	# Calculate scaled acceleration and deceleration based on time scale
	var effective_acceleration = max(BASE_ACCELERATION / Engine.time_scale, MIN_EFFECTIVE_ACCELERATION)
	var effective_deceleration = max(BASE_DECELERATION *5 / Engine.time_scale, MIN_EFFECTIVE_ACCELERATION)
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor()):
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var current_speed
	SPRINT = Input.is_action_pressed("sprint")
	if SPRINT:
		current_speed = SPRINTSPEED
	else:
		current_speed = SPEED
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * current_speed, effective_acceleration * delta)
		velocity.z = move_toward(velocity.z, direction.z * current_speed, effective_acceleration * delta)
		is_decelerating = false
	else:
		velocity.x = move_toward(velocity.x, 0, effective_deceleration * delta)
		velocity.z = move_toward(velocity.z, 0, effective_deceleration * delta)

	move_and_slide()

func _process(delta):
	var playerSpeed = velocity.length()-velocity.y

	if playerSpeed < minSpeed:
		Engine.time_scale = minSpeed
	elif playerSpeed < runSpeed:
		Engine.time_scale = lerp(minSpeed, runSpeed * multiplierSlow, playerSpeed / runSpeed)
	else:
		Engine.time_scale = 1



