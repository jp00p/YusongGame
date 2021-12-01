extends Area2D

# base scene for an item the user can look at/take/use

class_name game_item

var mouse_hovering = false

export (String) var item_name = "Default name"
export (String) var description = "Default description"
export (Resource) var taken_item = null

func _on_ItemBase_mouse_entered():
	mouse_hovering = true
	$Sprite.get_material().set_shader_param("width", 2)
	Global.hovered_item_name = item_name

func _on_ItemBase_mouse_exited():
	mouse_hovering = false
	$Sprite.get_material().set_shader_param("width", 0)
	Global.hovered_item_name = ""

func _input(event):
	# handle a click if we are in one of the modes
	var player = Global.get_player()
	if mouse_hovering and (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT):
		if Global.use_mode:
			if player.global_position.distance_to(self.global_position) <= 42:
				use_item()
			else:
				player.talk("that's too far away")
			Global.reset_mode()
				
		if Global.take_mode:
			take_item()
		if Global.look_mode:
			look_at_item()

func use_item():
	print("That item can't be used")

func take_item():
	var player = Global.get_player()
	
	if not self.taken_item:
		player.talk("I can't take that!")
	else:
		Global.add_inventory_item(self.taken_item)
		var item_name = self.taken_item.title
		player.talk("I've taken the %s" % item_name)
		queue_free()
	
func look_at_item():
	var player = Global.get_player()
	player.talk("%s" % description)
	print("%s: %s" % [item_name, description])

func talk_to():
	pass

func give_to():
	pass	
