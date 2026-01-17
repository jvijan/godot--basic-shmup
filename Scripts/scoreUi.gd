extends RichTextLabel

var score: int = 0


func _on_player_score_change(_score: int) -> void:
	score += _score
	text = "Score: " + str(score)


func _on_player_game_finished(win: bool) -> void:
	text = ""
