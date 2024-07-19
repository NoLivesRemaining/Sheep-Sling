extends Node

var sheep = preload("res://Scenes/sheep.tscn")

var sheepRandomiser = RandomNumberGenerator.new()
var sheepCount
var sheepScore = 0

func _ready():
	sheepCount = sheepRandomiser.randi_range(3, 6)

func add_point():
	sheepScore += 1
	check_Score()
	

func spawn():
	var new_sheep = sheep.instantiate()
	new_sheep.global_position = $Spawnpoint.global_position
	add_child(new_sheep)


func check_Score():
	if(sheepScore == sheepCount):
		print("Win!")
