extends Area2D

@export var numAutreCercle : String
var autreCercle 
@onready var perso = get_node("/root/scene/perso")
@onready var timer = get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	autreCercle = get_node("../cercle champi"+numAutreCercle)
	timer.connect("timeout", Callable(self, "teleporte"))
	timer.wait_time = 1.2


func _on_cercle_champi_body_entered(body):
	if body.name == "perso":
		body.entre_zone_interactive(self)
	
func _on_cercle_champi_body_exited(body):
	if body.name == "perso":
		body.sort_zone_interactive(self)

func area_action(action):
	if action == "saut":
		perso.global_position = autreCercle.global_position
		#teleporte_later()

func teleporte_later():
	timer.start()

func teleporte():
	perso.global_position = autreCercle.global_position
	#perso.entre_zone_interactive(autreCercle)
