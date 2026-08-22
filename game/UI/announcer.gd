extends Control

# is linked to Turn Manager and the Event Pipeline

# shows stuff on screen like turn changed notifications or errors

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TurnManager.connect("turn_changed",announce_turn_change)
	GameManager.connect("error_thrown",announce_error)
	#TurnManager.start_match()
	pass # Replace with function body.


func announce_turn_change():
	if TurnManager.is_player_turn:
		$TurnAnimator.play("player_turn")
	else:
		$TurnAnimator.play("enemy_turn")
	pass

func announce_error(error_text : String):
	$ErrorNotification.text = error_text
	$ErrorAnimator.play("show")
	pass
