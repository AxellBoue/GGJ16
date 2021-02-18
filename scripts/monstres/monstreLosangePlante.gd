extends KinematicBody2D

var vitesse = 80
var va_planter = false
var target : Array
onready var zones_plantation : Array = [
	get_node("/root/scene/decor/interactions/zone monstre losange/plante monstre losange"),
	get_node("/root/scene/decor/interactions/zone monstre losange/plante monstre losange2"),
	get_node("/root/scene/decor/interactions/zone monstre losange/plante monstre losange3"),
	get_node("/root/scene/decor/interactions/zone monstre losange/plante monstre losange4"),
	get_node("/root/scene/decor/interactions/zone monstre losange/plante monstre losange5")
]
var arbre = preload("res://obj/decor/arbre02.tscn")
var arbres_plantes = 0
onready var centre = get_node("/root/scene/decor/interactions/zone monstre losange/centre")

# Called when the node enters the scene tree for the first time.
func _ready():
	z_as_relative = false
	$Timer.connect("timeout",self,"next_target")
	$Timer.one_shot = true


func _physics_process(delta):
	if va_planter && target.size() > 0:
		var mouvement = target[0].global_position - global_position
		mouvement = mouvement.normalized()
		move_and_slide(mouvement * vitesse)
		z_index = global_position.y/2
		if global_position.distance_to(target[0].global_position) < 5:
			va_planter = false
			if arbres_plantes < 5:
				plante()
			arbres_plantes += 1
			if arbres_plantes == 4:
				target.append(centre)
			target.remove(0)
			if target.size() > 0 :
				$Timer.start()



func new_target(num_target):
	target.append(zones_plantation[num_target])
	va_planter = true
	
	
func next_target ():
	va_planter = true

func plante():
	var p = arbre.instance()
	p.pousse = true
	target[0].add_child(p)
	p.z_as_relative = false
	p.z_index = p.global_position.y/2
