extends Position2D
class_name Dropzone

signal card_dropped(card)

export (int) var year_expected = 1999

var active = false
var card

func _draw():
	draw_circle(Vector2.ZERO, 25, Color.white)

func select(new_card):
	card = new_card
	card.current_zone = self
	#card.rest_point = global_position
		
func deselect():
	card = null

func _process(delta):
	$Label.text = str(card)
