extends Marker3D

var spawnCount = 0

@onready var game_manager = %GameManager


func _on_timer_timeout():
	if(spawnCount != game_manager.sheepCount):
		game_manager.spawn()
		spawnCount += 1
