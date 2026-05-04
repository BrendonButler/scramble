extends CharacterBody2D

@export var speed = 200.0

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	
	move_and_slide()
	
	# Clamp to screen
	var screen = get_viewport_rect()
	position.x = clamp(position.x, 0, screen.size.x)
	position.y = clamp(position.y, 0, screen.size.y)
