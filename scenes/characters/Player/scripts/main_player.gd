extends CharacterBody2D

# Walking vars
@export var walk_speed = 300.0
@export var run_speed = 600.0
@export_range(0,1) var deceleration = 0.1
@export_range(0,1) var acceleartion = 0.08

# Node refs
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine: PlayerStateMachine = $PlayerStateMachine

func _ready():
	animation_tree.active = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and state_machine.current_state.name != "Death" and not state_machine.current_state.disable_gravity:
		velocity += get_gravity() * delta

	# Move the character
	handle_char_movement()
	move_and_slide()
	
	# Flip sprite depending on direction
	handle_char_flip();

# Handle main character movement on ground
func handle_char_movement():
	var direction := Input.get_axis("left", "right")
	var speed = walk_speed
	
	# Increase speed if running
	if Input.is_action_pressed("run"):
		speed = run_speed
	
	# Get the input direction and handle the movement/deceleration.
	if direction && state_machine.check_if_can_move():
		velocity.x = move_toward(velocity.x, direction * speed, speed * acceleartion)
	else:
		velocity.x = move_toward(velocity.x, 0, walk_speed * deceleration)
	
	# Set animation to running when moving
	animation_tree.set("parameters/Move/blend_position", velocity.x)

# Handle flipping sprite depending on direction
func handle_char_flip():
	if velocity.x < 0:
		sprite_2d.flip_h = true
	elif velocity.x > 0:
		sprite_2d.flip_h = false
