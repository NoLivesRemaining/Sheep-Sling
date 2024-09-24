extends Node

@onready var resetTimer: Timer = $Game_Reset_Timer
@onready var cameraAnimator: AnimationPlayer = $"../Main_Camera/Main_Camera_Animation_Player"
@onready var sheepCountUI: Label = $Main_UI/Sheep_Count_Text
@onready var returnButton: Button = $Main_UI/Return_Button
@onready var spawnPoint: Marker3D = $Sheep_Spawner
@onready var textAnimator: AnimationPlayer = $Main_UI/Win_Text/Win_Text_Animation_Player
@onready var sheepViewPort: SubViewportContainer = $Main_UI/Sheep_Count_Sheep_Viewport
@onready var winSFX: AudioStreamPlayer3D = $Win_SFX
@onready var fadeOutAnimator: AnimationPlayer = $Main_UI/Fade_In_Out_Curtain/Fade_In_Out_Animation_Player
@onready var fadeOutTimer: Timer = $Main_UI/Fade_In_Out_Curtain/Fade_Out_Timer
@onready var skyBox: WorldEnvironment = $"../Scene_Decor/Sky_Box"
@onready var nightLight : Node3D = $"../Scene_Decor/Night_Mode"
@onready var dayLight : Node3D = $"../Scene_Decor/Day_Mode"

@export var skyMaterials: Array[ProceduralSkyMaterial]

var sheep:  = preload("res://Scenes/Sheep_Prefab.tscn")

var sheepRandomiser: RandomNumberGenerator = RandomNumberGenerator.new()
var sheepCount: float
var sheepScore: float = 0

var animationArray: Array = ["View_Position_1", "View_Position_2", "View_Position_3", "View_Position_4"]
var animationNumber: int = 0

func _ready() -> void:
	sheepCount = sheepRandomiser.randi_range(10, SettingVariables.sheepTotal)
	sheepCountUI.text = str(sheepScore) + "/" + str(sheepCount)
	nightLight.set_visible(SettingVariables.nightMode)
	dayLight.set_visible(!SettingVariables.nightMode)
	if (SettingVariables.nightMode):
		skyBox.environment.sky.set_material(skyMaterials[1])
	else:
		skyBox.environment.sky.set_material(skyMaterials[0])

func add_Point() -> void:
	sheepScore += 1
	sheepCountUI.text = str(sheepScore) + "/" + str(sheepCount)
	check_Score()

func check_Progress() -> int:
	var floatPercent = (sheepScore / sheepCount ) * 100
	var percentageComplete = floatPercent/10 as int
	return percentageComplete

# Called by Sheep Spawner
func spawn_Sheep() -> void:
	var newSheep = sheep.instantiate()
	add_child(newSheep)
	newSheep.global_position = spawnPoint.global_position
	

# Allows the player to shift the camera around the scene
func _input(event) -> void:
	if event.is_action_pressed("Right") and !cameraAnimator.is_playing():
		animationNumber += 1
		if animationNumber == 4:
			animationNumber = 0
		cameraAnimator.play(animationArray[animationNumber])

# If win condition is met, will begin the game end and reset sequence
func check_Score() -> void:
	if(sheepScore == sheepCount):
		check_Animation()
		textAnimator.play("TextFadeIn")
		returnButton.set_visible(true)
		sheepViewPort.set_visible(false)
		sheepCountUI.set_visible(false)
		winSFX.play()
		fadeOutTimer.start()

# Plays a different win animation based on the current camera position to avoid jittering
func check_Animation() -> void:
	match animationNumber:
		0:
			cameraAnimator.play("Win_Position_1")
		1:
			cameraAnimator.play("Win_Position_2")
		2:
			cameraAnimator.play("Win_Position_3")
		3:
			cameraAnimator.play("Win_Position_4")

func _on_fade_out_timer_timeout() -> void:
	fadeOutAnimator.play("fadeIn")
	resetTimer.start()

func _on_game_reset_timer_timeout() -> void:
	get_tree().reload_current_scene()


func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Start_Menu.tscn")
