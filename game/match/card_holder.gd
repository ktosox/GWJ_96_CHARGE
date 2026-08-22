extends HBoxContainer

# has a bunch of card anchors to which cards are attached

func create_card_anchor() -> Control :
	var new_anchor = Control.new()
	new_anchor.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	add_child(new_anchor)
	move_child(new_anchor,0)
	#new_anchor.move_to_front()
	return new_anchor
