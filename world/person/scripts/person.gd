class_name PERSON extends CharacterBody2D
var hat : HAT
var is_dead : bool = false
@export var life : float = 5


func _on_hat_place_body_entered(body: HAT) -> void:
	if body.is_in_group("hat"):
		hat = body
		var rid = body.get_rid()

		PhysicsServer2D.body_set_state(
			rid,
			PhysicsServer2D.BODY_STATE_TRANSFORM,
			Transform2D(0, $HatPlace.global_position - Vector2(0, 100))
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

func die():
	hat.person = null
	is_dead = true
	hat.global_position = $Marker2D.global_position
	$HatPlace/Collision.disabled = true
	$Sprite.play("Dead")

func _on_timer_timeout():
	life -= hat.DAMAGE
	if life <= 0:
		die()
	else:
		$Timer.start()
	pass # Replace with function body.

func _on_hat_place_body_exited(body):
	if !$HatPlace/Collision.disabled:
		hat.is_on_person = false
		hat.person = null
	$Timer.stop()
	pass # Replace with function body.
