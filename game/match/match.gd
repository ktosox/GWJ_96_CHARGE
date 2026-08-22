extends Control

@export var card_consumer_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TurnManager.connect("phase_changed",react_to_phase_change)
	pass # Replace with function body.


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
			pass
		TurnManager.Phases.DRAW:
			pass
		TurnManager.Phases.PLAY:
			$NextTurn.disabled = false
			pass
		TurnManager.Phases.END_OF_TURN:
			$NextTurn.disabled = true
			pass
		TurnManager.Phases.FIRE:
			pass
		TurnManager.Phases.FINISH:
			pass
		_:
			assert(false)

# needs to dynamicly add card consumers over slots and link them

# needs to detect when players play phase arrives and enable / dissable the NextTurn button


func _on_next_turn_pressed() -> void:
	assert(TurnManager.current_phase == TurnManager.Phases.PLAY and TurnManager.is_player_turn)
	TurnManager.progress_turn(TurnManager.Phases.PLAY)
	pass # Replace with function body.
