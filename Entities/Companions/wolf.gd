extends RigidBody3D

func _physics_process(delta: float) -> void:
	$NavigationAgent3D.target_position = get_parent().get_parent().find_child("Player").global_position
