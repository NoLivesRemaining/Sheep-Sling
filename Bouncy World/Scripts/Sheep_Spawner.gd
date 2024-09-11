extends Marker3D

@onready var gameManager: Node = %Game_Manager

var spawnCount: int = 0

# Used as a buffer to prevent Sheep from spawning on top of each other.
func _on_spawn_timer_timeout() -> void:
	if(spawnCount != gameManager.sheepCount):
		gameManager.spawn_Sheep()
		spawnCount += 1
