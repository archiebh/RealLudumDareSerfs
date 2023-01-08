extends Spatial


# Declare member variables here. Examples:
export var curv : Curve3D;
export var speed : float;
export var x_offset : float;
export var y_offset : float;
export var z_offset : float;
export var stopcount : int;
export (Array, float) var stops;
export (Array, float) var times;

onready var pathnode = get_node("Path");
onready var follownode = get_node("Path/PathFollow");
onready var vision = $Vision
var c = 0
var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pathnode.curve=curv;
	var c = 0;
	var timer = 0;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.spotted == true:
		global_translation.x = global.catch_pos.x
		global_translation.z = global.catch_pos.z
		return;
	if (follownode.unit_offset >= stops[c] and c != 0) or (follownode.unit_offset >= stops[c] and c == 0 and follownode.unit_offset < stops[-1]):
		timer += delta
		if timer >= times[c]:
			c += 1
			c %= stopcount
			timer = 0
	else:
		follownode.unit_offset += speed*delta*0.05
		follownode.unit_offset = fmod(follownode.unit_offset, 1.0)
	translation=follownode.translation+Vector3(x_offset, y_offset, z_offset)
	
func _on_Vision_area_entered(area):
	if area.is_in_group("player") and not global.hidden:
		global.spotted = true
