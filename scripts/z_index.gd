@tool
extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = global_position.y/2
	z_as_relative = false


func _draw():
	if Engine.is_editor_hint():
		z_index = global_position.y/2
