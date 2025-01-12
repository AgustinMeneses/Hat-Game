extends Camera2D
var shake_amount : float = 0
var default_offset : Vector2 = offset
var pos_x : int
var pos_y : int

@onready var timer = $Timer
@onready var tween : Tween = create_tween()


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.camera = self
	pass # Replace with function body.

func _process(delta):
	pass

func _shake(time: float, amount: float):
	pass


func _on_timer_timeout():
	set_process(false)
	tween.interpolate_value(self, "offset", 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	pass # Replace with function body.
