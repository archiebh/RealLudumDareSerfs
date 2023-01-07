extends Area
onready var sprite = $Sprite3D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Bush_area_entered(area):
	if global.crouching == true:
		if area.is_in_group("player"):
			sprite.opacity = 0.5
	pass # Replace with function body.


func _on_Bush_area_exited(area):
	if area.is_in_group("player"):
		sprite.opacity = 1
	pass # Replace with function body.
