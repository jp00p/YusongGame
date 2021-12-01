extends Node

signal item_added(item)
signal item_removed(item)

var hovered_item_name = "" setget set_hovered_item_name

var look_mode = false
var use_mode = false
var take_mode = false

signal hovered_item_name(item_text)

var cursors = {
	"take" : load("res://assets/hand_icon.png"),
	"look" : load("res://assets/magnifying_glass.png"),
	"use" : load("res://assets/use_cursor.png"),
	"normal" : load("res://assets/normal_cursor.png")
}

var inventory = []

const cant_use_messages = ["I can't use that", "What do you expect me to do with that?", "That can't be done", "I don't think so"]
const cant_take_messages = ["I can't take that", "How would I take that?", "Why would I take that?", "There's no point in taking that"]

func _ready():
	Input.set_custom_mouse_cursor(cursors["normal"])

func set_cursor(cursor):
	Input.set_custom_mouse_cursor(cursors[cursor])

func get_player():
	# find the player wherever the node may be
	var player = get_tree().get_nodes_in_group("player")
	return player[0]

func teleport_player(teleport_to:Vector2):
	# move the player node to coords
	var p = get_player()
	screen_transition()
	yield(get_tree().create_timer(0.33), "timeout")
	p.global_position = teleport_to

func screen_transition():
	# start screen transition
	var game = get_node("/root/Game")
	game.start_fade()
	
func set_player_movement(can_move):
	# start/stop player movement
	var player = get_player()
	player.set_physics_process(can_move)

func toggle_looking(is_looking):
	look_mode = is_looking
	# set cursor
	if is_looking:
		set_cursor("look")
	else:
		set_cursor("normal")

func toggle_taking(is_taking):
	take_mode = is_taking
	if is_taking:
		set_cursor("take")
	else:
		set_cursor("normal")

func toggle_using(is_using):
	use_mode = is_using
	var player = get_player()
	if is_using:
		set_cursor("use")
	else:
		set_cursor("normal")

func reset_mode():
	look_mode = false
	use_mode = false
	take_mode = false
	set_cursor("normal")
	set_player_movement(true)

func set_hovered_item_name(val):
	emit_signal("hovered_item_name", val)

func add_inventory_item(item):
	inventory.push_front(item)
	emit_signal("item_added", item)
	print(inventory)
