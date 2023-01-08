extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var leafs = $Hidden
onready var label = $RichTextLabel
onready var rect = $ColorRect
onready var meter = $Meter
# Called when the node enters the scene tree for the first time.
func _process(delta):
	if global.spotted == true:
		global.bar = 1
	if global.bar >= 0:
		if rect.rect_size.x <= 200:
			meter.visible = true
			rect.rect_size.x = global.bar*200
		if rect.rect_size.x == 0:
			meter.visible = false
	if global.hidden == true:
		leafs.visible = true
	else:
		leafs.visible = false
		label.text = str(global.bushcount)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
