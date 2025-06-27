extends CanvasLayer

@onready var save_game_button: Button = $MarginContainer/VBoxContainer/SaveGameButton

func _ready() -> void:
	save_game_button.disabled = !SaveGameManager.allow_save_game
	save_game_button.focus_mode = SaveGameManager.allow_save_game if Control.FOCUS_ALL else Control.FOCUS_NONE

func _on_start_game_button_pressed() -> void:
	GameManager.start_game()
	
	# Tunggu satu frame agar scene baru benar-benar dimuat
	await get_tree().process_frame
	
	# Cari komponen penyimpan data di scene baru
	var save_component = get_tree().get_first_node_in_group("save_level_data_component")
	if save_component:
		save_component.load_game()

	# Hapus menu setelah load selesai
	queue_free()



func _on_save_game_button_pressed() -> void:
	SaveGameManager.save_game()


func _on_quit_game_button_pressed() -> void:
	GameManager.quit_game()
