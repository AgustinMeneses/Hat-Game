extends Node2D
@export var collision_area : Area2D
@onready var markers = $Markers.get_children()
var level
var persons : PackedScene = preload("res://world/person/scenes/person.tscn")

func _ready():
	level = get_tree().get_first_node_in_group("Level")
	$"Collision Area".connect("body_entered", body_entered)
	for i in markers:
		if randi_range(0,3) == 1:
			var person = persons.instantiate()
			add_child(person)
			person.global_position = i.global_position

func body_entered(_body):
	level.more_rooms()
	$"Collision Area/CollisionShape2D".call_deferred("set_disabled", true)
