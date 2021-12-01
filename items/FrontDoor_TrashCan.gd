extends game_item

var opened = false
onready var key = preload("res://items/HouseKey.tscn")

func use_item():
	print("Using trash can")
	if not opened:
		print("Opening")
		opened = true
		$Sprite.texture.current_frame = 1
		var k = key.instance()
		k.global_position = $Position2D.global_position
		get_tree().get_root().add_child(k)
