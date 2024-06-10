extends Node3D

var Y_starting_position = global_position.y

func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			global_position.y += 1
			print("Pressed Left!", Y_starting_position, global_position.y)
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == false:
			global_position.y = Y_starting_position
			print("Released Left!")
