extends Node2D

@onready var back_button: Button = $Control/BackButton
@onready var label1: Label = $Control/Label
@onready var label2: Label = $Control/Label2
@onready var label3: Label = $Control/Label3
@onready var label4: Label = $Control/Label4
@onready var label5: Label = $Control/Label5
@onready var tex1: TextureRect = $Control/TextureRect
@onready var tex2: TextureRect = $Control/TextureRect2

var scroll_speed := 30  # pixels per second
var elements := []

func _ready():
	if back_button:
		back_button.pressed.connect(_on_back_button_pressed)
	else:
		print("BackButton tidak ditemukan!")

	elements = [label1, label2, label3,label4,label5, tex1, tex2]
	set_process(true)

func _process(delta):
	for e in elements:
		if e:
			e.position.y -= scroll_speed * delta  # geser ke atas

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/ui/game_menu_screen.tscn")
