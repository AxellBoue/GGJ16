extends TextureRect

var aiguille 
onready var aiguille_1 = $"aiguille 1"
onready var aiguille_double = $"aiguille double"
onready var aiguille_etoile = $"aiguille etoile"
onready var aiguille_rond = $"aiguille rond"
var aiguille_array : Array
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

onready var player = get_node("/root/scene/perso")
var cibles : Array
var cible
var look_at_cible = false
export var temps_change_cible_min = 25
export var temps_change_cible_max = 30


# Called when the node enters the scene tree for the first time.
func _ready():
	aiguille = aiguille_1
	aiguille_array = [aiguille_1,aiguille_1,aiguille_1,aiguille_1,aiguille_double,aiguille_etoile,aiguille_rond]
	rand.randomize()
	$Timer.connect("timeout",self,"commence_a_tourner")
	$Timer.wait_time = rand.randi_range(10,15)
	$Timer.one_shot = true
	cibles = get_tree().get_nodes_in_group("cibleBoussole")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if look_at_cible :
		direction = rad2deg( atan2(cible.global_position.x - player.global_position.x,player.global_position.y - cible.global_position.y) )
		aiguille.rect_rotation = direction
		#print(player.global_position.distance_to(cible.global_position))
		if player.global_position.distance_to(cible.global_position) < 10:
			$Timer.stop()
			commence_a_tourner()
	
	if tourne :
		if ralenti :
			vitesse_rot -= delta * vitesse_max * 7
			if vitesse_rot <= - vitesse_max :
				vitesse_rot = - vitesse_max
			if vitesse_rot >= vitesse_max :
				vitesse_rot = vitesse_max
		aiguille.rect_rotation += sens * delta * vitesse_rot
		if aiguille.rect_rotation > 360 :
			aiguille.rect_rotation = aiguille.rect_rotation - 360
		if aiguille.rect_rotation < 0 :
			aiguille.rect_rotation = 360 + aiguille.rect_rotation 
		if !tour_compte && aiguille.rect_rotation >= direction - 2 && aiguille.rect_rotation <= direction + 2 :
			if nombre_tour_faits >= nombre_tour :
				if ralenti :
					ralenti = false
					tourne = false
					$Timer.wait_time = rand.randi_range(temps_change_cible_min,temps_change_cible_max)
					$Timer.start()
					look_at_cible = true
					change_aiguille()
				else : 
					ralenti = true
			else :
				nombre_tour_faits += 1
			tour_compte = true
		if tour_compte && aiguille.rect_rotation < direction - 2 || aiguille.rect_rotation > direction + 2 :
			tour_compte = false
			
func active():
	visible = true
	commence_a_tourner()
	
func commence_a_tourner() :
	print ("commence a tourner")
	look_at_cible = false
	vitesse_rot = vitesse_max
	cible = cibles[rand.randi_range(0,cibles.size()-1)]
	direction = rad2deg(atan2(cible.global_position.x - player.global_position.x,player.global_position.y - cible.global_position.y) )
	if direction > 360 : 
		direction -= 360
	if direction < 0 :
		direction += 360
	nombre_tour_faits = 0
	nombre_tour = rand.randi_range(2,5)
	sens = sens_possible[rand.randi_range(0,1)]
	tourne = true


func change_aiguille():
	aiguille_1.visible = false
	aiguille_double.visible = false
	aiguille_etoile.visible = false
	aiguille_rond.visible = false
	var r = rand.randi_range(0,aiguille_array.size()-1)
	aiguille_array[r].visible = true
	aiguille = aiguille_array[r]
	if r >= 5 : #numéro de l'aiguille étoile ou rond
		look_at_cible = false
		aiguille.rect_rotation = 0
		aiguille = aiguille_1
