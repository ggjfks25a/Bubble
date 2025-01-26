extends Area2D

@onready var timer1 = Timer.new()
@onready var timer2 = Timer.new()

var parent_node
var is_active = false

var is_broken = false

func _ready() -> void:
	parent_node = get_parent().get_parent().get_parent()
	parent_node.connect("activate_breaker_mode", Callable(self, "_activate_breaker_mode"))

func _process(delta: float) -> void:
	if is_broken:
		is_broken = false
		
		# Load texture
		var texture = load("res://Sprites/Bubble_Effect.png")
		
		# Set up timers
		timer1.one_shot = true
		timer2.one_shot = true
		add_child(timer1)
		add_child(timer2)
		
		# Start timers
		timer1.start(0.025)
		timer2.start(0.15)
		
		# Perform actions with timers
		var sprite = get_parent().get_node("Sprite2D")
		sprite.scale *= 1.2
		await timer1.timeout  # Wait for timer1 to finish
		sprite.texture = texture
		sprite.scale *= 0.8
		await timer2.timeout  # Wait for timer2 to finish
		get_parent().get_parent().queue_free()


func set_is_broken(val):
	is_broken = val

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
				area.set_is_broken(true)
			is_broken = true
			var pollo = pow(2, get_parent().get_parent().level - 1) + (pow(2, areas.size()) - 1)
			GlobalData.score += pollo
			print("Score: ", GlobalData.score)
			print("Attempts: ", GlobalData.attempts)

func _activate_breaker_mode(val):
	is_active = val
