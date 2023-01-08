extends Spatial


# Declare member variables here. Examples:
export var x_offset : float;
export var y_offset : float;
export var z_offset : float;

onready var vision = $Vision
onready var rayc = $Head/RayCast
onready var head = $Head
var playerbox = 0
var object_look_at

var countedyet=0
# Called when the node enters the scene tree for the first time.
func _ready():
	translation.y += y_offset
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.spotted == true:
		look_at(global.catch_pos, Vector3.UP)
		rotation.y += deg2rad(180)
		return;
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
