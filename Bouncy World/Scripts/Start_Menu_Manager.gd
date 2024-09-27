extends Node3D

@onready var playTimer: Timer = $Menu_Canvas/Play_Button/Play_Button_Timer
@onready var fadeAnimator: AnimationPlayer = $Menu_Canvas/Fade_In_Out_Curtain/Fade_In_Out_Animation_Player
@onready var sheepSlider : HSlider = $Menu_Canvas/Sheep_Count_Slider
@onready var nightMode : CheckBox = $Menu_Canvas/CheckBox
@onready var skyBox: WorldEnvironment = $Scene_Dressing/Sky_Box
@onready var nightLight : Node3D = $Scene_Dressing/Night_Mode
@onready var dayLight : Node3D = $Scene_Dressing/Day_Mode

@export var skyMaterials: Array[ProceduralSkyMaterial]


func _on_play_button_pressed() -> void:
	playTimer.start()
	fadeAnimator.play("fadeIn")


func _on_play_button_timer_timeout() -> void:
	SettingVariables.sheepTotal = sheepSlider.value
	get_tree().change_scene_to_file("res://Scenes/Introduction.tscn")


func _on_night_mode_checkbox_toggled(toggled_on: bool) -> void:
	SettingVariables.nightMode = toggled_on
	if (toggled_on):
		skyBox.environment.sky.set_material(skyMaterials[1])
	else:
		skyBox.environment.sky.set_material(skyMaterials[0])
		
	nightLight.set_visible(SettingVariables.nightMode)
	dayLight.set_visible(!SettingVariables.nightMode)
