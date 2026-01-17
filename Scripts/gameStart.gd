extends Node2D

@export var startSfx: AudioStreamPlayer2D
@export var mainMusic: AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	startSfx.play()
	await startSfx.finished
	mainMusic.play()
