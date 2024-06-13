extends CharacterBody3D

const speed = 3
var isPickedUp = false
var prev_mouse_position
var next_mouse_position

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var nav_Agent = $NavigationAgent3D

func _on_collision_shape_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			isPickedUp = true

func released():
	isPickedUp = false

func _physics_process(delta):
	if(isPickedUp == true):
		next_mouse_position = get_viewport().get_mouse_position()
		Transform3D((next_mouse_position - prev_mouse_position) * 0.1 * delta)
		prev_mouse_position = next_mouse_position
	else:
		velocity.y += gravity * delta
		
		var current_location = global_transform.origin
		var next_location = nav_Agent.get_next_path_position()
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
	if(isPickedUp == false):
		update_target_location(get_random_pos_in_sphere(5))
