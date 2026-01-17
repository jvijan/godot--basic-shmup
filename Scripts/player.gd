extends CharacterBody2D

class_name Player

signal healthChange(_health: int)
signal gameFinished(win: bool)
signal scoreChange(_score: int)

@export var speed: float = 10000000
@export var fireSpeed: float = 0.25

@export var actorScene: PackedScene
@export var shootSpawn: Vector2

@export var shootSfx: AudioStreamPlayer2D
@export var hitSfx: AudioStreamPlayer2D
@export var deathSfx: AudioStreamPlayer2D
@export var gameOver: AudioStreamPlayer2D

@export var health: int
@export var invulnTime: float = 0.75
var lastHit = 0

@export var scoreToWin: int
var score = 0

@onready var animatedSprite = $AnimatedSprite2D

var lastFired: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animatedSprite.play("default")
	healthChange.emit(health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if score >= scoreToWin:
		gameFinished.emit(1)
		queue_free()
	lastFired -= delta
	lastHit -= delta
	# Update movement
	var moveDir = Input.get_vector("playerLeft", "playerRight", "playerUp", "playerDown")
	if moveDir:
		velocity = moveDir * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()
	# Check if Theo shot
	if Input.is_action_pressed("fireTheo"):
		if lastFired <= 0:
			# Spawn theo and shoot
			shootSfx.play()
			spawnActor()
			lastFired = fireSpeed
	checkCollisions()


func spawnActor():
	var newActor = actorScene.instantiate()
	newActor.global_position = global_position + shootSpawn
	get_parent().add_child(newActor)


func checkCollisions() -> void:
	if lastHit > 0:
		return
	var myArea = $Area2D
	for area in myArea.get_overlapping_areas():
		if area is Enemy and lastHit <= 0:
			health -= 1
			healthChange.emit(health)
			lastHit = invulnTime
			if health > 0:
				hitSfx.play()	
			else:
				deathSfx.play()
				animatedSprite.visible = false
				collision_layer = 0
				collision_mask = 0
				set_process(false)
				await deathSfx.finished
				gameFinished.emit(0)
				gameOver.play()
				await gameOver.finished
				queue_free()


func _on_enemy_died(_score: int) -> void:
	score += _score
	scoreChange.emit(_score)
