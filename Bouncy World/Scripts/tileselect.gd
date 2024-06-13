extends Node3D

var isPickedUp = false
var starting_position
var prev_mouse_position
var next_mouse_position

func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			isPickedUp = true
			prev_mouse_position = get_viewport().get_mouse_position()

func _input(event):
	if event is InputEventMouseButton and event.is_released():
		isPickedUp = false
		
func _ready():
	starting_position = position.y

func _process(delta):
	if(isPickedUp == true):
		next_mouse_position = get_viewport().get_mouse_position()
		position.y = (-(next_mouse_position.y - prev_mouse_position.y) * delta)
		prev_mouse_position = next_mouse_position
	else:
		position.y = starting_position * delta
