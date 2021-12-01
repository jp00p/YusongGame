extends Area2D

var player_is_here = false

func interact():
	$Timer.start()
	var goto = $Spawn.global_position
	Global.teleport_player(goto)
	$Sprite/Door.visible = false

func _on_Timer_timeout():
	$Sprite/Door.visible = true

func _unhandled_input(event):
	if Input.is_action_just_pressed("interact") and player_is_here:
		interact()

func _on_Door_area_entered(area):
	player_is_here = true
	$Sprite.material.set_shader_param("width", 2)

func _on_Door_area_exited(area):
	player_is_here = false
	$Sprite.material.set_shader_param("width", 0)
