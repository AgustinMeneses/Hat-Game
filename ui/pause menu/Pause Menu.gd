extends Control

func _ready():
	visible = false
	pass
func _input(event):
	if Input.is_action_just_pressed("esc"):
		if visible and $Panel/Settings.visible:
			visible = false
			get_tree().paused = false
		else:
			visible = true
			get_tree().paused = true
func _on_button_pressed():
	visible = false
	get_tree().paused = false
	pass # Replace with function body.


func _on_button_2_pressed():
	$Panel/Settings.visible = true
	pass # Replace with function body.


func _on_button_4_pressed():
	get_tree().quit()
	pass # Replace with function body.
