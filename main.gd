extends Node2D

@export var enemy_scene: PackedScene

@onready var camera = $MainCam2D
@onready var player = $Player
@onready var enemy_spawner = $EnemySpawner
@onready var pause_layer = $PauseLayer
@onready var game_over_layer = $GameOverLayer
@onready var score_label = $HudLayer/ScoreLabel

var score = 0
var shake_intensity = 0.0
var shake_duration = 0.0

func game_over() -> void:
	enemy_spawner.stop()
	game_over_layer.show()
	get_tree().paused = true

func shake(duration: float, intensity: float) -> void:
	shake_duration = duration
	shake_intensity = intensity

func _process(delta: float) -> void:
	score += delta
	score_label.text = "Score: " + str(int(score))
	
	var new_wait = max(0.5, 2.0 - (score * 0.02))
	enemy_spawner.wait_time = new_wait
	
	if shake_duration > 0:
		shake_duration -= delta
		camera.offset = Vector2(
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity)
		)
	else:
		camera.offset = Vector2.ZERO

func _ready() -> void:
	camera.position = get_viewport_rect().size / 2
	enemy_spawner.start()

func _on_enemy_spawner_timeout() -> void:
	var screen = get_viewport_rect()
	var side = randi() % 4
	var pos = Vector2.ZERO
	
	match side:
		0: pos = Vector2(randf_range(0, screen.size.x), 0)
		1: pos = Vector2(randf_range(0, screen.size.x), screen.size.y)
		2: pos = Vector2(0, randf_range(0, screen.size.y))
		3: pos = Vector2(screen.size.x, randf_range(0, screen.size.y))
	
	var enemy = enemy_scene.instantiate()
	enemy.position = pos
	enemy.player = player
	
	add_child(enemy)

func _notification(what: int) -> void:
	if what == NOTIFICATION_APPLICATION_FOCUS_IN:
		Engine.max_fps = 30
		OS.low_processor_usage_mode = false
	elif what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		if not get_tree().paused:
			Engine.max_fps = 1
			OS.low_processor_usage_mode = true
			pause_layer.pause()
