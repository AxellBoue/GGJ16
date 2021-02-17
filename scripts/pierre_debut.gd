extends Sprite


export var num_pierre = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = global_position.y/2
	$Area2D.connect("body_entered",self,"on_body_entered")
	$Area2D.connect("body_exited",self,"on_body_exited")
	
	
func area_action(var action):
	if num_pierre == 1 && action == "saut":
		print("blop")
	if num_pierre == 2 && action == "pied":
		print("blip")
	if num_pierre == 3 && action == "fleur":
		print("bloup")

func on_body_entered(body):
	if body.name == "perso":
		body.entre_zone_interactive(self)
		
		
func on_body_exited(body):
	if body.name == "perso":
		body.sort_zone_interactive(self)
