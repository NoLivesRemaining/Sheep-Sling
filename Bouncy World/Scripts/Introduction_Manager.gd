extends Node3D

@onready var vaPlayer: AudioStreamPlayer = $Introdution_VA
@onready var textTimer1: Timer  = $Sentence_1_Text/Sentence_1_Timer
@onready var textTimer2: Timer = $Sentence_2_Text/Sentence_2_Timer
@onready var text1: Label = $Sentence_1_Text
@onready var text2: Label = $Sentence_2_Text

func _on_start_timer_timeout():
	vaPlayer.play()
	textTimer1.start()

func _on_sentence_1_timer_timeout():
	text1.set_visible(true)
	textTimer2.start()

func _on_sentence_2_timer_timeout():
	text2.set_visible(true)

func _on_introdution_va_finished():
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
