extends CanvasLayer

func retry() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _ready() -> void:
	hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and visible:
		retry()

func _on_retry_button_pressed() -> void:
	retry()

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menu.tscn")
