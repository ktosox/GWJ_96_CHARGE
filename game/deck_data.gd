class_name DeckData # stors an array of cards
extends Resource

@export var cards : Array[CardData]

func shuffle():
	cards.shuffle()
	pass
