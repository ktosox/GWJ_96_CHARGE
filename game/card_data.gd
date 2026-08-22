class_name CardData # holds a complete packege of data to fully describe a card
extends Resource

enum CardType {ACTION, COMPONENT}

@export var type : CardType

@export var name : String = "debug name"

@export var energy_cost : int = 1

@export var illustration : Texture2D

@export var description : String

var linked_physical_card : Node



# visual data that is used to create the car goes here
# stuff like the sprite, color etc.
