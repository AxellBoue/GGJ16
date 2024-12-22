extends AnimatedSprite2D


@export var pousse = false

func _draw():
	if Engine.is_editor_hint():
		z_index = global_position.y/2
		
# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = global_position.y/2 
	if pousse :
		play("pousse")
		connect("animation_finished", Callable(self, "pousse_finished"))

func pousse_finished():
	play("default")
	disconnect("animation_finished", Callable(self, "pousse_finished"))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
