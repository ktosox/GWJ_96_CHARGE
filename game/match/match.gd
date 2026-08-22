extends Control

@export var card_consumer_scene : PackedScene

var power_queue = [] # all of the slots and cables that need to get power

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TurnManager.connect("phase_changed",react_to_phase_change)
	pass # Replace with function body.


func update_power_queue():
	# collect all of the cables and slots that are on,
	# probably by asking each segemny for a list and then putting them in order
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

# needs to detect when players play phase arrives and enable / dissable the NextTurn button


func _on_next_turn_pressed() -> void:
	assert(TurnManager.current_phase == TurnManager.Phases.PLAY and TurnManager.is_player_turn)
	TurnManager.progress_turn(TurnManager.Phases.PLAY)
	pass # Replace with function body.
