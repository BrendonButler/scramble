extends CharacterBody2D

@export var speed = 250.0
@export var bullet_scene: PackedScene

@onready var hurt_box = $HurtBox
@onready var player_sprite = $PlayerSprite2D

var health = 3
var invincible = false
var invincibility_timer: SceneTreeTimer = null

signal health_changed(current_health: int)

func die() -> void:
	if invincibility_timer != null:
		invincibility_timer.time_left = 0
	
	get_parent().game_over()

func take_damage() -> void:
	if invincible:
		return
	
	health -= 1
	emit_signal("health_changed", health)
	invincible = true
	
	get_parent().shake(0.3, 5.0)
	player_sprite.modulate = Color(1, 0, 0, 1)
	await get_tree().create_timer(0.1).timeout
	player_sprite.modulate = Color(1, 1, 1, 1)
	
	if health <= 0:
		die()
		return
	
	invincibility_timer = get_tree().create_timer(1.5)
	await invincibility_timer.timeout
	
	invincible = false

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	
	if direction.x != 0:
		player_sprite.flip_h = direction.x < 0
	
	move_and_slide()
	
	# Clamp to screen
	var screen = get_viewport_rect()
	position.x = clamp(position.x, 0, screen.size.x)
	position.y = clamp(position.y, 0, screen.size.y)
	
	if not invincible:
		for body in hurt_box.get_overlapping_bodies():
			if body.is_in_group("enemies"):
				take_damage()
				break

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var bullet = bullet_scene.instantiate()
		bullet.position = global_position
		bullet.direction = (get_global_mouse_position() - global_position).normalized()
		
		get_parent().add_child(bullet)

func _ready() -> void:
	position = get_viewport_rect().size / 2
