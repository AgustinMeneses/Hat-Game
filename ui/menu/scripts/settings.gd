extends Panel
var fullscreen : bool = false


func _on_full_screen_pressed():
	if !fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		fullscreen = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		fullscreen = false
	pass # Replace with function body.

func _input(event):
	if Input.is_action_just_pressed("esc") and visible:
		visible = false
