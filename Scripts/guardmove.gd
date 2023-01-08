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
onready var rayc = $Head/RayCast
onready var head = $Head
var playerbox = 0
var c = 0
var timer = 0
var object_look_at

var countedyet=0
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
	translation=follownode.translation+Vector3(x_offset, y_offset, z_offset)
	rotation.y=follownode.rotation.y
	rotation.z=follownode.rotation.z
	if playerbox == 1 and not global.hidden:
		head.look_at(object_look_at.global_translation, Vector3.UP)
		head.rotation.z*=-1
		if rayc.is_colliding():
			if rayc.get_collider().is_in_group("player"):
				if countedyet == 0:
					global.seenby = global.seenby + 1
					countedyet = 1
				global.bar += delta;
				var farness = head.global_translation.distance_to(rayc.get_collision_point())
				if global.bar >= 1 or farness <= 10:
					global.bar = 1
					global.spotted = true
			else:
				if countedyet == 1:
					global.seenby = global.seenby - 1
					countedyet = 0
	if global.seenby == 0 and global.bar > 0:
		global.bar -= delta/6
		if global.bar < 0:
			global.bar = 0
		
	
func _on_Vision_area_entered(area):
	if area.is_in_group("player"):
		object_look_at = area
		playerbox = 1

func _on_Vision_area_exited(area):
	if area.is_in_group("player"):
		if countedyet == 1:
			global.seenby = global.seenby - 1
			countedyet = 0;
		playerbox = 0
