extends Spatial


# Declare member variables here. Examples:
export var curv : Curve3D;
export var speed : float;
export var y_offset : float;
export var stopcount : int;
export (Array, float) var stops;
export (Array, float) var times;

onready var pathnode = get_node("Path");
onready var follownode = get_node("Path/PathFollow");
onready var vision = $Vision
onready var rayc = $Head/RayCast
onready var head = $Head
var playerbox = 0
var c = 0
var timer = 0
var object_look_at

# Called when the node enters the scene tree for the first time.
func _ready():
	pathnode.curve=curv;
	var c = 0;
	var timer = 0;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (follownode.unit_offset >= stops[c] and c != 0) or (follownode.unit_offset >= stops[c] and c == 0 and follownode.unit_offset < stops[-1]):
		timer += delta
		if timer >= times[c]:
			c += 1
			c %= stopcount
			timer = 0
	else:
		follownode.unit_offset += speed*delta*0.05
		follownode.unit_offset = fmod(follownode.unit_offset, 1.0)
	translation=follownode.translation+Vector3(0, y_offset, 0)
	rotation.y=follownode.rotation.y
	rotation.z=follownode.rotation.z
	if playerbox == 1 and not global.hidden:
		print(object_look_at.global_translation)
		head.look_at(object_look_at.global_translation, Vector3.UP)
		head.rotation.z*=-1
		print(rayc.cast_to)
		if rayc.is_colliding():
			if rayc.get_collider().is_in_group("player"):
				global.spotted = true
	
func _on_Vision_area_entered(area):
	if area.is_in_group("player"):
		object_look_at = area
		print("SMELL")
		playerbox = 1

func _on_Vision_area_exited(area):
	if area.is_in_group("player"):
		playerbox = 0
