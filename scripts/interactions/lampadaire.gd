@tool
extends StaticBody2D

var allume = false
@onready var perso = get_node("/root/scene/perso")
@onready var current_lampadaire = $"lampadaire-eteint"

func _draw():
	if Engine.is_editor_hint():
		material.set_shader_parameter("global_transform", get_global_transform())


# Called when the node enters the scene tree for the first time.
func _ready():
	$"lampadaire-allume".material = $"lampadaire-allume".material.duplicate()
	$"lampadaire-eteint".material = $"lampadaire-eteint".material.duplicate()
	z_index = global_position.y/2
	z_as_relative = false
	$Area2D.connect("body_entered", Callable(self, "on_body_entered"))
	$Area2D.connect("body_exited", Callable(self, "on_body_exited"))
	$AnimationPlayer.play("eteint")


func on_body_entered(body):
	if body.name == "perso":
		body.entre_zone_interactive(self)
	

func on_body_exited(body):
	if body.name == "perso":
		body.sort_zone_interactive(self)

func area_action(action):
	if action == "pied":
		if !allume :
			$AnimationPlayer.play("allume")
			current_lampadaire = $"lampadaire-allume"
			allume = true
		else :
			$AnimationPlayer.play("eteint")
			current_lampadaire = $"lampadaire-eteint"
			allume = false
			
func _process(_delta):
	if not Engine.is_editor_hint():
		current_lampadaire.material.set_shader_parameter("distancePlayer", global_position.distance_to(perso.global_position))
		current_lampadaire.material.set_shader_parameter("global_transform", get_global_transform())
	
