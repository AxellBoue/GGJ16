extends "res://scripts/interactions/zone_plantation.gd"


onready var monstre_losange = get_node("/root/scene/monstres/monstre losange plante")
export var num_target = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func area_action(var action):
	if action == "fleur" && libre:
		libre = false
		var p = plante.instance()
		if p.has_method("pousse_finished"):
			p.pousse = true
		add_child(p)
		p.z_as_relative = false
		p.z_index = p.global_position.y/2
		monstre_losange.new_target(num_target)
