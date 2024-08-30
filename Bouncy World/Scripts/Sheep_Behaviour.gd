extends RigidBody3D

@onready var bahSFX: AudioStreamPlayer3D = $Sheep_Bah_SFX
@onready var bonkSFX: AudioStreamPlayer3D = $Wall_Bonk_SFX

var startingRotation: Vector3
var currentRotation: float

const minimumVelocity: float = 0.025

func _ready():
	startingRotation = rotation

func _process(delta):
	if(self.rotation != startingRotation and linear_velocity.length() < minimumVelocity):
		reset_Rotation()

# Will reset the Sheeps rotation with a tween and stand them up when they slow to a certain movement
func reset_Rotation():
	currentRotation = rotation.y
	var newRotation = Vector3(startingRotation.x, currentRotation, startingRotation.z)
	var rotationTween = create_tween()
	rotationTween.tween_property(self, "rotation", newRotation, 0.5)


func _on_body_entered(body):
# Plays a Bonk sound effect whenever the sheep impacts any of the invisible boundary walls
	if(body.is_in_group("Boundary_Walls") and linear_velocity.length() > minimumVelocity * 100):
		self.bonkSFX.play()
# Plays a randomised Bah sound when the sheep impacts anything once its moving beyond a certain speed
	elif (!self.bahSFX.playing and linear_velocity.length() > minimumVelocity * 100):
		self.bahSFX.play()
	
