extends CanvasLayer

@onready var hearts = [
	$HBoxContainer/Heart1,
	$HBoxContainer/Heart2,
	$HBoxContainer/Heart3
]

func _on_health_changed(current_health: int) -> void:
	for i in hearts.size():
		hearts[i].color = Color.from_rgba8(234, 68, 65, 200) if i < current_health else Color.from_rgba8(0, 0, 0, 0)

func _ready() -> void:
	get_parent().get_node("Player").health_changed.connect(_on_health_changed)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and $GameOverLabel.visible:
		get_tree().paused = false
		get_tree().reload_current_scene()
