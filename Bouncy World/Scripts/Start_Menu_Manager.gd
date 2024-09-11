extends Node3D

@onready var playTimer: Timer = $Menu_Canvas/Play_Button/Play_Button_Timer
@onready var fadeAnimator: AnimationPlayer = $Menu_Canvas/Fade_In_Out_Curtain/Fade_In_Out_Animation_Player

func _on_play_button_pressed() -> void:
	playTimer.start()
	fadeAnimator.play("fadeIn")


func _on_play_button_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/Introduction.tscn")
