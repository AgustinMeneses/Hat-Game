class_name HAT extends RigidBody2D

@export var life : float = 20
@export var DAMAGE : float = 0.5
@onready var line_2d = $Line2D
@onready var animation_player = $AnimationPlayer

var draining_speed = 0.08
var meters : float
var jump_force = 400
var can_jump = false
var is_on_person = false
var person : PERSON
var initial_point = null

func _process(_delta: float) -> void:
	_drain_life()
	if Input.is_action_pressed("left_click"):
		if is_on_person:
			can_jump = true
			jump_force = move_toward(jump_force, 1850, 25)
			$"CanvasLayer/UI/Force indicator".value = jump_force
		
	if Input.is_action_just_released("left_click") and can_jump and is_on_person:
		$"CanvasLayer/UI/Force indicator".value = $"CanvasLayer/UI/Force indicator".min_value
		person = null
		is_on_person = false
		can_jump = false
		throw()
	if person:
		global_position = person.marker_2d.global_position
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
		if not initial_point:
			life -= draining_speed
			if life <= 0:
				_ded()
				return
	else:
		if person:
			global_position = person.collision.global_position
		life += 0.06
		if life >= 20:
			life = 20
	$CanvasLayer/UI/Lifebar.value = life
func _ded():
	set_process(false)
	get_tree().reload_current_scene()
