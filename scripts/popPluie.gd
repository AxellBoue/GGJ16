extends Node2D

onready var pluie = preload("res://obj/pluie/pluie.tscn")
onready var pluie2 = preload("res://obj/pluie/pluie2.tscn")
onready var pluie_r = preload("res://obj/pluie/pluie_r.tscn")
onready var pluie2_r = preload("res://obj/pluie/pluie2_r.tscn")
onready var pluie_t = preload("res://obj/pluie/pluie_t.tscn")
onready var pluie2_t = preload("res://obj/pluie/pluie2_t.tscn")
onready var pluies = [pluie,pluie2,pluie_r,pluie2_r,pluie_t,pluie2_t]
export (float) var deltaGouttesMin = 0.2
export (float) var deltaGouttesMax = 0.8
var min_initial
var max_initial

onready var camera = get_node("/root/scene/camera box/camera")
var screenSize
var r = RandomNumberGenerator.new()
var timer

# Called when the node enters the scene tree for the first time.
func _ready():
	screenSize = get_viewport().size/2
	print(screenSize)
	timer = get_node("Timer")
	timer.wait_time = deltaGouttesMax
	timer.connect("timeout",self,"goutte")
	timer.start()
	r.randomize()
	min_initial = deltaGouttesMin
	max_initial = deltaGouttesMax

func goutte ():
	timer.wait_time = r.randf_range(deltaGouttesMin,deltaGouttesMax)
	var newGoutte = pluies[r.randi_range(0,pluies.size()-1)].instance()
	add_child(newGoutte)
	newGoutte.position = Vector2(r.randi_range(camera.global_position.x-screenSize.x,camera.global_position.x+screenSize.x), 
	r.randi_range(camera.global_position.y-screenSize.y,camera.global_position.y+screenSize.y))
	
func set_delta_gouttes(_min, _max):
	deltaGouttesMin = _min
	deltaGouttesMax = _max

func reset_delta_gouttes():
	deltaGouttesMin = min_initial
	deltaGouttesMax = max_initial
