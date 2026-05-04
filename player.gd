extends CharacterBody2D

@export var speed = 250.0
@export var bullet_scene: PackedScene

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	
	move_and_slide()
	
	# Clamp to screen
	var screen = get_viewport_rect()
	position.x = clamp(position.x, 0, screen.size.x)
	position.y = clamp(position.y, 0, screen.size.y)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var bullet = bullet_scene.instantiate()
		bullet.position = global_position
		bullet.direction = (get_global_mouse_position() - global_position).normalized()
		
		get_parent().add_child(bullet)

func _ready() -> void:
	position = get_viewport_rect().size / 2
