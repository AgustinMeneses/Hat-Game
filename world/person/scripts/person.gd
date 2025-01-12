class_name PERSON extends CharacterBody2D
var hat : HAT
var is_dead : bool = false
var gravity = 600
@onready var collision = $Marker2D
@export var life : float = 5
@export var SPEED : float = 100
@onready var marker_2d = $Marker2D

var change_dir_timer = 0
var direction = 0


func _ready():
	hat = get_tree().get_first_node_in_group("hat")
func _physics_process(_delta):
	if not is_on_floor():
		velocity.y = gravity
	if hat:
		if not is_on_floor():
			if hat.person == self:
				put_hat(hat)
			velocity.y = gravity
		if hat.person == self:
			var dir = Input.get_axis("Left","Right")
			if dir:
				velocity.x = dir * SPEED
				$Person.scale.x = dir * 5
			else:
				velocity.x = move_toward(velocity.x, 0 ,15)
		else:
			velocity.x = move_toward(velocity.x, 0 ,15)

	move_and_slide()

func _on_hat_place_body_entered(body: HAT) -> void:
	if body.is_in_group("hat"):
		if body.person == null:
			$Person/skin/ChangeColor.play("Change Color")
			$AnimationPlayer.play("RUN")
			hat = body
			put_hat(body)

func shake_screen(time: float, force: float):
	Global.camera._shake(time, force)
	$AudioStreamPlayer.pitch_scale = randf_range(0.9, 1.2)

func die():
	var rid = hat.get_rid()
	PhysicsServer2D.body_set_param(
		rid,
		PhysicsServer2D.BODY_PARAM_GRAVITY_SCALE,
		1.0
	)
	set_physics_process(false)
	hat.person = null
	is_dead = true
	hat.global_position = $Marker2D.global_position
	$Person/HatPlace/Collision.disabled = true
	$AnimationPlayer.play("DEAD")

func _on_timer_timeout():
	life -= hat.DAMAGE
	if life <= 0:
		die()
	else:
		$Timer.start()
	$TextureProgressBar.value = life
	pass # Replace with function body.

func _on_hat_place_body_exited(_body):
	if !$Person/HatPlace/Collision.disabled:
		$Person/skin/ChangeColor.pause()
		$AnimationPlayer.play("idle")
		hat.is_on_person = false
		hat.person = null
	$Timer.stop()
	_body.gravity_scale = 3
	pass # Replace with function body.

func put_hat(body):
	var rid = body.get_rid()

	PhysicsServer2D.body_set_state(
		rid,
		PhysicsServer2D.BODY_STATE_TRANSFORM,
		Transform2D(0, $Person/HatPlace.global_position - Vector2(0, 100))
	)
	PhysicsServer2D.body_set_state(
		rid,
		PhysicsServer2D.BODY_STATE_LINEAR_VELOCITY,
		Vector2.ZERO
	)
	PhysicsServer2D.body_set_state(
		rid,
		PhysicsServer2D.BODY_STATE_ANGULAR_VELOCITY,
		0.0
	)
	PhysicsServer2D.body_set_param(
		rid,
		PhysicsServer2D.BODY_PARAM_GRAVITY_SCALE,
		0.0
	)
	
	body.is_on_person = true
	body.person = self
	$Timer.start() 
