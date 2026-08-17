extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TurnManager.connect("phase_changed",update_phase)
	TurnManager.connect("turn_changed",update_turn)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func update_turn():
	if TurnManager.is_player_turn:
		$WhosTurn.text = "player turn"
	else:
		$WhosTurn.text = "enemy turn"

func update_phase():
	$CurrentPhase.text = TurnManager.Phases.keys()[TurnManager.current_phase]


func _on_start_match_pressed() -> void:
	TurnManager.start_match()
	pass # Replace with function body.


func _on_next_phase_pressed() -> void:
	TurnManager.progress_turn(TurnManager.current_phase)
	pass # Replace with function body.
