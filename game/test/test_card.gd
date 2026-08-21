extends CenterContainer

var selected = false

var grabbed = false

var mouse_offset : Vector2

@export var resting_anchor : Control

@export var name_label : Label

@export var card_data : CardData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card_data.linked_physical_card = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if grabbed:
		position -= mouse_offset - get_local_mouse_position()

		mouse_offset = get_local_mouse_position()

	pass

func announce_grab():
	var all_other_cards = get_tree().get_nodes_in_group("Card")
	all_other_cards.erase(self)
	
	for card in all_other_cards:
		card.un_grab()
	
	pass

func announce_select():
	var all_other_cards = get_tree().get_nodes_in_group("Card")
	all_other_cards.erase(self)
	
	for card in all_other_cards:
		card.move_away(global_position)
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

	var test_preview = ColorRect.new()
	test_preview.size = Vector2(20,20)
	call_deferred("force_drag",card_data,test_preview)
	visible = false
	pass



func un_grab():
	visible = true
	grabbed = false
	pass


func _on_mouse_entered() -> void:
	selected = true
	top_level = true
	$CardAnimator.play("select")
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	selected = false
	top_level = false
	$CardAnimator.play("de-select")
	pass # Replace with function body.
