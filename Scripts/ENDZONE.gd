extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var is_level;

# Called when the node enters the scene tree for the first time.
func _ready():
	is_level = false;
	if "Level" in get_tree().get_current_scene().get_name():
		is_level = true;


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func nextScene():
	global.crouching = false
	global.hidden = false
	global.bushcount = 0
	global.spotted = false
	global.playerhead = Vector3()
	global.catch_pos = Vector3()
	global.bar = 0
	global.village_done = false
	global.seenby = 0
	if get_tree().get_current_scene().get_name() == "Level1":
		get_tree().change_scene("res://Scenes/Village1.tscn")
	elif get_tree().get_current_scene().get_name() == "Village1":
		get_tree().change_scene("res://Scenes/Level2.tscn")
	elif get_tree().get_current_scene().get_name() == "Level2":
		get_tree().change_scene("res://Scenes/Village2.tscn")
	elif get_tree().get_current_scene().get_name() == "Village2":
		get_tree().change_scene("res://Scenes/Level3.tscn")
	elif get_tree().get_current_scene().get_name() == "Level3":
		get_tree().change_scene("res://Scenes/Village3.tscn")
	elif get_tree().get_current_scene().get_name() == "Village3":
		get_tree().change_scene("res://Scenes/Level4.tscn")
	elif get_tree().get_current_scene().get_name() == "Level4":
		get_tree().change_scene("res://Scenes/FinalScene.tscn")
	elif get_tree().get_current_scene().get_name() == "Village0":
		get_tree().change_scene("res://Scenes/Level1.tscn")

func _on_ENDZONE_area_entered(area):
	if area.is_in_group("player"):
		if is_level:
			if global.wheat >= 100:
				print("Level Complete")
				nextScene()
			else:
				print("Not Enough Weet")
		else:
			if global.village_done:
				print("Village Complete")
				nextScene()
			else:
				print("Village Not Done")
			
			
