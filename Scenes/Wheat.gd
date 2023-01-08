extends Area

onready var glow = $Glow
onready var wheataudio = get_tree().current_scene.get_node("SOUNDS").get_node("WheatSound")

var rng = RandomNumberGenerator.new()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var takeable = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	glow.visible = 0
	pass # Replace with function body.

func _process(delta):
	if takeable == 1 and Input.is_action_just_pressed("grab"):
		global.wheat = global.wheat + 1
		print(global.wheat)
		took()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Wheat_area_entered(area):
	if area.is_in_group("hands"):
		takeable = 1
		glow.visible = 1
	pass # Replace with function body.


func _on_Wheat_area_exited(area):
	if area.is_in_group("hands"):
		takeable = 0
		glow.visible = 0
	pass # Replace with function body.

func took():
	wheataudio.pitch_scale = rng.randf_range(0.85, 1.3)
	wheataudio.play()
	
	queue_free()
