extends Node

var allow_save_game: bool

func _ready() -> void:
	print("SaveGameManager aktif")

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		print("Window akan ditutup. Menyimpan otomatis...")
		save_game()
		get_tree().quit() # penting agar game tetap bisa ditutup setelah save

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("save_game"):
		save_game()

func save_game() -> void:
	var save_level_data_component = get_tree().get_first_node_in_group("save_level_data_component")
	if save_level_data_component != null:
		save_level_data_component.save_game()
		print("Game saved on close.")
	else:
		print("Gagal menemukan SaveLevelDataComponent saat close.")

func load_game() -> void:
	await get_tree().process_frame
	var save_level_data_component = get_tree().get_first_node_in_group("save_level_data_component")
	if save_level_data_component != null:
		save_level_data_component.load_game()
