extends Node

var sheep = preload("res://Scenes/sheep.tscn")

var sheepRandomiser = RandomNumberGenerator.new()
var sheepCount
var sheepScore = 0

func _ready():
	sheepCount = sheepRandomiser.randf_range(3, 6)
	for n in sheepCount:
		var new_sheep = sheep.instantiate()

func add_point():
	sheepScore += 1
	check_Score()
	

func check_Score():
	if(sheepScore == sheepCount):
		print("Win!")
