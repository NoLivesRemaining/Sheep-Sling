extends Node3D


func _on_play_pressed():
	$CanvasLayer/Play/PlayTimer.start()
	$CanvasLayer/ColorRect/AnimationPlayer.play("fadein")


func _on_play_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/va_scene.tscn")
