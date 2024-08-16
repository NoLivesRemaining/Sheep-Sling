extends Node3D

@onready var Audio = $AudioStreamPlayer
@onready var TextTimer = $Label/TextTimer
@onready var TextTimer2 = $Label2/TextTimer2

func _on_timer_timeout():
	Audio.play()
	TextTimer.start()

func _on_audio_stream_player_finished():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	


func _on_text_timer_timeout():
	$Label.set_visible(true)
	TextTimer2.start()


func _on_text_timer_2_timeout():
	$Label2.set_visible(true)
