extends Area2D

@export var speed = 400
@export var bullet_burst_scene: PackedScene

var direction = Vector2.ZERO

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		var burst = bullet_burst_scene.instantiate()
		burst.position = global_position
		get_parent().add_child(burst)
		burst.emitting = true
		body.die()
		queue_free()

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	rotation += 3.0 * delta
	
	# free when off screen
	if not get_viewport_rect().has_point(position):
		queue_free()
