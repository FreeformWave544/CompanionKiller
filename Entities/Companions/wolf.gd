extends CharacterBody3D

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

func _physics_process(delta: float) -> void:
	navigation_agent_3d.target_position = get_parent().get_parent().find_child("Player").global_position
	var destination = navigation_agent_3d.get_next_path_position()
	var local_destination = destination - global_position
	var direction = local_destination.normalized()
	velocity = direction * 4.5
	if not is_on_floor(): velocity += get_gravity() * delta
	move_and_slide()
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider is Player:
			await get_tree().create_timer(3.0).timeout
			for _i in range(get_slide_collision_count()):
				collision = get_slide_collision(i)
				collider = collision.get_collider()
				if collider is Player:
					get_tree().reload_current_scene()
					break

func _ready() -> void:
	await get_tree().create_timer(30.0).timeout
	get_parent().get_parent().next.emit()
	get_parent().get_parent().broadcast("Wolves killed the sheep! ;3")
	queue_free()
