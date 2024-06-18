extends Node3D

var isPickedUp = false
var starting_position 
var prev_mouse_position
var next_mouse_position
var elasticMultiplier
var elasticLocation
var acceleration = 30
var elasticAcceleration
const roundingThreshold = 0.05

func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			isPickedUp = true
			prev_mouse_position = get_viewport().get_mouse_position()

func _input(event):
	if event is InputEventMouseButton and event.is_released():
		isPickedUp = false
		elasticMultiplier = position.y/2
		elasticAcceleration = acceleration * abs(elasticMultiplier)
		elasticLocation = starting_position - elasticMultiplier

func _ready():
	starting_position = position.y

func _process(delta):
	if(isPickedUp):
		next_mouse_position = get_viewport().get_mouse_position()
		position.y += (-(next_mouse_position.y - prev_mouse_position.y) * delta)
		prev_mouse_position = next_mouse_position
	if(!isPickedUp && position.y != starting_position):
			if(position.y == elasticLocation):
				if(abs(elasticLocation) <= roundingThreshold):
					elasticLocation = starting_position
					position.y = starting_position
				else:
					elasticMultiplier = position.y/2
					elasticAcceleration = acceleration * abs(elasticMultiplier)
					elasticLocation = starting_position - elasticMultiplier
			position.y = move_toward(position.y, (elasticLocation), (delta * elasticAcceleration))
