extends Node3D

@export var camera_tilt_vector : Vector2

func _ready() -> void:

	pass
func _physics_process(delta: float) -> void:
	update_tilt()
	pass

func update_tilt():
	var rot_ratio = 1.1
	var pos_ratio = 2.0
	$Camera3D.h_offset = +camera_tilt_vector.x * pos_ratio
	$Camera3D.v_offset = -camera_tilt_vector.y * pos_ratio
	$Camera3D.rotation = Vector3(camera_tilt_vector.y*rot_ratio,camera_tilt_vector.x*rot_ratio,0)
	pass
	
