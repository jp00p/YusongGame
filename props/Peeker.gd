extends Node2D



func _on_PeekTimer_timeout():
	$AnimationPlayer.play("peek")
	$PeekTimer.wait_time = rand_range(5,15)
	$HideTimer.wait_time = rand_range(1,2)

func _on_HideTimer_timeout():
	$AnimationPlayer.play("hide")
	
func start_hide_timer():
	$HideTimer.start()
