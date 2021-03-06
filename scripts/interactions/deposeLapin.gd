extends Area2D


onready var perso = get_node("/root/scene/perso")
onready var targets : Array  = [$Node2D,$Node2D2,$Node2D3,$Node2D4,$Node2D5]


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",self,"on_area_body_entered")
	connect("body_exited",self,"on_area_body_exited")


func on_area_body_entered(body):
	if body == perso:
		body.entre_zone_interactive(self)

func on_area_body_exited(body):
	if body == perso:
		body.sort_zone_interactive(self)
		

func area_action(action):
	if action == "saut":
		print ("saut")
		for l in perso.lapins :
			l.stop_follow(targets)
		perso.lapins.clear()
