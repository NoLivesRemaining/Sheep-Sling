extends RigidBody3D

#var bounce_velocity
#
#func _physics_process(delta):
	#if(bounce_velocity):
		#var collision_info = move_and_collide(bounce_velocity * delta)
		#bounce_velocity = bounce_velocity.bounce(collision_info.get_normal())
#
#
#func bounce(velocity):
	#bounce_velocity = velocity
