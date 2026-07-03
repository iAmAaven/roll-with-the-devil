extends Node2D

const ELLA = preload("res://scenes/player_scenes/ella.tscn")
@onready var blob_fall: AnimatedSprite2D = $DumpsterAnimated/BlobFall

func _ready() -> void:
	
	await get_tree().create_timer(2.4).timeout
	
	var instance = ELLA.instantiate()
	get_tree().root.get_child(0).add_child(instance)
	instance.position = Vector2(-70, 0)
	
	if instance != null:
		blob_fall.queue_free()
