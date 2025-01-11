extends RigidBody2D

var jump_force = 1200
var can_jump = false
var is_on_person = false

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("left_click"):
		
		can_jump = true
		
	if Input.is_action_just_released("left_click") and can_jump and is_on_person:
		
		is_on_person = false
		can_jump = false
		
		throw()
		
func throw():
	var direction = (get_global_mouse_position() - global_position).normalized()

	var linear_impulse = direction * jump_force
	gravity_scale = 3
	apply_impulse(linear_impulse)
	
	$ThrowSound.pitch_scale = randf_range(0.8, 1.2)
	$ThrowSound.play()
