extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var anim = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("Intro")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Intro":
		get_tree().change_scene("res://Scenes/Home Village.tscn")
