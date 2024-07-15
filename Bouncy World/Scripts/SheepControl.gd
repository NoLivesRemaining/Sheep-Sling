extends RigidBody3D

var startingPosition
var startingRotation
const minimumVelocity = 0.05

func _ready():
	startingPosition = position.y
	startingRotation = rotation

func _process(delta):
	if(self.rotation != startingRotation):
		resetPosition()

func resetPosition():
	if(linear_velocity.length() < minimumVelocity):
		var tween = create_tween()
		tween.tween_property(self, "rotation", startingRotation, 0.5)


