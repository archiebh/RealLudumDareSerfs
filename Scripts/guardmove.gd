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
onready var aggrostream = $AggroPlayer
onready var ambientstream = $AmbientPlayer
onready var footstep = $Footstep
onready var guy = $guy

var playerbox = 0
var c = 0
var timer = 0
var object_look_at
var rng = RandomNumberGenerator.new()

var step_tick = 0.9
var step_elapsed = 0

var tick
var elapsed = 0

var ap = "res://Sounds/Voice/Guard/Ambient/"
var bp = "res://Sounds/Voice/Guard/Aggro/"

var ambient_vox = [preload("res://Sounds/Voice/Guard/Ambient/1.mp3"),
preload("res://Sounds/Voice/Guard/Ambient/2.mp3"),
preload("res://Sounds/Voice/Guard/Ambient/3.mp3"),
preload("res://Sounds/Voice/Guard/Ambient/4.mp3"),
preload("res://Sounds/Voice/Guard/Ambient/5.mp3"),
preload("res://Sounds/Voice/Guard/Ambient/6.mp3"),
preload("res://Sounds/Voice/Guard/Ambient/7.mp3"),
preload("res://Sounds/Voice/Guard/Ambient/8.mp3"),
preload("res://Sounds/Voice/Guard/Ambient/9.mp3"),
preload("res://Sounds/Voice/Guard/Ambient/10.mp3"),
preload("res://Sounds/Voice/Guard/Ambient/11.mp3"),
preload("res://Sounds/Voice/Guard/Ambient/12.mp3"),
preload("res://Sounds/Voice/Guard/Ambient/13.mp3"),
preload("res://Sounds/Voice/Guard/Ambient/14.mp3"),
preload("res://Sounds/Voice/Guard/Ambient/15.mp3"),
preload("res://Sounds/Voice/Guard/Ambient/16.mp3")]

var aggro_vox = [preload("res://Sounds/Voice/Guard/Aggro/1.mp3"),
preload("res://Sounds/Voice/Guard/Aggro/2.mp3"),
preload("res://Sounds/Voice/Guard/Aggro/3.mp3"),
preload("res://Sounds/Voice/Guard/Aggro/4.mp3"),
preload("res://Sounds/Voice/Guard/Aggro/5.mp3"),
preload("res://Sounds/Voice/Guard/Aggro/6.mp3"),]

var countedyet=0
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	tick=rng.randf_range(8.5, 19.5)
	pathnode.curve=curv;
	var c = 0;
	var timer = 0;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if elapsed >= tick:
		elapsed=0
		tick=rng.randf_range(8.5, 19.5)
		ambientstream.stream = ambient_vox[rng.randi_range(0, 15)]
		ambientstream.play()
	if global.spotted == true:
		guy.current_anim = "Idle"
		look_at(global.catch_pos, Vector3.UP)
		rotation.y += deg2rad(180)
		return;
	if step_elapsed > step_tick and global.spotted == false:
		step_elapsed = 0
		footstep.pitch_scale = rng.randf_range(0.85, 1.3)
		footstep.play()
		
		
	if (follownode.unit_offset >= stops[c] and c != 0) or (follownode.unit_offset >= stops[c] and c == 0 and follownode.unit_offset < stops[-1]):
		timer += delta
		guy.current_anim = "Idle"
		if timer >= times[c]:
			c += 1
			c %= stopcount
			timer = 0
	else:
		guy.current_anim = "Walk"
		follownode.unit_offset += speed*delta*0.05
		follownode.unit_offset = fmod(follownode.unit_offset, 1.0)
		step_elapsed+=delta
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
					print(global.seenby)
				global.bar += delta;
				var farness = head.global_translation.distance_to(rayc.get_collision_point())
				if global.bar >= 1 or farness <= 10:
					global.bar = 1
					global.spotted = true
					ambientstream.stop()
					aggrostream.stream = aggro_vox[rng.randi_range(0, 5)]
					aggrostream.play()
			else:
				if countedyet == 1:
					global.seenby = global.seenby - 1
					countedyet = 0
	if global.seenby == 0 and global.bar > 0:
		global.bar -= delta/6
		if global.bar < 0:
			global.bar = 0
	elapsed+=delta
		
	
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
