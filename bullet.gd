extends Area2D

@export var speed = 400

var direction = Vector2.ZERO

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	
	# free when off screen
	if not get_viewport_rect().has_point(position):
		queue_free()
