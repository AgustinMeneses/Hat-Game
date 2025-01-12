extends Node2D
@export var collision_area : Area2D
var level

func _ready():
	level = get_tree().get_first_node_in_group("Level")
	$"Collision Area".connect("body_entered", body_entered)

func body_entered(_body):
	level.more_rooms()
	$"Collision Area/CollisionShape2D".call_deferred("set_disabled", true)
