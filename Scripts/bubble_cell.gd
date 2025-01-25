extends Node2D

var is_active = false
var level = 1

var self_rigidbody

func _ready():
	self_rigidbody = $RigidBody2D
	is_active = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func change_level(temp):
	level = temp
	$AnimationPlayer.play("spawn")
	#scale = level * Vector2(1, 1) 
	self.scale *= level
		
	print(self.scale)
	
func change_is_active():
	is_active = !is_active
	
func _on_area_2d_body_entered(body: Node2D) -> void:

	if body != self_rigidbody && body.is_in_group("bubble"):
		if body.get_parent().has_method("change_is_active"):
			body.get_parent().change_is_active()
		if is_active:
			body.queue_free()
			change_level(level + 1)
