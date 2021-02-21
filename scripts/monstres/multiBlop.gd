extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = global_position.y/2
	z_as_relative = false
	$Area2D.connect("body_entered",self,"on_body_entered")
	$Area2D.connect("body_exited",self,"on_body_exited")


func on_body_entered(body):
	if body.name == "perso":
		body.entre_zone_interactive(self)
	

func on_body_exited(body):
	if body.name == "perso":
		body.sort_zone_interactive(self)


func area_action(var action):
	if action == "saut" :
		pass
