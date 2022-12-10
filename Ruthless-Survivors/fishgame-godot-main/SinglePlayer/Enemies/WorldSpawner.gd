extends KinematicBody2D
var enemy_count = 0

#Add a timer here so at each time different enemies will spawn
func spawn():
	if enemy_count < 50:
		print("Spawned Enemies")
		print("enemy amount:", enemy_count)
		get_parent().add_child(load("res://SinglePlayer/Enemies/Skeleton/Skeleton.tscn").instance())
		get_parent().add_child(load("res://SinglePlayer/Enemies/Bat/Bat.tscn").instance())
		enemy_count += 2
	else:
		print("Maximum enemies on map")


func spawn_health():
	print("Spawned Health Potion")
	get_parent().add_child(load("res://SinglePlayer/DroppedItems/HPotion/HealthPotion.tscn").instance())
