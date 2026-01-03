extends RigidBody3D

func _ready() -> void:
	get_parent().get_parent().userInputs()
	while true:
		await get_tree().create_timer(3.0).timeout
		get_parent().get_parent().broadcast("What kills a Hedgehog?\nA. Grapes\nB. Honey\nC. A jar of lactose", 100.0)
		var answer = await get_parent().get_parent().userInput
		match answer.to_upper().strip_edges():
			"A": get_parent().get_parent().broadcast("Correct!") ; break
			"B": get_parent().get_parent().broadcast("Wrong. You just gave it dental decay.")
			"C": get_parent().get_parent().broadcast("Wrong. You just triggered its lactose intolerence.")
		await get_tree().create_timer(3.0).timeout
		get_parent().get_parent().broadcast("What kills a Hedgehog?\nA. Rasins\nB. Bread\nC. meat-based kitten biscuits", 100.0)
		answer = await get_parent().get_parent().userInput
		match answer.to_upper().strip_edges():
			"A": get_parent().get_parent().broadcast("Correct!") ; break
			"B": get_parent().get_parent().broadcast("Wrong. Oh no, you gave it 0 nutritional value.")
			"C": get_parent().get_parent().broadcast("No. Just no.")
	get_parent().get_parent().userInputs(false)
	for hog in get_parent().get_children(): hog.call_deferred("queue_free")
	var raisin = load("res://Entities/Companions/raisin.tscn").instantiate()
	if !is_inside_tree(): return
	raisin.global_position += Vector3(randf_range(-10, 10), randf_range(40, 60), randf_range(-10, 10))
	get_parent().get_parent().add_child(raisin)
	get_parent().get_parent().next.emit()
