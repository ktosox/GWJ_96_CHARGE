class_name CardData # holds a complete packege of data to fully describe a card
extends Resource

@export var type : GameManager.CardType

@export var name : String = "debug name"

@export var energy_cost : int = 1

var linked_physical_card : Node



# visual data that is used to create the car goes here
# stuff like the sprite, color etc.
