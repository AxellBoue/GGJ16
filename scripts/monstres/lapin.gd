extends CharacterBody2D

enum states {depart,follow,totem}
@export var state = states.depart
@export var num_pr_save = 1
@export var reflet = false

@onready var perso = get_node("/root/scene/perso")

var target
var suit = false
var vitesse = 120
var distanceMin = 80
var mouvement
var en_lair = false
var proche = false

var area_sizes : Array = [50,90,130,170,210] 
@onready var area_follow = get_node("AreaFollow")
var num = 0

var depose = false
var arrive = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var area = get_node("Area2D")
	area.connect("body_entered", Callable(self, "on_area_body_entered"))
	area.connect("body_exited", Callable(self, "on_area_body_exited"))
	area_follow.connect("body_entered", Callable(self, "on_area_follow_body_entered"))
	area_follow.connect("body_exited", Callable(self, "on_area_follow_body_exited"))
	area_follow.get_node("CollisionShape2D").shape = area_follow.get_node("CollisionShape2D").shape.duplicate()
	$AnimationPlayer.connect("animation_finished", Callable(self, "on_fin_anim"))
	# initialise la position et l'etat
	set_reflet(reflet)
	var a = get_node("/root/Autoload")
	if a.etat_lapins[num_pr_save-1] != 0:
		state = a.etat_lapins[num_pr_save-1]
	if state == states.follow :
		position = perso.get_node("zones pop lapins/pop"+ str(num_pr_save)).global_position
		start_follow()
	if state == states.totem :
		if a.scene_lapins[num_pr_save-1] == get_node("/root/scene").num_scene :
			global_position = a.position_lapins[num_pr_save - 1]
		else : 
			global_position = Vector2(-600,200)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if (suit && en_lair && !proche) || (depose && en_lair):  # position.distance_to(perso.position) > distanceMin :
		mouvement = target.global_position - position
		mouvement = mouvement.normalized() * vitesse
		set_velocity(mouvement)
		move_and_slide()
		z_index = position.y/2
		if depose && target.global_position.distance_to(position) < 10 :
			depose = false
			arrive = true

func on_area_body_entered(body):
	if body == perso:
		body.entre_zone_interactive(self)

func on_area_body_exited(body):
	if body == perso:
		body.sort_zone_interactive(self)
		

func area_action(action):
	if action == "fleur":
		start_follow()
		$AnimationPlayer.play("saute")

func start_follow():
	perso.lapins.append(self)
	area_follow.get_node("CollisionShape2D").shape.radius = area_sizes[perso.lapins.size()-1]
	num = perso.lapins.size()-1
	target = perso
	$Area2D/CollisionShape2D.disabled = true
	arrive = false
	perso.sort_zone_interactive(self)
	state = states.follow
	suit = true
	
	
func on_area_follow_body_entered(body):
	if body == perso:
		proche = true
		
func on_area_follow_body_exited(body):
	if body == perso:
		proche = false
		if suit:
			$AnimationPlayer.play("saute")
		
# bouge que quand il est en l'air. animation lance fonction qui arrete quand fin de saut, puis qui relance au debut
func debut_saut():
	en_lair = true

func fin_saut():
	en_lair = false
	
func on_fin_anim(anim):
	if (!proche && !arrive) || depose:
		$AnimationPlayer.play("saute")
	
func set_reflet(b):
	$reflet.visible = b

func stop_follow(new_targets):
	suit = false
	$Area2D/CollisionShape2D.disabled = false
	target = new_targets[num_pr_save]
	depose = true
	state = states.totem
	get_node("/root/Autoload").scene_lapins[num_pr_save-1] = get_node("/root/scene").num_scene
	get_node("/root/Autoload").position_lapins[num_pr_save-1] = new_targets[num_pr_save].global_position
	if !$AnimationPlayer.is_playing() :
		$AnimationPlayer.play("saute")

func save_states():
	get_node("/root/Autoload").etat_lapins[num_pr_save-1] = state
		
		
