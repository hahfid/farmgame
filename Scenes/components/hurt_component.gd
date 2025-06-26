class_name HurtComponent
extends Area2D

@export var tool : DataTypes.Tools = DataTypes.Tools.None

signal hurt

func _on_area_entered(area: Area2D) -> void:
	var hit_component = area as HitComponent
	if hit_component == null:
		print("Bukan HitComponent")
		return

	print("Alat Pemukul: ", hit_component.current_tool)
	print("Dibutuhkan: ", tool)

	if tool == hit_component.current_tool:
		print("Cocok, memberikan damage: ", hit_component.hit_damage)
		hurt.emit(hit_component.hit_damage)
	else:
		print("Tool tidak cocok, tidak memberikan damage")
