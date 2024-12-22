extends Node2D

var target
var screenSize
var boundMin
var boundMax

# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_node("/root/scene/perso")
	screenSize = get_viewport().size/2
	boundMin = Vector2 (get_node("/root/scene/bords/zoneTeleporteOuest").global_position.x+screenSize.x,get_node("/root/scene/bords/zoneTeleporteNord").global_position.y+screenSize.y)
	boundMax = Vector2 (get_node("/root/scene/bords/zoneTeleporteEst").global_position.x-screenSize.x,get_node("/root/scene/bords/zoneTeleporteSud").global_position.y-screenSize.y)

func _physics_process(_delta):
	global_position = Vector2 (clamp(target.global_position.x, boundMin.x,boundMax.x), clamp( target.global_position.y,boundMin.y,boundMax.y))
