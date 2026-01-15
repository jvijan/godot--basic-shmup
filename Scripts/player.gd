extends Actor

@export var speed: float = 10000000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("playerUp"):
		position.y -= (speed * delta)
	elif Input.is_action_pressed("playerDown"):
		position.y += (speed * delta)
	if Input.is_action_pressed("playerRight"):
		position.x += (speed * delta)
	elif Input.is_action_pressed("playerLeft"):
		position.x -= (speed * delta)
