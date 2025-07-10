extends Node

var has_reloaded: bool = false

@export var game_data: Dictionary = {
	"gems": 0,
	"deaths": 20,
	"time": "00:00",
  "gems_count": 0,
  "timeMins": 0,
  "timeSecs": 0
}

var game_performance: Dictionary = {
  "gem_percentage": 0.0,
  "time_performance": 0.0,
  "death_performance": 0.0,
  "overall_performance": 0.0
}

func _get_final_veredict() -> String:
  # Determine the final veredict based on overall performance
  var overall_performance = game_performance["overall_performance"]

  if overall_performance >= 90.0:
    return "It seems I underestimated you! I Owe You an Apology. I Wasn't Really Familiar With Your Game!"
  elif overall_performance >= 75.0 and overall_performance < 90.0:
    return "Not too bad... Perhaps you are a gamer after all. But you still have a lot to learn!"
  elif overall_performance >= 50.0 and overall_performance < 75.0:
    return "Are you kidding me? You call yourself a gamer? Stick to game “journalism”"
  elif overall_performance >= 25.0 and overall_performance < 50.0:
    return "Disappointing... There is no amount of buffs that can help you be better. You are a lost cause..."
  else:
    return "Terrible! With those skills, you probably play Guilty Gear Strive a lot..."

func _calculate_performance() -> void:
  # Calculate percentage of gems collected
  var gems_collected = game_data["gems"] * 1.0
  var total_gems = game_data["gems_count"] * 1.0
  var gem_percentage = 0.0

  gem_percentage = (gems_collected / total_gems) * 100.0

  #calculate time performance
  var perfect_time = 60 * 2
  var good_time = 60 * 2 + 30
  var average_time = 60 * 3
  var time_performance = 0.0

  var time_taken = (game_data["timeMins"] * 60) + game_data["timeSecs"]

  if time_taken < perfect_time:
    time_performance = 100.0
  elif time_taken < good_time:
    time_performance = 75.0
  elif time_taken < average_time:
    time_performance = 50.0
  else:
    time_performance = 25.0

  # Calculate death performance
  var death_count = game_data["deaths"]
  var death_performance = 100.0

  if death_count == 0:
    death_performance = 100
  elif death_count > 0 and death_count < 5:
    death_performance = 75
  elif death_count >= 5 and death_count < 10:
    death_performance = 50
  elif death_count >= 10 and death_count < 20:
    death_performance = 25
  else:
    death_performance = 0

  # Calculate overall performance
  var overall_performance = (gem_percentage + time_performance + death_performance) /  3.0

  game_performance["gem_percentage"] = gem_percentage
  game_performance["time_performance"] = time_performance
  game_performance["death_performance"] = death_performance
  game_performance["overall_performance"] = round(overall_performance)

  print("Game Performance: ", game_performance)


func _fetch_game_data() -> void:
  var game_manager = get_tree().get_root().get_node("Stage/GameManager")
  
  if game_manager:
    game_data["gems"] = game_manager.game_data["gems"]
    game_data["deaths"] = game_manager.game_data["deaths"]
    game_data["gems_count"] = game_manager.gem_nodes.size()
    game_data["timeMins"] = game_manager.game_data["timeMins"]
    game_data["timeSecs"] = game_manager.game_data["timeSecs"]
    
    var seconds = game_manager.game_data["timeSecs"]
    var minutes = game_manager.game_data["timeMins"]

    if seconds < 10:
      seconds = "0" + str(seconds)
    else:
      seconds = str(seconds)

    if minutes < 10:
      minutes = "0" + str(minutes)
    else:
      minutes = str(minutes)

    game_data["time"] = minutes + ":" + seconds

    print("Game Data: ", game_data)

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

func _restart_stage() -> void:
  DialogueState.has_reloaded = true
  get_tree().reload_current_scene()

func _exit_game() -> void:
  get_tree().quit()