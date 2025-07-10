extends CanvasLayer

@onready var main_menu: Panel = $Panel

@export var start_button: Button

@export var transition_fade: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(2).timeout
	main_menu.show()
	start_button.grab_focus()

func _on_start_game_pressed() -> void:
	var transition_instance = transition_fade.instantiate()
	get_tree().get_root().add_child(transition_instance)
	transition_instance.animation_player.play("fadein")

	await transition_instance.animation_player.animation_finished

	transition_instance.animation_player.play("fadeout")
	get_tree().change_scene_to_file("D:/apps/Godot/Projects/jumping-nugget/scenes/main.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
