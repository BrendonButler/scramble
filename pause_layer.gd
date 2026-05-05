extends CanvasLayer

func pause() -> void:
	get_tree().paused = true
	show()

func resume() -> void:
	get_tree().paused = false
	hide()

func _ready() -> void:
	hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_pause"):
		if get_tree().paused and visible:
			resume()
		elif not get_tree().paused:
			pause()

func _on_resume_button_pressed() -> void:
	resume()

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menu.tscn")
