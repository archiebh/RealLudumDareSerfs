extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var label = $Spatial/Label3D
onready var open = $Open
onready var closed = $Closed

var is_level = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if get_tree().get_current_scene().get_name() == "Village0":
		label.text = "Farmer's Field"
		
	elif get_tree().get_current_scene().get_name() == "Village1":
		label.text = "Vogger Town"
	elif get_tree().get_current_scene().get_name() == "Village2":
		label.text = "Slunham City"
	elif get_tree().get_current_scene().get_name() == "Village3":
		label.text = "Shanny Castle"
	elif get_tree().get_current_scene().get_name() == "Level1":
		label.text = "Clun Village"
		is_level=true
	elif get_tree().get_current_scene().get_name() == "Level2":
		label.text = "Griv Village"
		is_level=true
	elif get_tree().get_current_scene().get_name() == "Level3":
		label.text = "Shan Village"
		is_level=true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_level:
		if global.wheat >= 100:
			open.visible=true
			closed.visible=false
		else:
			open.visible=false
			closed.visible=true
	else:
		if global.village_done:
			open.visible=true
			closed.visible=false
		else:
			open.visible=false
			closed.visible=true
