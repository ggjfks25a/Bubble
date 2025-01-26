extends Node2D

var is_active = false
var level = 1

var self_rigidbody
var self_sprite
var collision_shape
var xd

var original_collision_radius
var original_sprite_scale
var original_xd

func _ready():
	self_rigidbody = $RigidBody2D
	self_sprite = $RigidBody2D/Sprite2D
	collision_shape = $RigidBody2D/Area2D/CollisionShape2D
	xd = $RigidBody2D/CollisionShape2D
	is_active = true

	original_sprite_scale = self_sprite.scale
	self.rescale(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func rescale(size) -> void:
	self_sprite.scale = original_sprite_scale * Vector2(size, size)
	
	var rescale_rate = self_sprite.texture.get_size() * original_sprite_scale.x * Vector2(size, size)
		
	collision_shape.shape = collision_shape.shape.duplicate()
	xd.shape = xd.shape.duplicate()
	
	collision_shape.shape.radius = ((rescale_rate * 0.9) / 2).x # Scale the radius
	xd.shape.radius = ((rescale_rate * 0.75) / 2).x
	
func change_is_active():
	is_active = !is_active
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body != self_rigidbody && body.is_in_group("bubble") && body.get_groups() == self_rigidbody.get_groups() && level < 5 :
		if body.get_parent().has_method("change_is_active") && is_active && body.get_parent().level <= self.level:
			body.get_parent().change_is_active()
			body.get_parent().queue_free()
			level += 1
			rescale(level)
			

			
