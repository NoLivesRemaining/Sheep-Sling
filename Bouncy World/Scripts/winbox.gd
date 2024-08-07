extends Node3D

@onready var game_manager = %GameManager
@export var sheepSpawnArray: Array[Node3D]
var sheepTracker = 0

func _ready():
	for index in sheepSpawnArray.size():
		sheepSpawnArray[index].set_visible(false)

func _on_win_area_body_entered(body):
	game_manager.add_point()
	sheepSpawnArray[sheepTracker].set_visible(true)
	sheepSpawnArray[sheepTracker].get_node("AnimationPlayer").play("sheep_bounce")
	sheepTracker += 1
	body.queue_free()
