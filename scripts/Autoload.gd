extends Node2D

#pour le changement de zone
var position_pop : Vector2
var direction_pop
var etat_lapins : Array = [0,0,0,0,0]
var position_lapins : Array = [0,0,0,0,0]
var scene_lapins : Array = [0,0,0,0,0]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func change_scene_to_file(_scene,_direction,_position):
	var lapins = get_tree().get_nodes_in_group("lapin")
	for l in lapins:
		l.save_states()
		
	get_tree().change_scene_to_file(_scene)
	
	position_pop = _position
	direction_pop = _direction

func test(bla):
	print(bla)
