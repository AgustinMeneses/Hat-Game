extends Node
var x_coords = 0
var tile_ids :Array = [1,2,3]
func _ready() -> void:
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	pass

func more_rooms():
	var random_tile_id = tile_ids.pick_random()
	print(random_tile_id)
	x_coords += 1
	$TileMap.set_cell(0, Vector2i(x_coords, 0), 0, Vector2i(0,0), random_tile_id)
