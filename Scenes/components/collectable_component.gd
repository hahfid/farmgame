extends Area2D
class_name CollectableComponent

@export var collectable_name: String = "Tomato"

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		InventoryManager.add_collectable(collectable_name)
		print("Collected:", collectable_name)
		get_parent().queue_free()  # Hapus seluruh tomato_harvest setelah diambil
