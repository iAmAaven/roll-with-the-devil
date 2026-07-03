extends Camera2D

# The node to follow, typically the player.
@export var target_path: NodePath

# Limits for the X-axis (set to -INF/INF if you don't want limits).
@export var x_min_limit: float = -1000.0
@export var x_max_limit: float = 1000.0

# Internal reference to the target node.
var target: Node = null

func _ready() -> void:
	if target_path != null:
		target = get_node(target_path)
	else:
		push_warning("Target path is not set. Camera will not follow anything.")

func _process(delta: float) -> void:
	if target == null:
		return

	# Get the target's global position.
	var target_position = target.global_position

	# Clamp the camera's X position within the limits.
	var clamped_x = clamp(target_position.x, x_min_limit, x_max_limit)

	# Set the camera's position (only adjusting X).
	position.x = clamped_x
