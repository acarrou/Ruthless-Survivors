extends KinematicBody2D

var entered_magnet = false
		
func _physics_process(delta):
	if (entered_magnet == false):
		pass
	else:
		position += (get_parent().get_node("Player").position - position)/10

func _on_Magnet_area_entered(area):
	if (area.get_name() == "PlayerHurtbox"):
		entered_magnet = true
		

func _on_Gem_area_entered(area):
	if (area.get_name() == "PlayerHurtbox"):
		hide()
		queue_free()
