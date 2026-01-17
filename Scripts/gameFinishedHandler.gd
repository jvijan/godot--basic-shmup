extends Node

@export var victoryScreen: Sprite2D
@export var lossScreen: Sprite2D
@export var winSfx: AudioStreamPlayer2D

func _on_player_game_finished(won: bool) -> void:
	if won:
		victoryScreen.show()
		winSfx.play()
	else:
		lossScreen.show()
