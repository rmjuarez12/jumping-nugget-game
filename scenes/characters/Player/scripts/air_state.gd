extends State

class_name AirState

@export var jump_velocity : float = -400.0
@export_range(0,1) var decelerate_on_jump_release : float = 0.5

@export var can_second_jump : bool = false
@export var has_second_jumped : bool = false
@export var second_jump_animation : String = "second_jump"
var second_jump_type : String

var feather : Area2D

@export var sfx_jump : AudioStreamPlayer2D
@export var ghost_effect : GPUParticles2D
@export var ghost_timer : Timer

@export var landing_state : State

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump") && can_second_jump):
		second_jump()

	if(event.is_action_released("jump") && !has_second_jumped):
		cancel_jump()

func state_process(_delta):
	if(character.is_on_floor()):
		next_state = landing_state
		has_second_jumped = false

# Handle jump cancel, in case player lets go early of button
func cancel_jump():
	character.velocity.y *= decelerate_on_jump_release

# Handle second jump
func second_jump():
	var direction := Input.get_axis("left", "right")

	character.position = feather.position

	var forward_velocity = 800
	var second_jump_velocity : float = -800.0

	if second_jump_type == "blue":
		forward_velocity = 1200
		second_jump_velocity = 0
		disable_gravity = true

	if direction < 0:
		forward_velocity *= -1
	
	character.velocity.x = forward_velocity
	character.velocity.y = second_jump_velocity

	playback.travel(second_jump_animation)
	sfx_jump.play()

	has_second_jumped = true
	feather.already_used = true
	can_move = false

	ghost_effect.emitting = true
	ghost_timer.start()

func _on_ghost_timer_timeout() -> void:
	ghost_effect.emitting = false
	has_second_jumped = false
	disable_gravity = false
	can_move = true
