class_name PERSON extends CharacterBody2D
var hat : HAT
var is_dead : bool = false
var gravity = 500
@onready var collision = $Marker2D
@export var life : float = 5
@export var SPEED : float = 100
@onready var marker_2d = $Marker2D

func _ready():
	hat = get_tree().get_first_node_in_group("hat")
func _physics_process(_delta):
	if not is_on_floor():
		velocity.y = gravity
	if hat.person == self:
		var dir = Input.get_axis("Left","Right")
		if dir:
			velocity.x = dir * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0 ,15)
	else:
		velocity.x = move_toward(velocity.x, 0 ,15)
	move_and_slide()

func _on_hat_place_body_entered(body: HAT) -> void:
	if body.is_in_group("hat"):
		$Person/skin/ChangeColor.play("Change Color")
		$AnimationPlayer.play("RUN")
		hat = body
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
		
		body.gravity_scale = 0
		body.is_on_person = true
		body.person = self
		$Timer.start()

func shake_screen(time: float, force: float):
	Global.camera._shake(time, force)

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
	$ProgressBar.value += hat.DAMAGE
	if life <= 0:
		die()
	else:
		$Timer.start()
	pass # Replace with function body.

func _on_hat_place_body_exited(_body):
	if !$Person/HatPlace/Collision.disabled:
		$Person/skin/ChangeColor.pause()
		$AnimationPlayer.play("idle")
		hat.is_on_person = false
		hat.person = null
	$Timer.stop()
	pass # Replace with function body.
