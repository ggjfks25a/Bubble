extends Control

var attempts_label
var score_digit1
var score_digit2
var score_digit3

# Texture list for digits
var digit_textures = [
	preload("res://Sprites/Numbers/0.png"),
	preload("res://Sprites/Numbers/1.png"),
	preload("res://Sprites/Numbers/2.png"),
	preload("res://Sprites/Numbers/3.png"),
	preload("res://Sprites/Numbers/4.png"),
	preload("res://Sprites/Numbers/5.png"),
	preload("res://Sprites/Numbers/6.png"),
	preload("res://Sprites/Numbers/7.png"),
	preload("res://Sprites/Numbers/8.png"),
	preload("res://Sprites/Numbers/9.png")
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_digit1 = $score1
	score_digit2 = $score2
	score_digit3 = $score3
	attempts_label = $attempts

	update_display()  # Update the display initially

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_display()

# Update the score display
func update_display():
	var score_str = str(GlobalData.score)
	while score_str.length() < 3:  # Pad the score with leading zeros if necessary
		score_str = "0" + score_str
	
	# Set the textures for the digits
	score_digit1.texture = digit_textures[int(score_str[0])]
	score_digit2.texture = digit_textures[int(score_str[1])]
	score_digit3.texture = digit_textures[int(score_str[2])]
	
	# Set the texture for attempts (assuming it should display the number as a texture)
	attempts_label.texture = digit_textures[GlobalData.attempts]  # Ensure this is a valid index for textures
