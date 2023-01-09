extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var sav
onready var anim = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("Orbit")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_New_Game_pressed():
	get_tree().change_scene("res://Scenes/StartCutScene.tscn")
	sav = savefile.new()
	sav.lvl_name = "Home Village.tscn"
	ResourceSaver.save("user://serf_savegame.tres", sav)


func _on_Continue_pressed():
	if ResourceLoader.exists("user://serf_savegame.tres"):
		get_tree().change_scene( "res://Scenes/"+str( ResourceLoader.load("user://serf_savegame.tres").lvl_name ) )
