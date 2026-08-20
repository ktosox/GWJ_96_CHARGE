extends RigidBody2D

var selected = false

var grabbed = false

var mouse_offset : Vector2

@export var resting_anchor : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.




func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LMB") and selected:
		
		grab()

	if event.is_action_released("LMB") and selected:
		un_grab()
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if grabbed:
		constant_force = (mouse_offset + get_local_mouse_position()) * 50

		mouse_offset = get_local_mouse_position()
	
	pass

func grab():
	grabbed = true
	mouse_offset = get_local_mouse_position()
	pass


func un_grab():
	grabbed = false
	pass

func _on_mouse_entered() -> void:
	selected = true
	$CardAnimator.play("select")
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	selected = false
	$CardAnimator.play("de-select")
	pass # Replace with function body.
