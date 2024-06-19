extends RigidBody3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var speed = linear_velocity * delta
	var collision_object = move_and_collide(speed)
	
	if collision_object:
		var collider = collision_object.get_collider()
		var normal = collision_object.get_normal()
		var reflect = collision_object.get_remainder().bounce(collision_object.get_normal())
		
		if collider.is_in_group("Tiles"):
			print("BOUNCE!")
