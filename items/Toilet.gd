extends "res://items/ItemBase.gd"

var opened = false

func use_item():
	var player = Global.get_player()
	if not opened:
		$Sprite.texture.current_frame = 1
		player.talk("i have opened the toilet")
		opened = true
	else:
		$Sprite.texture.current_frame = 0
		player.talk("i have closed the toilet")
		opened = false
