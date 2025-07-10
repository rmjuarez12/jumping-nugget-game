extends Node

var has_reloaded: bool = false

func _manage_char_movement(can_move: bool) -> void:
  # Manage character movement
  var player = get_tree().get_root().get_node("Stage/MainPlayer")

  if player:
    player.velocity = Vector2.ZERO if not can_move else player.velocity
    player.state_machine.current_state.disable_gravity = !can_move
    player.state_machine.current_state.can_move = can_move

func _focus_camera_on_object(object: Node) -> void:
  # Focus the camera on a specific object
  var camera = get_tree().get_root().get_node("Stage/Camera2D")
  
  if camera:
    camera.set_offset(object.position - camera.get_global_position())
    camera.current = true

func _stop_stage_timer() -> void:
  # Stop the stage timer
  var game_manager = get_tree().get_root().get_node("Stage/GameManager")
  
  if game_manager:
    game_manager._stop_stage_timer()

func _start_stage_timer() -> void:
  # Start the stage timer
  var game_manager = get_tree().get_root().get_node("Stage/GameManager")

  if game_manager:
    game_manager._start_stage_timer()
