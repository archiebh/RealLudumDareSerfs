extends Node

var crouching = false
var hidden = false
var bushcount = 0
var spotted = false
var playerhead = Vector3()
var catch_pos = Vector3()
var wheat = 0
var bar = 0
var village_done = false
var seenby = 0
var current_level = "Home Village.tscn"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		print("Crannerfarm")
		get_tree().change_scene("res://Scenes/Menu.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
