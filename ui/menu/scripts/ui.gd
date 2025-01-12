extends Control

func _process(delta):
	$ParallaxBackground.scroll_offset.x -= 1

func _on_button_3_pressed():
	get_tree().quit()
