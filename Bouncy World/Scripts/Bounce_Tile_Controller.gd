extends Node3D

var isPickedUp: bool = false
var prevMousePosition: Vector2
var nextMousePosition: Vector2

var startingPosition: float
var targetLocation: float
var speed: float
var elasticityMultiplier: float
var elasticAcceleration: float
var baseAcceleration: float = 30

const roundingThreshold: float = 0.2

# Allows player to select individual tiles and sets previous Mouse Position
func _on_bounce_tile_click_area_input_event(camera: Node, event: InputEvent, position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			self.isPickedUp = true
			prevMousePosition = get_viewport().get_mouse_position()


func _input(event) -> void:
	if event is InputEventMouseButton:
# Tracks the players held mouse click to drag the Bounce Tile up and down regardless of where they move the mouse
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == false and self.isPickedUp == true:
			self.isPickedUp = false
			self.elasticityMultiplier = position.y/2
			self.elasticAcceleration = baseAcceleration * abs(elasticityMultiplier)
			self.targetLocation = startingPosition - elasticityMultiplier
# Resets all unheld Bounce Tiles positions on mouse click if they do not reset themselves in the first place
		elif event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true and self.isPickedUp == false and self.position.y != startingPosition:
			position.y = startingPosition
			targetLocation = startingPosition

func _ready() -> void:
	startingPosition = position.y

func _physics_process(delta) -> void:
	if(isPickedUp):
# Raises and lowers the Bounce Tile with the players mouse movement
		nextMousePosition = get_viewport().get_mouse_position()
		position.y += (-(nextMousePosition.y - prevMousePosition.y) * delta)
		prevMousePosition = nextMousePosition

# When released the Bounce Tile will set a target location at half the height it was raised on 
# the opposite side of the Y axis to how far they were dragged. The Bounce Tile will move towards 
# this target location. Once it reaches it, it will set a new target location with the same parameters
# as the first, gradually losing momentum. Once momentum falls below the rounding threshold, its position will
# reset.
	if(!isPickedUp and position.y != startingPosition and targetLocation != startingPosition):
			if(position.y == targetLocation):
				if(abs(targetLocation) <= roundingThreshold):
					position.y = startingPosition
					targetLocation = startingPosition
				else:
					elasticityMultiplier = position.y/2
					elasticAcceleration = baseAcceleration * abs(elasticityMultiplier)
					targetLocation = startingPosition - elasticityMultiplier
			else:
				speed = elasticAcceleration * delta
				position.y = move_toward(position.y, targetLocation, speed)

# When a Bounce Tile impacts a sheep, it will apply a force to bounce them upwards in a direction
func _on_bounce_tile_click_area_body_entered(sheep : RigidBody3D) -> void:
	if(speed):
		var distance = sheep.position - position
		var magnitude = distance.length()
		var direction = distance / magnitude
		sheep.apply_central_impulse(Vector3(-direction.x, -direction.y * speed * 100, -direction.z))
