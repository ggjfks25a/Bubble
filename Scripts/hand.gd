extends Sprite2D

var parent_node
var is_active = false

func _ready():
	z_index = 1000
	parent_node = get_parent()
	parent_node.connect("activate_breaker_mode", Callable(self, "_activate_breaker_mode"))

func _process(delta):
	if(is_active):
		var offset = Vector2(30, -15)
		position = get_global_mouse_position() + offset
	else:
		position = Vector2(-10000, -10000)

func _activate_breaker_mode(val):
	is_active = val
