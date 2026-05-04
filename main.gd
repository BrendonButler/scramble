extends Node2D

@export var enemy_scene: PackedScene

@onready var player = $Player
@onready var enemy_spawner = $EnemySpawner

var score = 0

func game_over() -> void:
	$EnemySpawner.stop()
	$CanvasLayer/GameOverLabel.visible = true
	$CanvasLayer/RestartLabel.visible = true
	get_tree().paused = true

func _process(delta: float) -> void:
	score += delta
	$CanvasLayer/ScoreLabel.text = "Score: " + str(int(score))

func _ready() -> void:
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
