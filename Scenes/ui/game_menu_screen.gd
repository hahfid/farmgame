extends CanvasLayer


@onready var save_game_button: Button = $MarginContainer/VBoxContainer/SaveGameButton
@onready var credit_button: Button = $MarginContainer/VBoxContainer/CreditButton
@onready var credit_panel: Panel = $CreditPanel


func _ready() -> void:
	save_game_button.disabled = !SaveGameManager.allow_save_game
	save_game_button.focus_mode = SaveGameManager.allow_save_game if Control.FOCUS_ALL else Control.FOCUS_NONE
	

	# Pastikan panel kredit disembunyikan saat awal
	

	# Hubungkan tombol kredit
	credit_button.pressed.connect(_on_credit_button_pressed)

func _on_start_game_button_pressed() -> void:
	GameManager.start_game()
	await get_tree().process_frame
	var save_component = get_tree().get_first_node_in_group("save_level_data_component")
	if save_component:
		save_component.load_game()
	queue_free()

func _on_save_game_button_pressed() -> void:
	SaveGameManager.save_game()

func _on_quit_game_button_pressed() -> void:
	GameManager.quit_game()

func _on_credit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://isi_credit.tscn")
