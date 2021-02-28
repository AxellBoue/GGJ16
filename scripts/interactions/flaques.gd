extends Area2D


export var note : AudioStream
onready var ocarina_man = get_node("/root/scene/monstres/mr ocarina")
export var num_note = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",self,"on_body_entered")

func on_body_entered(body):
	if body.name == "perso" :
		$AudioStreamPlayer2D.stream = note
		$AudioStreamPlayer2D.play()
		ocarina_man.joue_note(num_note)
