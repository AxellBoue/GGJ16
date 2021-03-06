extends Area2D

onready var pop_pluie = get_node("/root/scene/popPluie")
export var _min : float = 1
export var _max : float = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",self,"on_area_body_entered")
	connect("body_exited",self,"on_area_body_exited")

func on_area_body_entered(body):
	if body.name == "perso":
		pop_pluie.set_delta_gouttes(_min,_max)

func on_area_body_exited(body):
	if body.name == "perso":
		pop_pluie.reset_delta_gouttes()
