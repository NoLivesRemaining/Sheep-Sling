extends Node

var sheep = preload("res://Scenes/sheep.tscn")

var sheepRandomiser = RandomNumberGenerator.new()
var sheepCount
var sheepScore = 0

var AnimationArray = ["position 1", "position 2", "position 3", "position 4"]
var animationnumber = 0

@onready var timer = $Timer
@onready var animationplayer = $"../Camera3D/AnimationPlayer"



func _ready():
	sheepCount = sheepRandomiser.randi_range(6, 10)
	$UI/SheepCountText.text = str(sheepScore) + "/" + str(sheepCount)

func add_point():
	sheepScore += 1
	$UI/SheepCountText.text = str(sheepScore) + "/" + str(sheepCount)
	check_Score()

func spawn():
	var new_sheep = sheep.instantiate()
	new_sheep.global_position = $Spawnpoint.global_position
	add_child(new_sheep)

func _input(event):
	if event.is_action_pressed("Right") and !animationplayer.is_playing():
		animationnumber += 1
		if animationnumber == 4:
			animationnumber = 0
		animationplayer.play(AnimationArray[animationnumber])

func CheckAnimation():
	match animationnumber:
		0:
			animationplayer.play("Win")
		1:
			animationplayer.play("Win2")
		2:
			animationplayer.play("Win3")
		3:
			animationplayer.play("Win4")
	

func check_Score():
	if(sheepScore == sheepCount):
		CheckAnimation()
		$UI/Wintext/AnimationPlayer.play("TextFadeIn")
		$UI/SubViewportContainer.set_visible(false)
		$UI/SheepCountText.set_visible(false)
		$WinSound.play()
		timer.start()

func _on_timer_timeout():
	$UI/ColorRect/AnimationPlayer.play("fadein")
	$ResetTimer.start()

func _on_reset_timer_timeout():
	get_tree().reload_current_scene()
