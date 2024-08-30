extends Node

@onready var resetTimer: Timer = $Game_Reset_Timer
@onready var cameraAnimator: AnimationPlayer = $"../Main_Camera/Main_Camera_Animation_Player"
@onready var sheepCountUI: Label = $Main_UI/Sheep_Count_Text
@onready var spawnPoint: Marker3D = $Sheep_Spawner
@onready var textAnimator: AnimationPlayer = $Main_UI/Win_Text/Win_Text_Animation_Player
@onready var sheepViewPort: SubViewportContainer = $Main_UI/Sheep_Count_Sheep_Viewport
@onready var winSFX: AudioStreamPlayer3D = $Win_SFX
@onready var fadeOutAnimator: AnimationPlayer = $Main_UI/Fade_In_Out_Curtain/Fade_In_Out_Animation_Player
@onready var fadeOutTimer: Timer = $Main_UI/Fade_In_Out_Curtain/Fade_Out_Timer

var sheep:  = preload("res://Scenes/Sheep_Prefab.tscn")

var sheepRandomiser: RandomNumberGenerator = RandomNumberGenerator.new()
var sheepCount: int
var sheepScore: int = 0

var animationArray: Array = ["View_Position_1", "View_Position_2", "View_Position_3", "View_Position_4"]
var animationNumber: int = 0

func _ready():
	sheepCount = sheepRandomiser.randi_range(6, 10)
	sheepCountUI.text = str(sheepScore) + "/" + str(sheepCount)

func add_Point():
	sheepScore += 1
	sheepCountUI.text = str(sheepScore) + "/" + str(sheepCount)
	check_Score()

# Called by Sheep Spawner
func spawn_Sheep():
	var newSheep = sheep.instantiate()
	add_child(newSheep)
	newSheep.global_position = spawnPoint.global_position
	

# Allows the player to shift the camera around the scene
func _input(event):
	if event.is_action_pressed("Right") and !cameraAnimator.is_playing():
		animationNumber += 1
		if animationNumber == 4:
			animationNumber = 0
		cameraAnimator.play(animationArray[animationNumber])

# If win condition is met, will begin the game end and reset sequence
func check_Score():
	if(sheepScore == sheepCount):
		check_Animation()
		textAnimator.play("TextFadeIn")
		sheepViewPort.set_visible(false)
		sheepCountUI.set_visible(false)
		winSFX.play()
		fadeOutTimer.start()

# Plays a different win animation based on the current camera position to avoid jittering
func check_Animation():
	match cameraAnimator:
		0:
			cameraAnimator.play("Win_Position_1")
		1:
			cameraAnimator.play("Win_Position_2")
		2:
			cameraAnimator.play("Win_Position_3")
		3:
			cameraAnimator.play("Win_Position_4")

func _on_fade_out_timer_timeout():
	fadeOutAnimator.play("fadeIn")
	resetTimer.start()

func _on_game_reset_timer_timeout():
	get_tree().reload_current_scene()


