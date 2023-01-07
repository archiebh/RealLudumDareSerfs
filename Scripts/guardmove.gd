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

var c = 0
var timer = 0

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
