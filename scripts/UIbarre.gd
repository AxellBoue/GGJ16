extends TextureProgress


var valeur = 0
var valeur_temp = 0
var baisse = false
var monte = false
var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	value = 0
	$jaune.value = 0

#func _input(event):
#	if event.is_action_pressed("haut"):
#		change_valeur(30)
	#if event.is_action_pressed("bas"):
	#	change_valeur(-20)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if monte : 
		$jaune.value += delta * speed
		if $jaune.value >= valeur :
			$jaune.value = valeur
			monte = false
	elif baisse : 
		value -= delta * speed
		if value <= valeur :
			value = valeur
			baisse = false


func change_valeur(new_valeur):
	valeur += new_valeur
	valeur = clamp(valeur,0,100)
	if new_valeur > 0 :
		value = valeur
		baisse = false
		monte = true
	elif new_valeur < 0 :
		$jaune.value = valeur
		monte = false
		baisse = true
