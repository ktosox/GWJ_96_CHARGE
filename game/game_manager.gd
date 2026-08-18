extends Node

# needs to store data that persists between matches

enum ComponentType {ATTACK, DEFENCE, POWER, HEALTH}

@export var player_ship_data : ShipData

@export var enemy_ship_data : ShipData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.




func update_player_ship_data(data : ShipData) -> void:
	player_ship_data = data
	# code for saving to user storage goes here
