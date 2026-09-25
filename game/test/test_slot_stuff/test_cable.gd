extends Area2D

signal got_clicked(connector : Node2D)

# needs to detect mouse input - check
# needs to animate line drags - check
# needs to notify other slots that a line drag has started so stuff works - check
# needs to create a persistent line on sucesfull drag

# neesd to figure out the preview / snap interaction between 2 Cables

# solution to edge cases: add a ray cast when darg starts, make the connections that failed gray rather than green


var drag_follow_mouse = false



var can_drop_connection = false

@export var has_connection = false

@export var can_accept_connection = true

var current_preivew_target : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ConnectionCarrier.set_meta("owner",self)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if drag_follow_mouse:
		$DragLine.set_point_position(1,get_local_mouse_position())
		$ConnectionCarrier.position = get_local_mouse_position()
		var shape = $DragIntersectionDetector/IntersectionBox.shape as SegmentShape2D
		shape.b = get_local_mouse_position()
	pass

func _input(event: InputEvent) -> void:
	if event.is_class("InputEventMouseButton") and !event.is_pressed() and drag_follow_mouse:
		end_line_drag()

func show_connection_availability(caller : Node2D):
	$RayCast2D.target_position = caller.global_position - global_position
	$RayCast2D.force_raycast_update()

	if !can_accept_connection:
		$ConnectorBase.modulate = Color("Red")
		return

	
	if $RayCast2D.get_collider() != null:
		$ConnectorBase.modulate = Color("Gray")
		$ConnectionAcceptor/CollisionShape2D.disabled = true
		return

	$ConnectorBase.modulate = Color("Green")

	pass
	
func hide_connection_availability():
	$ConnectorBase.modulate = Color("White")
	$ConnectionAcceptor/CollisionShape2D.disabled = false

func start_preview():
	$DragLine.modulate = Color("Green")
	$DragLine.set_point_position(1,current_preivew_target.global_position - global_position)
	current_preivew_target.get_node("DragLine").visible = false
	# starts when a foreign Carrier enters a local Acceptor
	pass

func end_preview():
	$DragLine.modulate = Color("White")
	$DragLine.set_point_position(1,Vector2.ZERO)
	current_preivew_target.get_node("DragLine").visible = true
	# when Acceptor that started the preview leaves this is activated
	pass



func accept_connection(source : Node2D):
	can_accept_connection = false
	has_connection = true
	$DragLine.set_point_position(1,source.global_position)

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
		connector.show_connection_availability(self)
	pass

func end_line_drag():
	drag_follow_mouse = false
	
	var shape = $DragIntersectionDetector/IntersectionBox.shape as SegmentShape2D
	shape.b = Vector2.ZERO

	$DragLine.set_point_position(1,Vector2.ZERO)
	$ConnectionCarrier.position = Vector2.ZERO
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


func _on_connection_acceptor_area_entered(area: Area2D) -> void:
	if area.get_meta("owner") == self:
		return
	current_preivew_target = area.get_meta("owner") as Node2D
	start_preview()

	pass # Replace with function body.


func _on_connection_acceptor_area_exited(area: Area2D) -> void:
	if area.get_meta("owner") == self:
		return
	assert(current_preivew_target == area.get_meta("owner"))
	end_preview()

	pass # Replace with function body.


func _on_drag_intersection_detector_body_entered(body: Node2D) -> void:
	$ConnectionCarrier/CollisionShape2D.set_deferred("disabled", true)
	$DragLine.modulate = Color("Red")
	pass # Replace with function body.


func _on_drag_intersection_detector_body_exited(body: Node2D) -> void:
	if $DragIntersectionDetector.get_overlapping_bodies().size() != 0:
		return
	$ConnectionCarrier/CollisionShape2D.set_deferred("disabled", false)
	$DragLine.modulate = Color("White")
	pass # Replace with function body.
