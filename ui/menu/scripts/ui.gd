extends Control

var fullscreen: bool = false

func _ready():
	$Settings.visible = false
	get_tree().paused = false

func _process(delta):
	$ParallaxBackground.scroll_offset.x -= 1

func _on_button_3_pressed():
	get_tree().quit()


func _on_button_2_pressed():
	$Settings.visible = true
	pass # Replace with function body.


func _on_button_pressed():
	get_tree().change_scene_to_file("res://world/world/scenes/world.tscn")
	pass # Replace with function body.


func _on_music_finished():
	$Music.play()
	pass # Replace with function body.
