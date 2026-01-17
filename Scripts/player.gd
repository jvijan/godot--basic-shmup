extends CharacterBody2D

class_name Player

@export var speed: float = 10000000
@export var fireSpeed: float = 0.25
@export var actorScene: PackedScene
@export var shootSpawn: Vector2
@export var shootSfx: AudioStreamPlayer2D
@onready var animatedSprite = $AnimatedSprite2D

var lastFired: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animatedSprite.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lastFired -= delta
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
			
func spawnActor():
	var newActor = actorScene.instantiate()
	newActor.global_position = global_position + shootSpawn
	get_parent().add_child(newActor)
