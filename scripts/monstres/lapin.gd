extends KinematicBody2D

onready var perso = get_node("/root/scene/perso")

var suit = false
export var vitesse = 120
export var distanceMin = 80
var mouvement
var en_lair = false
var proche = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var area = get_node("Area2D")
	area.connect("body_entered",self,"on_area_body_entered")
	area.connect("body_exited",self,"on_area_body_exited")
	$AnimationPlayer.connect("animation_finished",self,"on_fin_anim")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if suit && en_lair && !proche:  # position.distance_to(perso.position) > distanceMin :
		mouvement = perso.position - position
		mouvement = mouvement.normalized() * vitesse
		move_and_slide(mouvement)

func on_area_body_entered(body):
	if body == perso:
		body.entre_zone_interactive(self)
		proche = true

func on_area_body_exited(body):
	if body == perso:
		body.sort_zone_interactive(self)
		proche = false
		$AnimationPlayer.play("saute")

func area_action(action):
	if action == "fleur":
		suit = true
		$AnimationPlayer.play("saute")
		
# bouge que quand il est en l'air. animation lance fonction qui arrete quand fin de saut, puis qui relance au debut
func debut_saut():
	en_lair = true

func fin_saut():
	en_lair = false
	
func on_fin_anim(anim):
	if !proche :
		$AnimationPlayer.play("saute")
	
# saute que si a la fin de l'anim le perso est a distance > distance min
# autre anim d'idle et à chaque boucle check que le perso est toujours proche, si non repart ?
