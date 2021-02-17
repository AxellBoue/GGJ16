extends Sprite


export var plante : PackedScene
var libre = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("body_entered",self,"on_body_entered")
	$Area2D.connect("body_exited",self,"on_body_exited")


func area_action(var action):
	if action == "fleur" && libre:
		libre = false
		var p = plante.instance()
		if p.has_method("pousse_finished"):
			p.pousse = true
		add_child(p)
		p.z_as_relative = false
		p.z_index = p.global_position.y/2


func on_body_entered(body):
	if body.name == "perso":
		body.entre_zone_interactive(self)
		
		
func on_body_exited(body):
	if body.name == "perso":
		body.sort_zone_interactive(self)
