extends KinematicBody2D
#onready var enemies_killed_bat = get_parent().get_node("Bat").enemies_killed
var max_enemies = 50
#Add a timer here so at each time different enemies will spawn
func spawn():
	var enemies = get_tree().get_nodes_in_group("Enemies").size();
	if enemies < max_enemies:
		print("Spawned Enemies")
		print("enemy amount:", enemies)
		get_parent().add_child(load("res://SinglePlayer/Enemies/Skeleton/Skeleton.tscn").instance())
		get_parent().add_child(load("res://SinglePlayer/Enemies/Bat/Bat.tscn").instance())
		print("max allowed enemies ", max_enemies)
	else:
		print("Maximum enemies on map")
		print("max allowed enemies ", max_enemies)

func spawn_health():
	print("Spawned Health Potion")
	get_parent().add_child(load("res://SinglePlayer/DroppedItems/HPotion/HealthPotion.tscn").instance())

func _on_Timer_timeout():
	max_enemies = max_enemies*1.5
