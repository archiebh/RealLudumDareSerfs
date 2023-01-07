extends Spatial


# Declare member variables here. Examples:
export var curv : Curve3D;
export var speed : float;
onready var pathnode = get_node("Path");
onready var follownode = get_node("Path/PathFollow");


# Called when the node enters the scene tree for the first time.
func _ready():
	pathnode.curve=curv;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	follownode.unit_offset += speed*delta;
