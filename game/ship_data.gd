class_name ShipData # holds a complete packege of data to fully describe a space ship
extends Resource



@export var name : String



# needs to store all ship segments

@export var segment_front : PackedScene
@export var segment_middle : PackedScene
@export var segment_engine : PackedScene
