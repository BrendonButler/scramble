extends CanvasLayer

@onready var hearts = [
	$HealthHBoxContainer/HeartControl1/Heart1,
	$HealthHBoxContainer/HeartControl2/Heart2,
	$HealthHBoxContainer/HeartControl3/Heart3
]
@onready var game_over_label = $"../GameOverLayer/GameOverLabel"

func _on_health_changed(current_health: int) -> void:
	for i in hearts.size():
		hearts[i].frame = 1 if i < current_health else 0

func _ready() -> void:
	get_parent().get_node("Player").health_changed.connect(_on_health_changed)
