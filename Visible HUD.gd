extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var leafs = $Hidden
onready var label = $RichTextLabel
# Called when the node enters the scene tree for the first time.
func _process(delta):
	if global.hidden == true:
		leafs.visible = true
	else:
		leafs.visible = false
		label.text = str(global.bushcount)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
