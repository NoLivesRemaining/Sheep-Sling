extends CharacterBody3D

const speed = 3

@onready var nav_Agent = $NavigationAgent3D

func _physics_process(delta):
	var current_location = global_transform.origin
	var next_location = nav_Agent.get_next_location()
	var new_velocity = (next_location - current_location).normalized() * speed
	
	nav_Agent.set_velocity(new_velocity)

func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity, .25)
	move_and_slide()

func get_random_pos_in_sphere(radius : float) -> Vector3:
	var x1 = randf_range (-1, 1)
	var x2 = randf_range (-1, 1)
	
	while x1*x1 + x2*x2 >= 1:
		x1 = randf_range (-1, 1)
		x2 = randf_range (-1, 1)
	
	var random_pos_on_unit_sphere = Vector3 (
		2 * x1 * sqrt(1 - x1*x1 - x2*x2),
		2 * x2 * sqrt(1 - x1*x1 - x2*x2),
		1 - 2 * (x1*x1 + x2*x2))
	
	return random_pos_on_unit_sphere * randf_range(0, radius)

func update_target_location(target_location):
	nav_Agent.set_targer_location(target_location)

func _on_navigation_agent_3d_target_reached():
	await get_tree().create_timer(5).timeout
	update_target_location(get_random_pos_in_sphere(5))
