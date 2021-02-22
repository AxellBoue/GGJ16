tool
extends Sprite

onready var perso = get_node("/root/scene/perso")


func _draw():
	if Engine.editor_hint:
		material.set_shader_param("player_pos",Vector2(360,226))

# Called when the node enters the scene tree for the first time.
func _ready():
	material.set_shader_param("global_transform", get_global_transform())


func _process(delta):
	if not Engine.editor_hint:
		material.set_shader_param("player_pos",perso.global_position)
