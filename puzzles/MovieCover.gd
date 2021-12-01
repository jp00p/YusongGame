extends Node2D

export (String) var movie_name = "2001: A Space Odyssey"
export (int) var movie_year = 1995

onready var cover_material = self.get_material()
var selected = false
var mouse_hover = false
var rest_point

var current_zone
var rest_zones = []
var snap_distance = 35

func _ready():
	rest_zones = get_tree().get_nodes_in_group("dropzone")
	rest_point = global_position

func _physics_process(delta):
	if selected:
		# attached to mouse
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	else:
		# attached elsewhere
		global_position = lerp(global_position, rest_point, 10 * delta)

func _unhandled_input(event):
	# initial click + drag
	if event is InputEventMouseButton and event.pressed and mouse_hover:
		get_tree().set_input_as_handled()
		self.raise()
		selected = true
	
	# release mouse
	if event is InputEventMouseButton and not event.pressed and selected and mouse_hover:
		get_tree().set_input_as_handled()
		selected = false
		
		if is_close_to_zone():
			# snap to a zone
			rest_point = attach_to_zone()
		else:
			# leave it where the mouse was
			rest_point = get_global_mouse_position()
			if current_zone:
				current_zone.deselect()
				current_zone = null
			
func is_close_to_zone():
	for zone in rest_zones:
		var distance = global_position.distance_to(zone.global_position)
		if distance < snap_distance:
			return true
	return false
	
func attach_to_zone():
	# good lord...
	for target_zone in rest_zones:
		# find the closest rest zone
		var distance = global_position.distance_to(target_zone.global_position)
		var replacement_card
		if distance < snap_distance:
			# if there's a card in the zone we're dropping
			if target_zone.card != null and target_zone.card != self:
				replacement_card = target_zone.card # get the old card
				replacement_card.rest_point = rest_point # make the card we're swapping have our current rest point
					
			if current_zone != null and replacement_card == null:
				# we were in a zone, and not replacing a card
				current_zone.deselect()
			elif current_zone != null and replacement_card != null:
				# we were in a zone and we ARE replacing a card
				current_zone.select(replacement_card)
			target_zone.select(self)
			return target_zone.global_position


func _on_Area2D_mouse_entered():
	mouse_hover = true

func _on_Area2D_mouse_exited():
	mouse_hover = false
