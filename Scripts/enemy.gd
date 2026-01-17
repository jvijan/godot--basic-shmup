extends Area2D

class_name Enemy

@export var speed: float
@export var aimAtPlayer: bool = false
@export var playerPos: CharacterBody2D
@export var health: int
@onready var animatedSprite = $AnimatedSprite2D

var moveDir: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animatedSprite.play("default")
	if aimAtPlayer:
		moveDir = (playerPos.global_position - global_position).normalized()
	else:
		moveDir = Vector2.LEFT


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	translate(moveDir * speed * delta)
	if health <= 0:
		queue_free()
		# Send signal to increase score
	


func _on_area_entered(area: Area2D) -> void:
	if area is Projectile:
		health -= 1
		area.hit()
