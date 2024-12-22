extends StaticBody2D


var musique_attendue : Array = [4,1,2,3]
var num_note = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = global_position.y/2
	$Timer.wait_time = 10
	$Timer.connect("timeout", Callable(self, "rejoue"))


func joue_note(i : int):
	if i == musique_attendue[num_note]:
		num_note += 1
		if num_note >= 4:
			$AudioStreamPlayer2D.stop()
			$Timer.stop()
			$Timer.start()
			num_note = 0
	else :
		num_note = 0

func rejoue ():
	$AudioStreamPlayer2D.play()
