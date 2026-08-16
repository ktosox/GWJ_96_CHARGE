extends Node

signal phase_changed(new_phase : Phases)

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
	current_phase = Phases.BEGIN
	emit_signal("phase_changed",current_phase)
	pass


func progress_turn() -> void:
	assert(is_there_an_active_match == true)
	if current_phase == Phases.FINISH:
		is_player_turn = !is_player_turn
		current_phase = Phases.BEGIN
	emit_signal("phase_changed",current_phase)

func end_match():
	assert(is_there_an_active_match == true)
	is_there_an_active_match = false
