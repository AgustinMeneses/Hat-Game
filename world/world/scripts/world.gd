extends Node

var x_coords = 0
var tile_ids: Array = [1, 2, 3]
var current_input = ""  # To store keyboard input

func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		# Convert key pressed to character
		var key_typed = char(event.unicode)
		
		# Add character to current input
		current_input += key_typed
		
		# Check for cheat codes
		check_cheat_codes()
		
		# Reset input buffer if it gets too long
		if current_input.length() > 10:
			current_input = ""

func check_cheat_codes() -> void:
	if "mister5" in current_input:
		$Hat/Sprite2D.play("Og")
		current_input = ""
	elif "reset" in current_input:
		$Hat/Sprite2D.play("Idle")
		current_input = ""
	elif "hanger" in current_input:
		$Hat/Sprite2D.play("Hanger")
		current_input = ""

func more_rooms():
	var random_tile_id = tile_ids.pick_random()
	x_coords += 1
	$TileMap.set_cell(0, Vector2i(x_coords, 0), 0, Vector2i(0, 0), random_tile_id)
