extends RigidBody3D

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	for i in range(state.get_contact_count()):
		var collider = state.get_contact_collider_object(i)
		if collider:
			print("RAISINS >~< collided with:", collider.name)
			if collider.is_in_group("Raisin"):
				print("RAISIN ALERT")
				$CollisionShape3D.call_deferred("queue_free")
				$Raccoon2/AnimationPlayer.play("Death")
				await $Raccoon2/AnimationPlayer.animation_finished
				call_deferred("queue_free")
