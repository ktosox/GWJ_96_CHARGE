extends Control

signal card_consumed(card_data : CardData)

@export var accepted_card_list : Array[CardData.CardType] = []

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	var card_data = data as CardData
	var check_result = accepted_card_list.has(card_data.type) as bool
	return check_result



func _drop_data(at_position: Vector2, data: Variant) -> void:
	var card_data = data as CardData
	emit_signal("card_consumed")
	#card_data.linked_physical_card.queue_free()
	
	pass
