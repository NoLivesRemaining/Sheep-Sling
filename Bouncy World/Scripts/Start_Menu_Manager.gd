extends Node3D

@onready var playTimer: Timer = $Menu_Canvas/Play_Button/Play_Button_Timer
@onready var fadeAnimator: AnimationPlayer = $Menu_Canvas/Fade_In_Out_Curtain/Fade_In_Out_Animation_Player
@onready var sheepSlider : HSlider = $Menu_Canvas/Sheep_Count_Slider
@onready var nightMode : CheckBox = $Menu_Canvas/CheckBox

func _on_play_button_pressed() -> void:
	playTimer.start()
	fadeAnimator.play("fadeIn")


func _on_play_button_timer_timeout() -> void:
	SettingVariables.sheepTotal = sheepSlider.value
	SettingVariables.nightMode = nightMode.toggle_mode
	get_tree().change_scene_to_file("res://Scenes/Introduction.tscn")
