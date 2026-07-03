extends CharacterBody2D

@export var move_speed = 70.0
@export var acceleration = 15.0

@onready var graphics = $AnimatedSprite2D
@onready var ray_cast: RayCast2D = $RayCast2D

var move_direction
var going_right = true
var direction = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_attacking = false
var is_hiding = false
var can_takeover = false

var closest_npc: RigidBody2D = null


func _process(_delta):
	if is_hiding:
		return
	
	if ray_cast.is_colliding():
		
		var collider = ray_cast.get_collider()
		
		if collider.is_in_group("NPC") and !can_takeover:
			can_takeover = true
			closest_npc = collider
			print_debug("Can takeover " + closest_npc.to_string())
		
	else:
		if(closest_npc != null):
			print_debug("Cannot takeover " + closest_npc.to_string() + " anymore...")
		closest_npc = null
		can_takeover = false
	
	if(can_takeover and Input.is_action_just_pressed("attack")):
		takeover()


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


func takeover():
	if closest_npc != null:
		print_debug("You just took over " + closest_npc.to_string() + "!")
		closest_npc.get_absorbed()
		queue_free()

func hide_the_player():
	is_hiding = true
	hide()

func reveal_the_player():
	is_hiding = false
	show()
