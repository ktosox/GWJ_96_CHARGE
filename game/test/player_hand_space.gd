extends Control

@export var card_holder : Control

var card_scene = preload("res://UI/test_card_place_holder.tscn") as PackedScene

var card_slot_scene = preload("res://UI/card_slot.tscn") as PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func add_card(data : CardData) -> Node:
	var new_card = card_scene.instantiate()
	
	var new_card_slot = card_slot_scene.instantiate()
	new_card_slot.add_child(new_card)
	card_holder.add_child(new_card_slot)
	return new_card

func remove_card(card : Node) -> bool:
	var slot = card.get_parent()
	if card_holder.get_children().has(slot):
		slot.queue_free()
		return true
	return false
