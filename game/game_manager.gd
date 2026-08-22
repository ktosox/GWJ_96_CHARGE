extends Node

# needs to store data that persists between matches

enum ComponentType {ATTACK, DEFENCE, POWER, HEALTH}

@export var player_ship_data : ShipData

@export var enemy_ship_data : ShipData

@export var all_cards : Array[CardData] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for card_thing in $CardEditor.get_children():
		all_cards.push_back(card_thing.card_data)
	#for card in all_cards:
		#print(card.name," ",card.type," ",card.description)
	$CardEditor.queue_free()
	pass # Replace with function body.




func update_player_ship_data(data : ShipData) -> void:
	player_ship_data = data
	# code for saving to user storage goes here
