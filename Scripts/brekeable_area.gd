extends Area2D

var parent_node
var is_active = false

func _ready() -> void:
	parent_node = get_parent().get_parent().get_parent()
	parent_node.connect("activate_breaker_mode", Callable(self, "_activate_breaker_mode"))
	
func calculate_adjacent_bubbles(parent_area, cummulated_areas):
	var overlapping_areas = parent_area.get_overlapping_areas() 
	for area in overlapping_areas:
		if(area not in cummulated_areas) && area.get_parent().get_groups() == parent_area.get_parent().get_groups():
			cummulated_areas.append(area)
			calculate_adjacent_bubbles(area, cummulated_areas)
	return cummulated_areas

func _input_event(viewport, event, shape_idx):
	if is_active:
		if event.is_action_pressed("click"):
			var areas = calculate_adjacent_bubbles(self, [])
			for area in areas:
				area.get_parent().get_parent().queue_free()
			await get_tree().physics_frame
			get_parent().get_parent().queue_free()

func _activate_breaker_mode(val):
	is_active = val
