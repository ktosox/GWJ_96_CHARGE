extends Control

@export var card_consumer_scene : PackedScene

@export var card_scene : PackedScene

@export var component_consumers_go_here : Control

var power_queue = [] # all of the slots and cables that need to get power

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TurnManager.connect("phase_changed",react_to_phase_change)
	pass # Replace with function body.

func draw_card_player():
	var card_anchor = $CardHolder.create_card_anchor() as Control
	var new_card = card_scene.instantiate() as Control
	var card_data = TurnManager.player_deck.draw_card()
	
	assert(card_data != null) # if its a null then some kind of Fatigue system would be needed
	
	new_card.card_data = card_data
	
	card_anchor.add_child(new_card)
	new_card.connect("tree_exited",card_anchor.queue_free)
	pass



func update_power_queue():
	# collect all of the cables and slots that are on,
	# probably by asking each segemny for a list and then putting them in order
	pass

func add_card_consumers():
	# needs a list of all slots
	# needs to create a card consumer for evry slot
	var all_slots : Array
	for slot in all_slots:
		var new_consumer = card_consumer_scene.instantiate()
		# code that links consumer to slot and places him on the correct spot goes here
		component_consumers_go_here.add_child(new_consumer)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func react_to_phase_change():
	match TurnManager.current_phase:
		TurnManager.Phases.BEGIN:
			pass
		TurnManager.Phases.RESET_POWER:
			pass
		TurnManager.Phases.START_OF_TURN:
			var all_SOT_listeners = get_tree().get_nodes_in_group("SOT_listener") as Array
			while all_SOT_listeners.size() > 0:
				var next_listener = all_SOT_listeners.pop_front()
				next_listener.trigger_SOT()
				await  get_tree().create_timer(0.7).timeout
				
			TurnManager.progress_turn(TurnManager.Phases.START_OF_TURN)
			pass
		TurnManager.Phases.DRAW:
			pass
		TurnManager.Phases.PLAY:
			$NextTurn.disabled = false
			pass
		TurnManager.Phases.END_OF_TURN:
			$NextTurn.disabled = true
			var all_EOT_listeners = get_tree().get_nodes_in_group("EOT_listener") as Array
			while all_EOT_listeners.size() > 0:
				var next_listener = all_EOT_listeners.pop_front()
				next_listener.trigger_EOT()
				await  get_tree().create_timer(0.7).timeout
				
			TurnManager.progress_turn(TurnManager.Phases.END_OF_TURN)
			
			pass
		TurnManager.Phases.FIRE:
			for node in power_queue:
				node.trigger_power()
				await node.powering_complete
			
			TurnManager.progress_turn(TurnManager.Phases.FIRE)
			
			pass
		TurnManager.Phases.FINISH:
			for node in power_queue:
				node.clear_power()
			await  get_tree().create_timer(0.7).timeout
			TurnManager.progress_turn(TurnManager.Phases.FINISH)
			pass
		_:
			assert(false)

# needs to dynamicly add card consumers over slots and link them


func _on_next_turn_pressed() -> void:
	assert(TurnManager.current_phase == TurnManager.Phases.PLAY and TurnManager.is_player_turn)
	TurnManager.progress_turn(TurnManager.Phases.PLAY)
	pass # Replace with function body.


func _on_test_add_anchor_pressed() -> void:
	$CardHolder.create_card_anchor()
	pass # Replace with function body.


func _on_test_draw_card_pressed() -> void:
	draw_card_player()
	pass # Replace with function body.
