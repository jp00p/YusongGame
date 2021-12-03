extends game_item

var messages = ["A smelly trash can.", "It's full of trash.", "A stinky trash can.", "Smells like garbage."]
var opened = false

func _ready():
	var msg = messages[randi() % messages.size()]
	description = msg
	
func use_item():
	if not opened:
		$Sprite.texture.current_frame = 1
		opened = true
