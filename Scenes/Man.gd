extends Sprite3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var playr = $"../Player"
onready var anime = $"../AnimationPlayer"
var triggered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playr.global_translation.x > -12 and !triggered:
		anime.play("ManWalk")
		triggered = true
		global.village_done=true
	
