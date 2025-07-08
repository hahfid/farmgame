extends CanvasLayer

func _ready():
	$Timer.start()

func _on_Timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")  # Ganti sesuai scene utama kamu
