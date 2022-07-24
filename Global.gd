extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var exe_dir
var editor_dir
# Called when the node enters the scene tree for the first time.
func _ready():
	exe_dir = OS.get_executable_path().get_base_dir()
	editor_dir = exe_dir + "/editor"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
