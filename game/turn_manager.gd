extends Node

signal phase_changed

signal turn_changed

signal health_changed(is_player : bool, new_health : int)

signal power_changed(is_player : bool, new_power : int)

@export var player_deck : DeckData

@export var enemy_deck : DeckData

#Turn mananger
#- keeps track of whos turn is it now
#- emits signals whenever a specifc phase is reached
#- needs to know when to move on to the next phase
enum Phases {BEGIN,RESET_POWER,START_OF_TURN,DRAW,PLAY,END_OF_TURN,FIRE,FINISH}



var is_player_turn = false

var is_there_an_active_match = false

var current_phase : Phases


func progress_turn(old_phase : Phases) -> void: # takes old_phase as input to make sure the caller is not trying to progress phase out of order
	assert(is_there_an_active_match == true)
	assert(old_phase == current_phase)
	if current_phase == Phases.FINISH:
		is_player_turn = !is_player_turn
		turn_changed.emit()
		current_phase = Phases.BEGIN
	else:
		current_phase += 1
	
	if is_player_turn:
		action_turn(player_stats)
	else:
		action_turn(enemy_stats)
	
	phase_changed.emit()


#------------------------------------------------------------------------------------------------------------------------------

#Match maanger - gopt moved over here for convience
# needs to handles global stuff in relation to current match
# needs to reset and load stuff at start of match
# needs to keep track of power?

@export var player_stats : ShipStats

@export var enemy_stats : ShipStats


func start_match() -> void :
	assert(is_there_an_active_match == false)
	is_there_an_active_match = true
	is_player_turn = false
	current_phase = Phases.FINISH
	progress_turn(current_phase)
	pass
	

func action_turn(current_stats : ShipStats):
	match current_phase:
		Phases.BEGIN:
			current_stats.power_reset = min(current_stats.power_reset+1,current_stats.power_max)
			pass
		Phases.RESET_POWER:
			current_stats.power_current = current_stats.power_reset

			pass
		Phases.START_OF_TURN:
			pass
		Phases.DRAW:
			pass
		Phases.PLAY:
			pass
		Phases.END_OF_TURN:
			pass
		Phases.FIRE:
			pass
		Phases.FINISH:
			pass
		_:
			assert(false)
	pass


func end_match():
	assert(is_there_an_active_match == true)
	is_there_an_active_match = false


func check_power(amount : int) -> bool :
	var active_stats : ShipStats
	if is_player_turn:
		active_stats = player_stats
	else:
		active_stats = enemy_stats
	if active_stats.power_current - amount < 0:
		return false
	return true

func use_power(amount : int) -> void :
	var active_stats : ShipStats
	if is_player_turn:
		active_stats = player_stats
	else:
		active_stats = enemy_stats
	active_stats.power_current -= amount
	assert(active_stats.power_current > -1)
	power_changed.emit(is_player_turn, active_stats.power_current)

func deal_damage(amount : int, is_player = true):
	var active_stats : ShipStats
	if is_player:
		active_stats = player_stats
	else:
		active_stats = enemy_stats
	active_stats.health_current -= amount
	health_changed.emit(is_player, active_stats.health_current)
	pass
