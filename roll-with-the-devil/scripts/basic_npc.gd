extends RigidBody2D

@export var blob: PackedScene
@export var player_version: PackedScene


func get_absorbed():
	if player_version:
		var instance = player_version.instantiate()
		get_tree().root.get_child(0).add_child(instance)
		instance.position = position
		queue_free()
	else:
		print("Error: player_version is not assigned!")
