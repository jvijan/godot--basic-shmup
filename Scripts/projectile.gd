extends Area2D

class_name Projectile

@export var speed: float = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	translate(Vector2.RIGHT * delta * speed)


func hit() -> void:
	queue_free()
