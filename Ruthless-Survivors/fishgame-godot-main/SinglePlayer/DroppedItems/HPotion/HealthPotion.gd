extends KinematicBody2D

var spawn_distance = 1800
var entered_magnet = false
		
func _ready():
	position = get_parent().get_node("Player").position + Vector2(spawn_distance, 0).rotated(rand_range(0, 2*PI))

func _physics_process(delta):
	if (entered_magnet == false):
		pass
	else:
		position += (get_parent().get_node("Player").position - position)/10

func _on_Magnet_area_entered(area):
	if (area.get_name() == "PlayerHurtbox"):
		entered_magnet = true


func _on_Health_area_entered(area):
	if (area.get_name() == "PlayerHurtbox"):
		hide()
		queue_free()
