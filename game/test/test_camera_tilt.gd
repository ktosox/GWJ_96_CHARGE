extends Control



func _process(delta: float) -> void:
	$Slot/SubViewportContainer.global_position = get_global_mouse_position() - ($Slot/SubViewportContainer.size/2)
	var screen_center = get_viewport_rect().size / 2
	var camera_offset = (get_global_mouse_position() - screen_center)/get_viewport_rect().size
	camera_offset.y = 0.8
	#camera_offset.x *= -1
	print(camera_offset)
	#for sub_viewport in $Slot.get_children():
		#var local_center = sub_viewport.global_position + (size/2)
		#var camera_offset = (screen_center - local_center)/get_viewport_rect().size
		#sub_viewport.get_child(0).get_child(0).camera_tilt_vector = camera_offset
		#pass
	$Slot/SubViewportContainer/SubViewport/DefaultCameraSetup.camera_tilt_vector = camera_offset
	pass
