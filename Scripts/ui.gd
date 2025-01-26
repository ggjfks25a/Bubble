extends Control

var score_label
var attempts_label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_label = $score
	attempts_label = $attempts
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_label.text = str(GlobalData.score)
	attempts_label.text = str(GlobalData.attempts)
	pass
