extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var leafs = $Hidden
onready var label = $RichTextLabel
onready var lowtext = $Label2
onready var rect = $ColorRect
onready var meter = $Meter
onready var wheatcounter = $Label
onready var anim = $AnimationPlayer
onready var deathsound = $DeathSound
onready var gateaudio = get_tree().current_scene.get_node("SOUNDS").get_node("GateSound")

var open_played = false
var deathplayed = false

var is_village = true


var ticker = 0
var dun = false

func _ready():
	if "Level" in get_tree().get_current_scene().get_name():
		is_village = false
	if get_tree().get_current_scene().get_name() == "Level4":
		lowtext.text = "Get To The Ladder..."
		lowtext.visible=true
		wheatcounter.visible = false
		get_node("Sprite").visible = false
		
	global.seenby=0
	anim.play("lvlstart")
# Called when the node enters the scene tree for the first time.
func _process(delta):
	if get_tree().get_current_scene().get_name() == "Level4" and !dun:
		ticker+=delta
		if ticker > 5:
			dun = true
			anim.play("Opened")
	if global.wheat >= 100 and !open_played and !is_village:
		anim.play("Opened")
		open_played=true
		gateaudio.play()
	wheatcounter.text = str(global.wheat)
	if global.spotted == true:
		global.bar = 1
		if deathplayed == false:
			deathplayed = true
			anim.play("Death")
			deathsound.play()
	if global.bar >= 0:
		if rect.rect_size.x <= 200:
			meter.visible = true
			rect.rect_size.x = global.bar*200
		if rect.rect_size.x == 0:
			meter.visible = false
	if global.hidden == true:
		leafs.visible = true
	else:
		leafs.visible = false
		label.text = str(global.bushcount)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Death":
		print(global.seenby)
		global.crouching = false
		global.hidden = false
		global.bushcount = 0
		global.spotted = false
		global.playerhead = Vector3()
		global.catch_pos = Vector3()
		global.wheat = 0
		global.bar = 0
		global.village_done = false
		global.seenby = 0
		queue_free()
		get_tree().reload_current_scene()
	pass # Replace with function body.
