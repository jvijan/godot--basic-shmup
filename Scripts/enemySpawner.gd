extends Node2D

@export var enemyScenes: Array[PackedScene] = []
@export var spawnInterval: float = 0.5
@export var spawnPoints: Array[Marker2D] = []
@export var player: Player

var lastSpawn = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lastSpawn -= delta
	if lastSpawn <= 0:
		spawnEnemy()
		lastSpawn = spawnInterval

func spawnEnemy():
	var spawnPoint = spawnPoints[randi() % spawnPoints.size()]
	var enemy = enemyScenes[randi() % enemyScenes.size()]

	var enemySpawned = enemy.instantiate()
	enemySpawned.global_position = spawnPoint.global_position
	if enemySpawned.aimAtPlayer:
		enemySpawned.playerPos = player.global_position
	get_parent().add_child(enemySpawned)
	enemySpawned.enemyDied.connect(player._on_enemy_died)
	player.gameFinished.connect(enemySpawned._on_player_game_finished)


func _on_player_game_finished(win: bool) -> void:
	queue_free()
