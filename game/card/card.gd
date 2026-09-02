extends CenterContainer

var selected = false

var grabbed = false

@onready var mouse_offset = get_minimum_size() / 2 
@onready var select_offset = $Area2D.position #- ($Area2D/CollisionShape2D.shape.size)/2

@export var card_body : ColorRect

@export var name_label : Label
@export var cost_label : Label
@export var desc_label : Label
@export var type_label : Label
@export var card_data : CardData

var test_delta = 0.0

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


func _process(delta: float) -> void:
	if selected:
		var desired_pos = Vector2(0,-180) + (get_local_mouse_position() - select_offset)*0.4
		$CardBody.offset_transform_position = $CardBody.offset_transform_position.move_toward(desired_pos,delta*1500) 
	#test_delta += delta
	#if test_delta > 0.5 :
		#test_delta = 0
		#print(mouse_offset)
		#print(get_local_mouse_position())

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
	

	var test_preview = CenterContainer.new()
	test_preview.use_top_left = true

	var duplicate = card_body.duplicate()
	duplicate.offset_transform_position = Vector2.ZERO
	test_preview.add_child(duplicate)
	call_deferred("force_drag",card_data,test_preview)
	visible = false
	var all_other_cards = get_tree().get_nodes_in_group("card_in_hand")
	all_other_cards.erase(self)
	for card in all_other_cards:
		card.lock_select()
	pass



func un_grab():
	visible = true
	grabbed = false
	$CardBody.offset_transform_position = (get_local_mouse_position() - mouse_offset) 
	var all_other_cards = get_tree().get_nodes_in_group("card_in_hand")
	all_other_cards.erase(self)
	for card in all_other_cards:
		card.unlock_select()
	de_select()
	
	pass

func lock_select():
	$Area2D/CollisionShape2D.disabled = true
	pass

func unlock_select():
	$Area2D/CollisionShape2D.disabled = false
	pass

func de_select():
	selected = false
	card_body.z_index = 0
	

	$CardAnimator.play("de-select")
	pass

func select():
	selected = true
	card_body.z_index = 5
	$CardAnimator.play("select")
	var all_other_cards = get_tree().get_nodes_in_group("card_in_hand")
	all_other_cards.erase(self)
	for card in all_other_cards:
		if card.selected:
			card.de_select()
	pass


func _on_area_2d_mouse_entered() -> void:

	select()
	
	pass # Replace with function body.


func _on_area_2d_mouse_exited() -> void:

	if grabbed:
		return
	if selected:
		de_select()

	

	
	
	pass # Replace with function body.
