extends Pickup

export (PackedScene) var fireball_scene: PackedScene = preload("res://pickups/Fireball.tscn")
export (float) var projectile_velocity := 1500.0
export (float) var projectile_range := 600.0
export (float) var cooldown_time := 0.3
export (int) var max_uses := 5

onready var fireball_position := $FireballPosition
onready var cooldown_timer := $Cooldown
onready var sounds := $Sound

var allow_use := true
onready var usage := max_uses

var use_by_player: Node = null

func _ready():
	cooldown_timer.wait_time = cooldown_time
	
func _get_custom_rpc_methods() -> Array:
	return ._get_custom_rpc_methods() + [
		'_start_use',
		'_do_fire_projectile',
		'_disintegrate',
	]

func use() -> void:
	if not allow_use:
		return
	
	allow_use = false
	cooldown_timer.start()
	
	if usage > 0:
		if not GameState.online_play:
			_start_use()
		else:
			OnlineMatch.custom_rpc_sync(self, "_start_use")
	else:
		_fire_projectile()

func _start_use() -> void:
	# Account for a player throwing the gun before it actually fires.
	use_by_player = player
	
	_fire_projectile()

func _fire_projectile() -> void:
	if GameState.online_play and not OnlineMatch.is_network_master_for_node(use_by_player):
		return
	
	var projectile_name = Util.find_unique_name(original_parent, 'Projectile-')
	var projectile_vector: Vector2 = (Vector2.RIGHT * projectile_velocity).rotated(global_rotation)
	
	if not GameState.online_play:
		_do_fire_projectile(projectile_name, fireball_position.global_position, projectile_vector, projectile_range)
	else:
		OnlineMatch.custom_rpc_sync(self, "_do_fire_projectile", [projectile_name, fireball_position.global_position, projectile_vector, projectile_range])

func _do_fire_projectile(_projectile_name: String, _projectile_position: Vector2, _projectile_vector: Vector2, _projectile_range: float) -> void:
	var projectile_parent = original_parent
	
	if usage <= 0:
		sounds.play("No Charge")
	else:
		usage -= 1
		
		var projectile = fireball_scene.instance()
		projectile.name = _projectile_name
		projectile_parent.add_child(projectile)
		
		projectile.shoot(_projectile_position, _projectile_vector, _projectile_range)

func _disintegrate() -> void:
	queue_free()

func _on_Cooldown_timeout():
	allow_use = true
