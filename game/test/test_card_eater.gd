extends Control

@export var accepted_card_list : Array[GameManager.CardType] = []

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	
	
	return true


func _drop_data(at_position: Vector2, data: Variant) -> void:
	var card_data = data as CardData
	card_data.linked_physical_card.queue_free()
	
	pass
