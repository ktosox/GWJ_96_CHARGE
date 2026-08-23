extends CenterContainer

var selected = false

var grabbed = false

var mouse_offset : Vector2

@export var card_body : ColorRect

@export var name_label : Label
@export var cost_label : Label
@export var desc_label : Label
@export var type_label : Label
@export var card_data : CardData


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if card_data != null:
		load_card_data(card_data)

	#call_deferred("un_grab")

	pass # Replace with function body.

func load_card_data(data : CardData):
	data.linked_physical_card = self
	name_label.text = data.name
	cost_label.text = str(data.energy_cost)
	desc_label.text = data.description
	type_label.text = CardData.CardType.keys()[data.type]
	pass



func announce_grab():
	var all_other_cards = get_tree().get_nodes_in_group("Card")
	all_other_cards.erase(self)
	
	for card in all_other_cards:
		card.un_grab()
	
	pass


func move_away(global_pos : Vector2):
	
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LMB") and selected:
		
		grab()

	if event.is_action_released("LMB") and grabbed:
		un_grab()


func grab():
	grabbed = true
	announce_grab()
	mouse_offset = get_local_mouse_position()

	var test_preview = CenterContainer.new()
	test_preview.use_top_left = true

	var duplicate = card_body.duplicate()
	duplicate.offset_transform_position = Vector2.ZERO
	test_preview.add_child(duplicate)
	call_deferred("force_drag",card_data,test_preview)
	visible = false
	pass



func un_grab():
	visible = true
	grabbed = false

	pass


func de_select():
	selected = false
	card_body.z_index = 0

	$CardAnimator.play("de-select")
	pass


func _on_area_2d_mouse_entered() -> void:

	var all_other_cards = get_tree().get_nodes_in_group("card_in_hand")
	all_other_cards.erase(self)
	for card in all_other_cards:
		if card.grabbed:
			return
	selected = true
	for card in all_other_cards:
		if card.selected:
			card.de_select()
	card_body.z_index = 5
	
	$CardAnimator.play("select")
	pass # Replace with function body.


func _on_area_2d_mouse_exited() -> void:
	de_select()

	pass # Replace with function body.
