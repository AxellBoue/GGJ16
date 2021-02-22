tool
extends AnimatedSprite

onready var perso = get_node("/root/scene/perso")


func _draw():
	if Engine.editor_hint:
		z_index = global_position.y/2
		material.set_shader_param("distancePlayer", global_position.distance_to(Vector2(360,226)))
		
		
# Called when the node enters the scene tree for the first time.
func _ready():
	material = material.duplicate()
	z_index = global_position.y/2 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not Engine.editor_hint:
		material.set_shader_param("global_transform", get_global_transform())
		material.set_shader_param("distancePlayer", global_position.distance_to(perso.global_position))
