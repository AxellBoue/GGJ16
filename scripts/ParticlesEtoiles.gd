extends Particles2D


# Declare member variables here. Examples:
var deuxieme_burst = false


# Called when the node enters the scene tree for the first time.
func _ready():
	emitting = true
	$Timer.one_shot = true
	$Timer.wait_time = 0.3
	$Timer.start()


func _on_Timer_timeout():
	if !deuxieme_burst :
		$ParticlesEtoiles2.emitting = true
		deuxieme_burst = true
		$Timer.wait_time = 1
		$Timer.start()
	else :
		queue_free()
