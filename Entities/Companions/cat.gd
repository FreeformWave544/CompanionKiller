extends RigidBody3D

func _process(_delta: float) -> void:
	if get_parent().get_parent().find_child("Player").global_position.y <= -10:
		get_tree().change_scene_to_file("res://Locations/Win.tscn")
