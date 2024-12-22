extends Node2D

@export var scene_nord : int
@export var scene_sud : int
@export var scene_est : int
@export var scene_ouest : int
var scenes : Array = ["res://scenes/main.tscn","res://scenes/main_brouillard_haut_droite.tscn",
"res://scenes/main_fleurs_bas_gauche.tscn","res://scenes/main_pluie_bas_droite.tscn"]
@onready var perso = get_node("/root/scene/perso")


# Called when the node enters the scene tree for the first time.
func _ready():
	$zoneTeleporteNord.connect("body_entered", Callable(self, "change_scene_to_file").bind(scene_nord,"Sud"))
	$zoneTeleporteSud.connect("body_entered", Callable(self, "change_scene_to_file").bind(scene_sud,"Nord"))
	$zoneTeleporteEst.connect("body_entered", Callable(self, "change_scene_to_file").bind(scene_est,"Ouest"))
	$zoneTeleporteOuest.connect("body_entered", Callable(self, "change_scene_to_file").bind(scene_ouest,"Est"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func change_scene_to_file(body,_scene_num, _direction):
	if body.name == "perso":
		#Autoload.call_deferred("test","bla")
		Autoload.call_deferred("change_scene_to_file",scenes[_scene_num],_direction,perso.global_position)
		#get_node("/root/Autoload").change_scene_to_file(scenes[_scene_num],_direction,perso.global_position)
		
func set_position_perso(_perso):
	var _direction = get_node("/root/Autoload").direction_pop
	var _position = get_node("/root/Autoload").position_pop
	if _direction == "Ouest" || _direction == "Est" :
		_perso.global_position = Vector2 (get_node("zoneTeleporte"+_direction+"/zonePop").global_position.x,_position.y)
	if _direction == "Nord" || _direction == "Sud" :
		_perso.global_position = Vector2 (_position.x, get_node("zoneTeleporte"+_direction+"/zonePop").global_position.y)
	
