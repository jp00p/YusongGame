extends CanvasLayer

onready var inventory_item = preload("res://ui/InventoryItem.tscn")

func _ready():
	Global.connect("hovered_item_name", self, "update_hovered_item")
	Global.connect("item_added", self, "item_added")
	Global.connect("item_removed", self, "item_removed")
	$Top/ItemName.text = ""

func _on_Look_pressed():
	Global.toggle_looking(!Global.look_mode)

func _on_Take_pressed():
	Global.toggle_taking(!Global.take_mode)

func _on_Use_pressed():
	Global.toggle_using(!Global.use_mode)

func update_hovered_item(item_text):
	$Top/ItemName.text = item_text

func item_added(item):
	var i = inventory_item.instance()
	i.inventory_res = item
	$Bottom/MarginContainer/HBoxContainer/Items/ScrollContainer/MarginContainer/GridContainer.add_child(i)
	
func item_removed(item):
	pass
