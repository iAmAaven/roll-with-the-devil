class_name Player extends CharacterBody2D

@export var move_speed = 50.0
@export var acceleration = 15.0
@export var blob: PackedScene

@onready var graphics = $AnimatedSprite2D

var move_direction
var going_right = true
var direction = 1
var is_hiding = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _process(_delta):
	if is_hiding:
		return
	
	if Input.is_action_just_pressed("leave_body"):
		leave_this_body()

func _physics_process(delta):
	if is_hiding:
		velocity = Vector2.ZERO
		return
	
	handle_movement(delta)

func handle_movement(delta):
	move_direction = Input.get_axis("move_l", "move_r")
	velocity.y = gravity * delta * 3
	
	update_direction()
	update_animation()
	
	if move_direction:
		velocity.x = move_direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration)
	
	move_and_slide()

func update_direction():
	if move_direction > 0:
		direction = 1
		going_right = true
	elif move_direction < 0:
		direction = -1
		going_right = false

func update_animation():
	if move_direction:
		graphics.play("move")
		if going_right: graphics.flip_h = false
		else: graphics.flip_h = true
	else:
		graphics.play("idle")
		if going_right: graphics.flip_h = false
		else: graphics.flip_h = true

func leave_this_body():
	if blob == null:
		return
	
	var instance = blob.instantiate()
	get_tree().root.get_child(0).add_child(instance)
	instance.position = position
	queue_free()

func hide_the_player():
	is_hiding = true
	hide()

func reveal_the_player():
	is_hiding = false
	show()
