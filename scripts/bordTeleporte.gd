extends Area2D

export (String) var directionPop
var lieuPop
onready var perso = get_node("/root/scene/perso")

# Called when the node enters the scene tree for the first time.
func _ready():
	lieuPop = get_node("../zoneTeleporte"+directionPop+"/zonePop")
	connect("body_entered",self,"_on_body_entered")

func _on_body_entered(body):
	if body.name == "perso":
		if directionPop == "Nord" || directionPop == "Sud":
			body.global_position = Vector2(body.global_position.x,lieuPop.global_position.y)
		else :
			body.global_position = Vector2(lieuPop.global_position.x,body.global_position.y)
