extends Area2D

var parent_node
var is_active = false

func _ready() -> void:
	parent_node = get_parent().get_parent().get_parent()
	parent_node.connect("activate_breaker_mode", Callable(self, "_activate_breaker_mode"))

func _input_event(viewport, event, shape_idx):
	if is_active:
		if event.is_action_pressed("click"):
			get_parent().get_parent().queue_free()

func _activate_breaker_mode(val):
	is_active = val
