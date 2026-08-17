extends Node

signal phase_changed

signal turn_changed

#Turn mananger
#- keeps track of whos turn is it now
#- emits signals whenever a specifc phase is reached
#- needs to know when to move on to the next phase
enum Phases {BEGIN,RESET_POWER,START_OF_TURN,DRAW,PLAY,END_OF_TURN,FIRE,FINISH}



var is_player_turn = false

var is_there_an_active_match = false

var current_phase : Phases

func start_match() -> void :
	assert(is_there_an_active_match == false)
	is_there_an_active_match = true
	is_player_turn = true
	turn_changed.emit()
	current_phase = Phases.BEGIN
	phase_changed.emit()
	pass


func progress_turn(old_phase : Phases) -> void: # takes old_phase as input to make sure the caller is not trying to progress phase out of order
	assert(is_there_an_active_match == true)
	assert(old_phase == current_phase)
	if current_phase == Phases.FINISH:
		is_player_turn = !is_player_turn
		turn_changed.emit()
		current_phase = Phases.BEGIN
	else:
		current_phase += 1
	phase_changed.emit()

func end_match():
	assert(is_there_an_active_match == true)
	is_there_an_active_match = false
