extends HBoxContainer

# has a bunch of card anchors to which cards are attached

func create_card_anchor() -> Control :
	
	var new_anchor = Control.new()
	new_anchor.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	new_anchor.connect("tree_exited",re_evalute_dummy_fill)
	add_child(new_anchor)
	move_child(new_anchor,0)
	#new_anchor.move_to_front()
	re_evalute_dummy_fill()
	return new_anchor

func re_evalute_dummy_fill():
	$DummyFill.size_flags_stretch_ratio = 5.2 - (get_child_count() * 0.75)
	pass
