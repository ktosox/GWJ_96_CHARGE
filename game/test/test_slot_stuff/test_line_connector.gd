extends Area2D

signal got_clicked(connector : Node2D)

# needs to detect mouse input
# needs to animate line drags
# needs to notify other slots that a line drag has started so stuff works

var drag_follow_mouse = false

@export var has_connection = false

@export var can_accept_connection = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if drag_follow_mouse:
		$DragLine.set_point_position(1,get_local_mouse_position())
	pass

func _input(event: InputEvent) -> void:
	if event.is_class("InputEventMouseButton") and !event.is_pressed():
		end_line_drag()

func show_connection_availability():
	if can_accept_connection:
		$ConnectorBase.modulate = Color("Green")
	else:
		$ConnectorBase.modulate = Color("Red")
	pass
	
func hide_connection_availability():
	$ConnectorBase.modulate = Color("White")



func accept_connection():
	can_accept_connection = false
	has_connection = true
	pass

func cancel_connection():
	can_accept_connection = true
	has_connection = false
	pass

func start_line_drag():
	drag_follow_mouse = true
	var other_connectors = get_tree().get_nodes_in_group("connector")
	other_connectors.erase(self)
	for connector in other_connectors:
		connector.show_connection_availability()
	pass

func end_line_drag(global_pos = Vector2.INF):
	drag_follow_mouse = false
	if global_pos != Vector2.INF:
		$DragLine.set_point_position(1,global_pos)
	else:
		$DragLine.set_point_position(1,Vector2.ZERO)
		
	var other_connectors = get_tree().get_nodes_in_group("connector")
	other_connectors.erase(self)
	for connector in other_connectors:
		connector.hide_connection_availability()
	pass





func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_class("InputEventMouseButton") and event.is_pressed():
		if !has_connection:
			start_line_drag()
		#got_clicked.emit(self)
	pass # Replace with function body.
