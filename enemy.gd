extends CharacterBody2D

@export var speed = 100.0
@export var death_burst_scene: PackedScene

var player: Node2D

func _physics_process(_delta: float) -> void:
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		
		move_and_slide()

func die() -> void:
	var burst = death_burst_scene.instantiate()
	burst.position = global_position
	get_parent().add_child(burst)
	burst.emitting = true
	queue_free()
