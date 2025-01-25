extends Node2D

# Declare the variable to store the prefab scene
var prefab_scene : PackedScene

func _ready():
	# Load the prefab scene
	prefab_scene = load("res://bubbleCell.tscn")

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var click_position = get_global_mouse_position()
			spawn_object(click_position)

func spawn_object(position: Vector2):
	# Instance the prefab and position it at the clicked position
	var new_object = prefab_scene.instantiate()
	new_object.position = position  # Set its position
	add_child(new_object)  # Add the new object to the scene
