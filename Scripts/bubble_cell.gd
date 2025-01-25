extends Node2D

var is_active = false
var level = 1

var self_rigidbody
var self_sprite
var collision_shape

func _ready():
	self_rigidbody = $RigidBody2D
	self_sprite = $RigidBody2D/Sprite2D
	collision_shape = $RigidBody2D/Area2D/CollisionShape2D
	is_active = true




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func rescale(size) -> void:
	self_sprite.scale *= size
	
	if collision_shape.shape is CircleShape2D:
		collision_shape.shape.radius = collision_shape.shape.radius * size  # Scale the radius

func change_level(temp):
	level = temp
	#$AnimationPlayer.play("spawn")
	#scale = level * Vector2(1, 1) 
	self.position += Vector2(0, -100)
	
func change_is_active():
	is_active = !is_active
	
func _on_area_2d_body_entered(body: Node2D) -> void:

	if body != self_rigidbody && body.is_in_group("bubble") && body.get_groups() == self.get_groups():
		if body.get_parent().has_method("change_is_active") && is_active:
			body.get_parent().change_is_active()
			body.get_parent().queue_free()
			level += 1
			rescale(level)
			

			
