extends Node3D

func _process(delta: float) -> void:
	if $Node3D/RayCast3D.is_colliding():
		for i in $Node3D/RayCast3D.get_collision_count():
			if $Node3D/RayCast3D.get_collider(i) is Player:
				look_at(Vector3($Node3D/RayCast3D.get_collider(i).global_position.x, 0, $Node3D/RayCast3D.get_collider(i).global_position.z))
				rotate_y(-90)
				break
