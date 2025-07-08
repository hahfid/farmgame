extends SplashScreen

@onready var final_image = $FinalImage
@onready var press_any_key_label = $PressAnyKeyLabel

func _ready():
	print("FinalImage node is:", final_image)
	final_image.visible = false
	delete_after_finished = false

	# koneksi sinyal dengan Callable
	connect("finished", Callable(self, "_on_splash_finished"))
	
	if auto_start:
		start()

func _on_splash_finished():
	print("Finished signal fired!")
	final_image.visible = true
	if press_any_key_label:
		press_any_key_label.visible = true
		set_process_input(true)

func _input(event):
	if press_any_key_label and press_any_key_label.visible and event.is_pressed():
		print("Key pressed, changing scene...")
		get_tree().change_scene_to_file("res://Scenes/ui/game_menu_screen.tscn")
