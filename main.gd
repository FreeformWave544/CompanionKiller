extends Node3D
signal next
signal userInput(input)
@export var companions: Array[PackedScene]

func _ready() -> void:
	next_test()

func userInputs(state: bool = true) -> void:
	$Player/PanelContainer.visible = state
	if $Player/PanelContainer.visible: $Player/PanelContainer/Input.call_deferred("grab_focus")

func next_test() -> void:
	for i in len(companions):
		var index = 25 - i
		broadcast(str(index) + " " + companions[i].instantiate().name + "(s)")
		for _i in range(index):
			var CompanionInstance = companions[i].instantiate()
			$CompanionSpawn.add_child(CompanionInstance)
			CompanionInstance.global_position = $CompanionSpawn.global_position + Vector3(randf_range(-50, 50), 0.0, randf_range(-50, 50))
			await get_tree().create_timer(0.1).timeout
		await next
		next_emitted = false

func broadcast(cast, duration = 2.0):
	$Player/CenterContainer/Label.text = cast
	await get_tree().create_timer(duration).timeout
	if $Player/CenterContainer/Label.text == cast: $Player/CenterContainer/Label.text = ""

var next_emitted := false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("skip"):  next.emit()
	if next_emitted: return
	for i in range($ShapeCast3D.get_collision_count()):
		if !$ShapeCast3D.get_collider(i) or !is_inside_tree() or $ShapeCast3D.get_collider(i).is_in_group("Companion"): return
	next_emitted = true
	next.emit()
