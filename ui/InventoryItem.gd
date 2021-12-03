extends ColorRect

var inventory_res = null
var mouse_hovering = false

func _ready():
	if inventory_res == null:
		queue_free()
	else:
		$TextureRect.texture = inventory_res.icon
		
func _process(delta):
	if mouse_hovering:
		modulate = Color.red
	else:
		modulate = Color.white

func _on_InventoryItem_mouse_entered():
	mouse_hovering = true
	Global.hovered_item_name = inventory_res.title

func _on_InventoryItem_mouse_exited():
	mouse_hovering = false
	Global.hovered_item_name = ""

func _input(event):
	# handle a click if we are in one of the modes
	var player = Global.get_player()
	if mouse_hovering and (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT):
		if Global.use_mode:
			Global.set_secondary_text("Use the %s on what?" % inventory_res.title)
			Global.use_item = inventory_res
		if Global.give_mode:
			pass
		if Global.look_mode:
			player.talk("%s" % inventory_res.description)
