extends Area2D

onready var hitbox := $Hitbox
onready var animation_player := $AnimationPlayer

var vector := Vector2.ZERO
var start_position := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func fly(_start_position: Vector2, _vector: Vector2):
	start_position = _start_position
	vector = _vector
	
	global_position = _start_position
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
