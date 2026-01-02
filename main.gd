extends Node3D

@export var companions: Array[PackedScene]

func _ready() -> void:
	var CompanionInstance = companions[0].instantiate()
	add_child(CompanionInstance)
	CompanionInstance.global_position = $CompanionSpawn.global_position
