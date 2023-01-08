extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
	global.seenby = 0
	if get_tree().get_current_scene().get_name() == "Level1":
		get_tree().change_scene("res://Scenes/AfterLevel1.tscn")
	elif get_tree().get_current_scene().get_name() == "AfterLevel1.tscn":
		get_tree().change_scene("res://Scenes/Level2.tscn")
	elif get_tree().get_current_scene().get_name() == "Level2.tscn":
		get_tree().change_scene("res://Scenes/AfterLevel2.tscn")

func _on_ENDZONE_area_entered(area):
	if area.is_in_group("player"):
		if global.wheat >= 100:
			print("Level Complete")
		else:
			print("Not Enough Weet")
	nextScene()
			
			
