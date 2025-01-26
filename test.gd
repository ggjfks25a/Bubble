extends Node2D

# Declare the variable to store the prefab scene
var blue_cell : PackedScene
var red_cell : PackedScene
var green_cell : PackedScene
var yellow_cell : PackedScene

var pop_sound : AudioStream

func _ready():
	# Load the prefab scene
	blue_cell = load("res://Bubbles/blueCell.tscn")
	red_cell = load("res://Bubbles/redCell.tscn")
	green_cell = load("res://Bubbles/greenCell.tscn")
	yellow_cell = load("res://Bubbles/yellowCell.tscn")
	
	pop_sound = load("res://Audios/SE_Pop.mp3")
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var click_position = get_global_mouse_position()
			spawn_object(click_position)
			MgrSfx.PlaySound(pop_sound)		
				
func spawn_object(position: Vector2):
	
	var random_value = randi() % 4 + 1

	# Instantiate the correct scene based on the random value
	var cell_instance = null

	match random_value:
		1:
			cell_instance = blue_cell.instantiate()
		2:
			cell_instance = red_cell.instantiate()
		3:
			cell_instance = green_cell.instantiate()
		4:
			cell_instance = yellow_cell.instantiate()

	cell_instance.position = position  # Set its position
	add_child(cell_instance)  # Add the new object to the scene
