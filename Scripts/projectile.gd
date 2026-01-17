extends Area2D

class_name Projectile

@export var speed: float = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	translate(Vector2.RIGHT * delta * speed)


func _on_area_entered(area: Area2D) -> void:
	if area is Enemy:
		queue_free()
