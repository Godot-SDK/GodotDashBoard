extends HBoxContainer

onready var bilinScript = load("res://RepoScript/bilin.gd").new()

func _ready():
	$download2.connect("pressed",self,"_on_download2_pressed",[$version.text])
	pass
	
func _process(delta):
	
	pass
	
func _on_download_pressed(url):
	print_debug("开始下载！")
	print_debug(url)
	var output = []
	OS.execute(Global.exe_dir + "/downloader.exe",["aar",url],false,output)
	print_debug(output)
	pass

func _on_download2_pressed(version):
	
	#print_debug(version)
	if version == "3.2.3" or version == "3.3":
		OS.alert("比邻网盘中没有此版本！")
	else:
		var url = bilinScript.aar_url[version]
		print_debug("开始下载！")
		print_debug(url)
		var output = []
		OS.execute(Global.exe_dir + "/downloader.exe",["aar",url],false,output)
		print_debug(output)
	pass 
