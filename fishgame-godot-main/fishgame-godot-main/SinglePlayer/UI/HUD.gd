extends CanvasLayer

# references
onready var player = get_node("../YSort/Player")
onready var bars = get_node("MarginContainer/HBoxContainer/VBoxContainer2")
onready var exp_bar = bars.get_node("VBoxContainer/ProgressBar")
onready var level_label = bars.get_node("VBoxContainer/Label")
onready var health_bar = bars.get_node("VBoxContainer2/ProgressBar")
onready var health_label = bars.get_node("VBoxContainer2/Label")

# variables
var health_target = {"current": -1, "max": -1}
var exp_target = {"current": -1, "max": -1}

# constants
const EASING_FACTOR = 20

func _ready():
	player.connect("health_changed", self, "_on_health_changed")
	player.connect("exp_changed", self, "_on_exp_changed")

func _on_health_changed(value, max_value):
	# initialization
	if (health_target.max < 0):
		health_bar.max_value = max_value
		health_bar.value = value
	
	# set target
	health_target.max = max_value
	health_target.current = value

func _on_exp_changed(value, max_value, level):
	# initialization
	if (exp_target.max < 0):
		exp_bar.max_value = max_value
		exp_bar.value = value
	
	# set target
	exp_target.max = max_value
	exp_target.current = value
	level_label.text = "LVL " + str(level)
	
func _physics_process(delta):
	var easing = EASING_FACTOR * delta
	health_bar.max_value = lerp(health_bar.max_value, health_target.max, easing)
	health_bar.value = lerp(health_bar.value, health_target.current, easing)
	health_label.text = "+" + str(floor(health_bar.value))
	exp_bar.max_value = lerp(exp_bar.max_value, exp_target.max, easing)
	exp_bar.value = lerp(exp_bar.value, exp_target.current, easing)
