extends Node

class_name PlayerStateMachine

@export var player : CharacterBody2D
@export var current_state : State
@export var air_state : State
@export var death_state : State
@export var default_state : State
@export var animation_tree : AnimationTree

var states : Array[State]

func _ready():
	for child in get_children():
		if(child is State):
			states.append(child)
			
			child.character = player
			child.playback = animation_tree["parameters/playback"]
		else:
			push_warning("Child " + child.name + " is not a State")

func _input(event : InputEvent):
	current_state.state_input(event)

func _physics_process(delta: float) -> void:
	if(current_state.next_state != null):
		switch_states(current_state.next_state)
		
	current_state.state_process(delta)

func switch_states(new_state : State):
	if(current_state != null):
		current_state.on_exit()
		current_state.next_state = null
	
	current_state = new_state
	
	current_state.on_enter()

func check_if_can_move():
	return current_state.can_move

func set_death_state():
	switch_states(death_state)

func set_default_state():
	switch_states(default_state)
