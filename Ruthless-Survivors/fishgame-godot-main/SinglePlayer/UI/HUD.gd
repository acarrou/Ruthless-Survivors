extends CanvasLayer

export var easing_factor = 10

var health_target = [-1, -1]
var exp_target = [-1, -1]

onready var player = get_node("../YSort/Player")
onready var bars = get_node("MarginContainer/HBoxContainer/VBoxContainer2/VBoxContainer")
onready var exp_bar = bars.get_node("ProgressBar")
onready var health_bar = bars.get_node("ProgressBar2")
onready var level_label = bars.get_node("Label")

func _ready():
	player.connect("exp_changed", self, "_on_exp_changed")
	player.connect("health_changed", self, "_on_health_changed")

func _on_exp_changed(value, max_value, level):
	# initialization
	if (exp_target[1] < 0):
		exp_bar.max_value = max_value
		exp_bar.value = value
	
	# set target
	exp_target[1] = max_value
	exp_target[0] = value
	level_label.text = "Lv. " + str(level)

func _on_health_changed(value, max_value):
	# initialization
	if (health_target[1] < 0):
		health_bar.max_value = max_value
		health_bar.value = value
	
	# set target
	health_target[1] = max_value
	health_target[0] = value
	
func _physics_process(delta):
	var easing = easing_factor * delta
	exp_bar.max_value = lerp(exp_bar.max_value, exp_target[1], easing)
	exp_bar.value = lerp(exp_bar.value, exp_target[0], easing)
	health_bar.max_value = lerp(health_bar.max_value, health_target[1], easing)
	health_bar.value = lerp(health_bar.value, health_target[0], easing)
