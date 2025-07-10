extends CanvasLayer

@onready var pause_menu: Panel = $Panel

@export var resume_button: Button

@export var pause_sfx: AudioStreamPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause_sfx.play()
		if get_tree().paused:
			pause_menu.visible = false
			get_tree().paused = false
		else:
			pause_menu.visible = true
			get_tree().paused = true
			resume_button.grab_focus()


func _on_resume_pressed() -> void:
	pause_sfx.play()
	pause_menu.visible = false
	get_tree().paused = false


func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_restart_level_pressed() -> void:
	DialogueState.has_reloaded = true
	get_tree().paused = false
	get_tree().reload_current_scene()
