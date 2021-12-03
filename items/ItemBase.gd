extends Area2D

# base scene for an item the user can look at/take/use

class_name game_item

var mouse_hovering = false
var player_is_here = false

export (String) var item_name = ""
export (String) var description = ""
export (Resource) var taken_item = null
export (bool) var is_door = false
export (bool) var is_locked = false
export (String) var locked_message = "It's locked."
export (Resource) var required_key = null
export (bool) var floating = null



func _ready():
	if is_door and is_locked:
		$Sprite.texture.current_frame = 0
	if floating:
		$AnimationPlayer.play("floating")

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
	if is_door and Input.is_action_just_pressed("interact") and player_is_here:
		handle_door()
	if mouse_hovering and (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT):
		if Global.use_mode:
			if player.global_position.distance_to(self.global_position) <= 42:
				use_item()
			else:
				Global.player_speak("That's too far away.")
			Global.reset_mode()
				
		if Global.take_mode:
			take_item()
			
		if Global.look_mode:
			look_at_item()

func use_item():
	if is_door and is_locked and Global.use_item == required_key:
		Global.remove_inventory_item(required_key)
		unlock()
		Global.player_speak("I've unlocked the door.")
	else:
		Global.player_speak("I can't do that.")

func handle_door():
	if is_locked:
		Global.player_speak(locked_message)
	else:
		$DoorTimer.start()
		$Sprite.texture.current_frame = 1
		var goto = $Spawn.global_position
		Global.teleport_player(goto)

func take_item():
	if not self.taken_item:
		Global.player_speak("I can't take that!")
	else:
		Global.add_inventory_item(self.taken_item)
		var item_name = self.taken_item.title
		Global.player_speak("I've taken the %s" % item_name)
		queue_free()
	
func look_at_item():
	Global.player_speak("%s" % description)

func talk_to():
	pass

func give_to():
	pass

func unlock():
	Global.player_speak("I've unlocked the %s" % item_name)
	is_locked = false

func _on_DoorTimer_timeout():
	# close the door!
	$Sprite.texture.current_frame = 0

func _on_ItemBase_body_entered(body):
	if body is yusong:
		player_is_here = true
		
func _on_ItemBase_body_exited(body):
	if body is yusong:
		player_is_here = false


func _on_ItemBase_area_entered(area):
	pass # Replace with function body.


func _on_ItemBase_area_exited(area):
	pass # Replace with function body.
