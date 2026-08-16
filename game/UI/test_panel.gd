extends Panel

var tracked_cards = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_test_remove_card_pressed() -> void:
	
	var card = tracked_cards.pop_front()
	$"..".remove_card(card)
	pass # Replace with function body.


func _on_test_add_card_pressed() -> void:
	var card = $"..".add_card(CardData.new())
	tracked_cards.push_back(card)
	pass # Replace with function body.
