extends Area2D

@export var scene_to_load: PackedScene

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") or body.is_in_group("Blob"):
		call_deferred("_change_scene")

func _change_scene() -> void:
	get_tree().change_scene_to_packed(scene_to_load)
