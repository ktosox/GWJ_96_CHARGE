extends Area2D

signal got_clicked(connector : Node2D)

# needs to detect mouse input
# needs to animate line drags
# needs to notify other slots that a line drag has started so stuff works

var drag_follow_mouse = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if drag_follow_mouse:
		$DragLine.set_point_position(1,get_local_mouse_position())
	pass




func start_line_drag():
	drag_follow_mouse = true
	pass

func end_line_drag(global_pos = Vector2.INF):
	drag_follow_mouse = false
	if global_pos != Vector2.INF:
		$DragLine.set_point_position(1,global_pos)
	else:
		$DragLine.set_point_position(1,Vector2.ZERO)
	pass





func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_class("InputEventMouseButton") and event.is_pressed():
		got_clicked.emit(self)
	pass # Replace with function body.
