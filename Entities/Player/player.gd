extends CharacterBody3D
class_name Player

@export var SPEED := 5.0
@export var JUMP_VELOCITY := 4.5

@export var mouse_sensitivity := 0.003
@export var mouse_smoothing_speed := 12.0

@export var crouch_camera_offset := 0.2
@export var bob_amplitude := 0.1
@export var bob_speed := 6.0

@export var sprint_fov_multiplier := 0.7
@export var fov_lerp_in := 20.0
@export var fov_lerp_out := 30.0

@onready var camera: Camera3D = $Camera3D
@onready var start_fov := camera.fov
@onready var start_cam_y := camera.position.y

var target_mouse := Vector2.ZERO
var mouse_motion := Vector2.ZERO
var pitch := 0.0

var bob_time := 0.0
var is_crouching := false


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"): Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_CAPTURED
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		target_mouse = Vector2(-event.relative.x, event.relative.y) * mouse_sensitivity

func _physics_process(delta: float) -> void:
	$AnimationTree.set("parameters/blend_position", Vector2(((velocity.x + velocity.z) / 2), velocity.y).normalized())
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED: return
	mouse_motion = mouse_motion.lerp(target_mouse, mouse_smoothing_speed * delta)
	rotate_y(mouse_motion.x)
	pitch -= mouse_motion.y
	pitch = clampf(pitch, deg_to_rad(-90), deg_to_rad(90))
	camera.rotation.x = pitch
	is_crouching = Input.is_action_pressed("crouch")
	var target_y := start_cam_y - (crouch_camera_offset if is_crouching else 0.0)
	camera.position.y = lerp(camera.position.y, target_y, 0.25)
	var sprinting := Input.is_action_pressed("sprint") and not is_crouching
	var target_fov := start_fov / sprint_fov_multiplier if sprinting else start_fov
	camera.fov = lerp(
		camera.fov,
		target_fov,
		delta * (fov_lerp_in if sprinting else fov_lerp_out)
	)
	var input_dir := Input.get_vector("ui_right", "ui_left", "ui_down", "ui_up")
	if input_dir.length() > 0.0 and is_on_floor():
		bob_time += delta * bob_speed
		camera.position.y += sin(bob_time) * bob_amplitude
	else:
		bob_time = 0.0
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
	target_mouse = Vector2.ZERO
