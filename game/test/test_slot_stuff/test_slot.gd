extends Node2D





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for connector in $ConnectorHolder.get_children():
		connector.connect("got_clicked",allow_drag)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func allow_drag(connector):
	connector.start_line_drag()
	await get_tree().create_timer(4).timeout
	connector.end_line_drag()
	pass
