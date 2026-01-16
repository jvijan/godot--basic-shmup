extends Actor

@export var speed: float = 10000000
@export var fireSpeed: float = 0.25
@export var actorScene: PackedScene
@export var shootSpawn: Vector2

var lastFired: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lastFired -= delta
	if Input.is_action_pressed("playerUp"):
		position.y -= (speed * delta)
	elif Input.is_action_pressed("playerDown"):
		position.y += (speed * delta)
	if Input.is_action_pressed("playerRight"):
		position.x += (speed * delta)
	elif Input.is_action_pressed("playerLeft"):
		position.x -= (speed * delta)
	if Input.is_action_just_pressed("fireTheo"):
		if lastFired <= 0:
			# Spawn theo and shoot
			spawnActor()
			lastFired = fireSpeed
			
func spawnActor():
	var newActor = actorScene.instantiate()
	newActor.global_position = global_position + shootSpawn
	get_parent().add_child(newActor)
