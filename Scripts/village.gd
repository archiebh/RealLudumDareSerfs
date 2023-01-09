extends CSGBox


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var playr = $"../Player"
onready var speech = $AudioStreamPlayer3D
onready var pile = $"../fence/Pile"
onready var crowd = $"../Crowd"

var max_pile = 3.754
var min_pile = 1
var target_size = 1
var growing = false

var target_child
var children_direction = []

var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	pile.radius = min_pile
	pass # Replace with function body.

func growpile():
	var completion = (global.wheat/float(120))
	target_size = min_pile + ((max_pile-min_pile)*completion)
	growing = true
	pile.get_node("AudioStreamPlayer3D").play()
	global.wheat = 0
	for i in range(crowd.get_child_count()):
		children_direction.append("up")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.village_done:
		for i in range(crowd.get_child_count()):
			target_child = crowd.get_child(i)
			if children_direction[i] == "up":
				target_child.translation.y += rng.randf_range(0, 4) * delta
			else:
				target_child.translation.y -= rng.randf_range(0, 4) * delta
			
			if target_child.translation.y > 2:
				children_direction[i] = "down"
			elif target_child.translation.y < 1.5:
				children_direction[i] = "up"
	if growing:
		pile.radius += delta
		if pile.radius >= target_size:
			growing = false
			speech.play()
	if global_translation.distance_to(playr.global_translation) < 14 and !global.village_done:
		global.village_done = 1
		growpile()
		
