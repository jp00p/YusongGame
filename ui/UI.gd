extends CanvasLayer

onready var inventory_item = preload("res://ui/InventoryItem.tscn")
onready var inventory = $Bottom/MarginContainer/HBoxContainer/Items/ScrollContainer/MarginContainer/GridContainer

func _ready():
	Global.connect("hovered_item_name", self, "update_hovered_item")
	Global.connect("item_added", self, "item_added")
	Global.connect("item_removed", self, "item_removed")
	Global.connect("set_secondary_text", self, "set_secondary_text")
	$Top/VBoxContainer/ItemName.text = ""
	$Top/VBoxContainer/SecondaryTopText.text = ""

func _on_Look_pressed():
	Global.toggle_looking(!Global.look_mode)

func _on_Take_pressed():
	Global.toggle_taking(!Global.take_mode)

func _on_Use_pressed():
	Global.toggle_using(!Global.use_mode)

func set_secondary_text(message):
	$Top/VBoxContainer/SecondaryTopText.text = message

func update_hovered_item(item_text):
	$Top/VBoxContainer/ItemName.text = item_text

func item_added(item):
	var i = inventory_item.instance()
	i.inventory_res = item
	inventory.add_child(i)
	
func item_removed(item):
	for c in inventory.get_children():
		if c.inventory_res == item:
			c.queue_free()
