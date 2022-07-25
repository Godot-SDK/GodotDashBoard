tool
extends HBoxContainer

#这个脚本包含了测试代码，需要整理
var downloaded_size = ""
func _ready():
	pass 

func _process(delta):
	pass
	
func _on_button_32_pressed(url):
	print_debug("开始下载！")
	print_debug(url)
	var output = []
	OS.execute(Global.exe_dir + "/downloader.exe",["editor",url],false,output)
	print_debug(output)
	pass
	
func _on_button_64_pressed(url):
	print_debug("开始下载！")
	print_debug(url)
	var output = []
	OS.execute(Global.exe_dir + "/downloader.exe",["editor",url],false,output)
	print_debug(output)
	pass
