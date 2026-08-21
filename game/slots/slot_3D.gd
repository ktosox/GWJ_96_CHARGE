class_name Slot
extends Node3D

@export var accepted_component : GameManager.ComponentType

@export var component_type_to_color_map : Dictionary

@export var indicator : MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var texture = indicator.get_surface_override_material(0) as StandardMaterial3D
	texture.albedo_color = component_type_to_color_map[accepted_component]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
