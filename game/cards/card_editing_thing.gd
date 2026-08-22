@tool
extends HBoxContainer

@export var card_data : CardData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card_data.name = $NameField.text
	card_data.description = $DescField.text
	if $CheckButton.button_pressed:
		card_data.type = CardData.CardType.ACTION
	else:
		card_data.type = CardData.CardType.COMPONENT
	card_data.energy_cost = int($CostField.text)
	card_data.illustration = $Texture.texture
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	pass
