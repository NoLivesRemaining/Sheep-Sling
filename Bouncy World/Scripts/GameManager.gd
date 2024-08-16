extends Node

var sheep = preload("res://Scenes/sheep.tscn")

var sheepRandomiser = RandomNumberGenerator.new()
var sheepCount
var sheepScore = 0

@onready var timer = $Timer

func _ready():
	sheepCount = sheepRandomiser.randi_range(6, 10)
	$UI/Wintext.set_visible(false)
	$UI/SheepCountText.text = str(sheepScore) + "/" + str(sheepCount)

func add_point():
	sheepScore += 1
	$UI/SheepCountText.text = str(sheepScore) + "/" + str(sheepCount)
	check_Score()

func spawn():
	var new_sheep = sheep.instantiate()
	new_sheep.global_position = $Spawnpoint.global_position
	add_child(new_sheep)

func check_Score():
	if(sheepScore == sheepCount):
		$UI/Wintext.set_visible(true)
		$UI/SheepCountText.set_visible(false)
		timer.start()

func _on_timer_timeout():
	get_tree().reload_current_scene()



