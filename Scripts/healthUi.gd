extends HBoxContainer

@export var heartImage: Texture2D
@export var space: int = 20
@export var heartSize: Vector2

func _ready() -> void:
	add_theme_constant_override("separation", space)

func _on_player_health_change(_health: int) -> void:
	for child in get_children():
		child.queue_free()
	
	for i in range(_health):
		var heart = TextureRect.new()
		heart.texture = heartImage
		heart.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		heart.custom_minimum_size = heartSize
		add_child(heart)


func _on_player_game_finished(win: bool) -> void:
	queue_free()
