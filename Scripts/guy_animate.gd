extends Spatial

onready var animplayer = $AnimationPlayer

export var current_anim : String
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animplayer.set_current_animation(current_anim)