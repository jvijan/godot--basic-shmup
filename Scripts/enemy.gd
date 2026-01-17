extends Area2D

class_name Enemy

signal enemyDied(_score: int)

@export var speed: float
@export var aimAtPlayer: bool = false
@export var playerPos: Vector2
@export var health: int
@export var deathSfx: AudioStreamPlayer2D
@export var score: int

@onready var animatedSprite = $AnimatedSprite2D


var moveDir: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animatedSprite.play("default")
	if aimAtPlayer:
		moveDir = (playerPos - global_position).normalized()
	else:
		moveDir = Vector2.LEFT


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	translate(moveDir * speed * delta)
	if global_position.x < -50:
		queue_free()
	if health <= 0:
		die()


func die() -> void:
	animatedSprite.visible = false
	set_process(false)
	collision_layer = 0
	collision_mask = 0
	enemyDied.emit(score)
	if deathSfx:
		deathSfx.play()
		await deathSfx.finished
	queue_free()
	


func _on_area_entered(area: Area2D) -> void:
	if area is Projectile:
		health -= 1


func _on_player_game_finished(win: bool) -> void:
	queue_free()
