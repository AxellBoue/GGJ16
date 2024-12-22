extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("body_entered", Callable(self, "on_body_entered"))
	$Area2D.connect("body_exited", Callable(self, "on_body_exited"))


func on_body_entered(body):
	if body.has_method("set_reflet"):
		body.set_reflet(true)

func on_body_exited(body):
	if body.has_method("set_reflet"):
		body.set_reflet(false)
