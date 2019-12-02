extends KinematicBody

onready var camera = $Pivot/Camera

###########################################
### The following is code for our main	###
### character, made by Christopher for	###
### one of our earlier projects. It 	###
###	works! 								###
###########################################


var jump_speed = 12 #value
var gravity = -30
var max_speed = 8
var mouse_sensitivity = 0.002 # radians per pixel (1/10th of a degree)

var velocity = Vector3()
var jump = false # property

func _ready():
	#get_tree().call_group("zombies","set_player",self)
	pass
		

func get_input():
	var input_dir = Vector3()
	jump = false
	if Input.is_action_just_pressed("jump"):
		jump = true
	# Figure out what direction we're trying to move in
	if Input.is_action_pressed("move_forward"):
		input_dir += -camera.global_transform.basis.z
	if Input.is_action_pressed("move_back"):
		input_dir += camera.global_transform.basis.z
	if Input.is_action_pressed("strafe_right"):
		input_dir += camera.global_transform.basis.x
	if Input.is_action_pressed("strafe_left"):
		input_dir += -camera.global_transform.basis.x
	if Input.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	input_dir = input_dir.normalized() # don't move faster if moving diagonal
	return input_dir

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -1.2, 1.2)
		

func _physics_process(delta):
	velocity.y += gravity * delta
	var desired_velocity = get_input() * max_speed
	# friction
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true)
	# true so you don't slide back down the ramp
	if jump and is_on_floor():
		velocity.y = jump_speed

func kill():
	pass
	### Eventually this will restart the game when the player dies.
	
