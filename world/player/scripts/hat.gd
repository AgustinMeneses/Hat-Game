class_name HAT extends RigidBody2D

@export var life : float = 20
@export var DAMAGE : float = 0.5

var draining_speed = 0.05
var jump_force = 400
var can_jump = false
var is_on_person = false
var person : PERSON

func _process(delta: float) -> void:
	_drain_life()
	if Input.is_action_pressed("left_click"):
		can_jump = true
		jump_force = move_toward(jump_force, 1200, 25)
		print(jump_force)
		
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
	jump_force = 400

func _drain_life():
	if not person:
		life -= draining_speed
		if life <= 0:
			_ded()
			return
	else:
		life += 0.02
		if life >= 20:
			life = 20
func _ded():
	queue_free()
