# TileMapLayerDataResource.gd
class_name TileMapLayerDataResource
extends NodeDataResource

@export var tilemap_layer_used_cells: Array[Vector2i]
@export var terrain_set: int = 0
@export var terrain: int = 3

func _save_data(node: Node2D) -> void:
	super._save_data(node)

	var tilemap_layer: TileMapLayer = node as TileMapLayer
	if tilemap_layer:
		tilemap_layer_used_cells = tilemap_layer.get_used_cells()

func _load_data(window: Window) -> void:
	print("Loading node from path: ", node_path)
	var scene_node = window.get_node_or_null(node_path)
	if scene_node == null:
		push_error("TileMapLayerDataResource: Node not found at path: %s" % node_path)
		return

	var tilemap_layer: TileMapLayer = scene_node as TileMapLayer
	if tilemap_layer == null:
		push_error("Node is not a TileMapLayer")
		return

	tilemap_layer.set_cells_terrain_connect(tilemap_layer_used_cells, terrain_set, terrain, true)
