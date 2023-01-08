extends CSGBox


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var playr = $"../Player"
onready var lightup = $LightUp
onready var pile = $"../fence/Pile"

var max_pile = 3.754
var min_pile = 1
var target_size = 1
var growing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pile.radius = min_pile
	pass # Replace with function body.

func growpile():
	var completion = (global.wheat/120)
	target_size = min_pile + (max_pile-min_pile)*completion
	growing = true
	global.wheat = 0
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if growing:
		pile.radius += delta
		if pile.radius >= target_size:
			growing = false
	if global_translation.distance_to(playr.global_translation) < 4 and !global.village_done:
		lightup.light_energy = 4;
		if Input.is_action_just_pressed("grab"):
			global.village_done = 1
			growpile()
	else:
		lightup.light_energy = 0;
		
