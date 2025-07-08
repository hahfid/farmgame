extends CanvasLayer

@onready var logo1 = $TextureRect
@onready var teks = $Label
@onready var logo2 = $TextureRect2
@onready var logo3 = $TextureRect3
@onready var press_any_key_label = $PressAnyKeyLabel
@onready var timer = $Timer

var step = 0
var ready_for_input = false

func _ready():
	timer.timeout.connect(_on_Timer_timeout)
	show_step()


func show_step():
	logo1.visible = false
	teks.visible = false
	logo2.visible = false
	logo3.visible = false
	press_any_key_label.visible = false

	match step:
		0:
			logo1.visible = true
		1:
			teks.visible = true
		2:
			logo2.visible = true
		3:
			logo3.visible = true
			press_any_key_label.visible = true
			ready_for_input = true
			return  # Tidak mulai timer lagi
	timer.start()

func _on_Timer_timeout():
	step += 1
	show_step()

func _input(event):
	if ready_for_input and event.is_pressed():
		get_tree().change_scene_to_file("res://Scenes/ui/game_menu_screen.tscn")


func _on_timer_timeout() -> void:
	pass # Replace with function body.
