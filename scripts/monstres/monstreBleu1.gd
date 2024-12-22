extends CharacterBody2D

@onready var perso = get_node("/root/scene/perso")
var fuis = false
var fuis_vers_init = false
var retour = false
var vitesse = 100
var position_initiale
var position_debut_fuite


# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = global_position.y/2
	z_as_relative = false
	$Area2D.connect("body_entered", Callable(self, "on_body_entered"))
	$Area2D.connect("body_exited", Callable(self, "on_body_exited"))
	position_initiale = global_position
	$anim.play("default")
	$Timer.wait_time = 10
	$Timer.connect("timeout", Callable(self, "retour"))
	$Timer.one_shot = true

func _physics_process(_delta):
	if fuis :
		var mouvement = global_position - perso.position
		if fuis_vers_init :
			mouvement = position_initiale - global_position
		mouvement = mouvement.normalized()
		set_velocity(mouvement * vitesse)
		move_and_slide()
		z_index = global_position.y/2
		if position_debut_fuite.distance_to(global_position) > 200 :
			fuis = false
			fuis_vers_init = false
			$Timer.start()
	elif retour :
		var mouvement = position_initiale - global_position
		mouvement = mouvement.normalized()
		set_velocity(mouvement * vitesse)
		move_and_slide()
		z_index = global_position.y/2
		if position_initiale.distance_to(global_position) < 10 :
			retour = false


func on_body_entered(body):
	if body.name == "perso":
		body.entre_zone_interactive(self)
	

func on_body_exited(body):
	if body.name == "perso":
		body.sort_zone_interactive(self)


func area_action(action):
	if action == "saut" || action == "pied":
		retour = false
		$Timer.stop()
		position_debut_fuite = global_position
		if position_initiale.distance_to(global_position) > 400 :
			fuis_vers_init = true
		fuis = true
	if action == "fleur" :
		print("feedback positif")
		
		
func start_retour():
	retour = true
	fuis = false
