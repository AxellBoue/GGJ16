extends CharacterBody2D

@export var vitesse = 150 

var direction = "face"
var animBloque = false
@onready var anim = $"sprite perso"
@onready var reflet = $reflet

var isInArea = false;
var area : Array; 
var next_action

@export var particules : PackedScene

var lapins : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.connect("timeout", Callable(self, "interaction_later"))
	$Timer.one_shot = true
	get_node("/root/scene/bords").set_position_perso(self)

func _input(event):
	if event.is_action_pressed("saut") && !animBloque:
		animBloque = true
		anim.play("saut")
		if reflet :
			reflet.play("saut")
		interaction ("saut")
	if event.is_action_pressed("pied") && !animBloque:
		animBloque = true
		anim.play("coupPied")
		if reflet :
			reflet.play("coupPied")
		interaction("pied")
	if event.is_action_pressed("fleur") && !animBloque:
		#animBloque = true
		var f = particules.instantiate()
		$popParicules.add_child(f)
		interaction("fleur")

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("haut"):
		direction = "dos"
		velocity.y -= 1
	if Input.is_action_pressed("bas"):
		direction = "face"
		velocity.y += 1
	if Input.is_action_pressed("droite"):
		velocity.x += 1
		direction = "droite"
		anim.set_flip_h(true)
		if reflet :
			reflet.set_flip_h(true)
	if Input.is_action_pressed("gauche"):
		velocity.x -= 1
		direction = "droite"
		anim.set_flip_h(false)
		if reflet :	
			reflet.set_flip_h(false)
	velocity = velocity.normalized() * vitesse
	
func _physics_process(_delta):
	if !animBloque :
		get_input()
		set_velocity(velocity)
		move_and_slide()
		velocity = velocity # le vélocity = sert à stoquer le mouvement qui peut être effectuer, par ex pour arêter l'anim de marche si pas de mvt
		if velocity.x == 0 && velocity.y == 0:
			anim.play(direction+"Idle")
			if reflet :
				reflet.play(direction+"Idle")
		else :
			anim.play(direction+"Marche")
			if reflet :
				reflet.play(direction+"Marche")
			
		z_index = global_position.y/2 
			
func fin_anim():
	var animFinie = anim.animation
	if animFinie == "saut" || animFinie == "coupPied":
		animBloque = false
		if animFinie == "saut" : direction = "face"
		else : direction = "droite"
		
		
func entre_zone_interactive(newzone):
	isInArea = true
	area.push_front(newzone)

func sort_zone_interactive(body):
	if area.has(body):
		var i = area.find(body)
		area.erase(i)
		if area.size() == 0 :
			isInArea = false
	
func interaction (action):
	next_action = action
	if (isInArea && area[0].has_method("area_action")):
		if action == "fleur" :
			area[0].area_action(next_action)
		elif action == "pied":
			$Timer.wait_time = 0.4
			$Timer.start()
		else :
			$Timer.wait_time = 1.2
			$Timer.start()

func interaction_later():
	area[0].area_action(next_action)
		
		
func set_reflet(b):
	reflet.visible = b
