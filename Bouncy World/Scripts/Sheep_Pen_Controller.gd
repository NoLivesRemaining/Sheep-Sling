extends Node3D

@onready var gameManager: Node = %Game_Manager
@onready var collectionPlayer: AudioStreamPlayer3D = $Collection_SFX

@export var sheepSpawnArray: Array[Node3D]

var sheepTracker: int = 0

func _ready() -> void:
	for sheep in sheepSpawnArray.size():
		sheepSpawnArray[sheep].set_visible(false)

func _on_collection_hitbox_body_entered(body: RigidBody3D) -> void:
	gameManager.add_Point()
	collectionPlayer.play()
	if(sheepTracker < 10):
		sheepSpawnArray[sheepTracker].set_visible(true)
		sheepSpawnArray[sheepTracker].get_child(-1).play("sheep_bounce")
	sheepTracker += 1
	body.queue_free()
