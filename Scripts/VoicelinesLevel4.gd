extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var startvoice = $SOUNDS/StartVoice
onready var midvoice = $SOUNDS/MidVoice
var mid_played = false

var tickerstart = false
var ticker = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	startvoice.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TriggerSpeech_area_entered(area):
	if area.is_in_group("player") and !mid_played:
		mid_played = true
		midvoice.play()
