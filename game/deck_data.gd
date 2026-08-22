class_name DeckData # stors an array of cards
extends Resource

@export var cards : Array[CardData]

func shuffle():
	cards.shuffle()
	pass


func draw_card() -> CardData :
	if cards.size() == 0:
		return null
	return cards.pop_front()
