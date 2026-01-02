extends CharacterBody3D
class_name Player

@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5

func _physics_process(delta: float) -> void:
	$AnimationTree.set("parameters/blend_position", Vector2(((velocity.x + velocity.z) / 2), velocity.y).normalized())
	if not is_on_floor(): velocity += get_gravity() * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_down", "ui_up")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
