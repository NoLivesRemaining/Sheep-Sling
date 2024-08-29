extends RigidBody3D

var startingRotation
var currentRotation
const minimumVelocity = 0.025

@onready var SFX = $SheepSound
@onready var Bonk = $BonkSound

func _ready():
	startingRotation = rotation

func _process(delta):
	if(self.rotation != startingRotation and linear_velocity.length() < minimumVelocity):
		resetRotation()

func resetRotation():
	currentRotation = rotation.y
	var newRotation = Vector3(startingRotation.x, currentRotation, startingRotation.z)
	var tween = create_tween()
	tween.tween_property(self, "rotation", newRotation, 0.5)

func _on_body_entered(body: Node) -> void:
	if(body.is_in_group("BonkBoundaries") and linear_velocity.length() > minimumVelocity * 100):
		self.Bonk.play()
	elif (!self.SFX.playing and linear_velocity.length() > minimumVelocity * 100):
		self.SFX.play()
	
