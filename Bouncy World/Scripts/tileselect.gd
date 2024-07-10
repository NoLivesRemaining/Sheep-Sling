extends Node3D

var isPickedUp = false
var starting_position 
var prev_mouse_position
var next_mouse_position
var elasticMultiplier
var elasticLocation
var acceleration = 30
var elasticAcceleration
var speed
const roundingThreshold = 0.05

func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			self.isPickedUp = true
			prev_mouse_position = get_viewport().get_mouse_position()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == false and self.isPickedUp == true:
			self.isPickedUp = false
			self.elasticMultiplier = position.y/2
			self.elasticAcceleration = acceleration * abs(elasticMultiplier)
			self.elasticLocation = starting_position - elasticMultiplier

func _ready():
	starting_position = position.y

func _physics_process(delta):
	if(isPickedUp):
		next_mouse_position = get_viewport().get_mouse_position()
		position.y += (-(next_mouse_position.y - prev_mouse_position.y) * delta)
		prev_mouse_position = next_mouse_position
	if(!isPickedUp && position.y != starting_position && elasticLocation != starting_position):
			if(position.y == elasticLocation):
				if(abs(elasticLocation) <= roundingThreshold):
					position.y = starting_position
					elasticLocation = starting_position
				else:
					elasticMultiplier = position.y/2
					elasticAcceleration = acceleration * abs(elasticMultiplier)
					elasticLocation = starting_position - elasticMultiplier
			speed = delta * elasticAcceleration
			position.y = move_toward(position.y, elasticLocation, speed)


func _on_area_3d_body_entered(body):
	if(speed):
		var heading = body.position - position
		var distance = heading.length()
		var direction = heading / distance
		body.apply_central_impulse(Vector3(-direction.x, -direction.y * speed * 100, -direction.z))
