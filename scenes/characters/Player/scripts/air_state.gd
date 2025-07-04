extends State

class_name AirState

@export var jump_velocity : float = -400.0
@export_range(0,1) var decelerate_on_jump_release : float = 0.5

@export var second_jump_velocity : float = -800.0
@export var can_second_jump : bool = false
@export var has_second_jumped : bool = false
@export var second_jump_animation : String = "second_jump"

var feather : Area2D

@export var sfx_jump : AudioStreamPlayer2D

@export var landing_state : State

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump") && can_second_jump):
		second_jump()

	if(event.is_action_released("jump") && !has_second_jumped):
		cancel_jump()

func state_process(delta):
	if(character.is_on_floor()):
		next_state = landing_state
		has_second_jumped = false

# Handle jump cancel, in case player lets go early of button
func cancel_jump():
	character.velocity.y *= decelerate_on_jump_release

# Handle second jump
func second_jump():
	var direction := Input.get_axis("left", "right")

	var forward_velocity = 800

	if direction < 0:
		forward_velocity *= -1

	character.velocity.x = forward_velocity
	character.velocity.y = second_jump_velocity
	playback.travel(second_jump_animation)
	sfx_jump.play()

	has_second_jumped = true
	feather.already_used = true