extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
onready var boussole = get_node("/root/scene/CanvasLayer/Control/boussole")
onready var aiguille = $aiguille
var direction
var rand = RandomNumberGenerator.new()
var tourne = false
var ralenti = false
var vitesse_max = 400
var vitesse_rot = vitesse_max
var nombre_tour = 1
var nombre_tour_faits = 0
var tour_compte = false
var sens_possible = [1,-1]
var sens = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("body_entered",self,"on_body_entered")
	$Area2D.connect("body_exited",self,"on_body_exited")
	z_index = global_position.y / 2
	z_as_relative = false
	rand.randomize()
	$Timer.connect("timeout",self,"commence_a_tourner")
	$Timer.wait_time = rand.randi_range(2,6)
	$Timer.one_shot = true
	$Timer.start()
	$AnimationPlayer.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if tourne :
		if ralenti :
			vitesse_rot -= delta * vitesse_max * 7
			if vitesse_rot <= - vitesse_max :
				vitesse_rot = - vitesse_max
			if vitesse_rot >= vitesse_max :
				vitesse_rot = vitesse_max
		aiguille.rotation_degrees += sens * delta * vitesse_rot
		if aiguille.rotation_degrees > 360 :
			aiguille.rotation_degrees = aiguille.rotation_degrees - 360
		if aiguille.rotation_degrees < 0 :
			aiguille.rotation_degrees = 360 + aiguille.rotation_degrees 
		if !tour_compte && aiguille.rotation_degrees >= direction - 2 && aiguille.rotation_degrees <= direction + 2 :
			if nombre_tour_faits >= nombre_tour :
				if ralenti :
					ralenti = false
					tourne = false
					$Timer.wait_time = rand.randi_range(2,6)
					$Timer.start()
				else : 
					ralenti = true
			else :
				nombre_tour_faits += 1
			tour_compte = true
		if tour_compte && aiguille.rotation_degrees < direction - 2 || aiguille.rotation_degrees > direction + 2 :
			tour_compte = false
			
	
func commence_a_tourner():
	vitesse_rot = vitesse_max
	direction = rand.randi_range(0,360)
	nombre_tour_faits = 0
	nombre_tour = rand.randi_range(0,4)
	sens = sens_possible[rand.randi_range(0,1)]
	tourne = true
	

func on_body_entered(body):
	if body.name == "perso":
		body.entre_zone_interactive(self)
	

func on_body_exited(body):
	if body.name == "perso":
		body.sort_zone_interactive(self)


func area_action(var action):
	if action == "saut":
		boussole.active()
