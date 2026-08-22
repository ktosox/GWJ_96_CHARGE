class_name ShipData # holds a complete packege of data to fully describe a space ship
extends Resource



@export var name : String

@export var starting_power : int = 1
@export var max_power : int = 5


# needs to store all ship segments

@export var segment_front : PackedScene
@export var segment_middle : PackedScene
@export var segment_engine : PackedScene
