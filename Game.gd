extends Node2D

func start_fade():
	$Transition/AnimationPlayer.play("fade_to_black")
	
func finished_fading():
	$Transition/AnimationPlayer.play("fade_from_black")

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_RIGHT and (Global.use_mode or Global.take_mode or Global.look_mode):
		Global.reset_mode()
