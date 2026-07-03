extends Node2D

var can_hide = false
var player: Node2D


func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	if player == null:
		player = get_tree().get_first_node_in_group("Blob")

func _process(delta: float) -> void:
	if player == null:
		return
	
	if can_hide and Input.is_action_just_pressed("interact"):
		player.position = position
		if !player.is_hiding:
			player.hide_the_player()
		else:
			player.reveal_the_player()

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") or body.is_in_group("Blob"):
		print_debug("Hide now!")
		can_hide = true
		player = body

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player") or body.is_in_group("Blob"):
		can_hide = false
		player = null
