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

func _on_InventoryItem_mouse_exited():
	mouse_hovering = false
