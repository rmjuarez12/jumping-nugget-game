extends State

class_name AirState

@export var jump_velocity : float = -400.0
@export_range(0,1) var decelerate_on_jump_release : float = 0.5

@export var second_jump_velocity : float = -600.0
@export var has_second_jump : bool = true
@export var second_jump_animation : String = "second_jump"

@export var sfx_jump : AudioStreamPlayer2D

@export var landing_state : State

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump") && has_second_jump):
		second_jump()

	if(event.is_action_released("jump")):
		cancel_jump()

func state_process(delta):
	if(character.is_on_floor()):
		next_state = landing_state

func on_exit():
	if(next_state == landing_state):
		has_second_jump = true

# Handle jump cancel, in case player lets go early of button
func cancel_jump():
	character.velocity.y *= decelerate_on_jump_release

# Handle second jump
func second_jump():
	character.velocity.y = second_jump_velocity
	playback.travel(second_jump_animation)
	has_second_jump = false
	sfx_jump.play()