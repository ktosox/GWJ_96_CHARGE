extends Control



func _process(delta: float) -> void:
	var screen_center = get_viewport_rect().size / 2
	var camera_offset = (get_global_mouse_position() - screen_center)/get_viewport_rect().size
	print(camera_offset)
	$Slot/SubViewportContainer/SubViewport/DefaultCameraSetup.camera_tilt_vector = camera_offset
	pass
