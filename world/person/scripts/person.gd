extends CharacterBody2D

func _on_hat_place_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
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
		
		$Timer.start()

func _on_timer_timeout() -> void:
	die()
	
func die():
	$HatPlace/Collision.disabled = true
	$Sprite.play("Dead")
