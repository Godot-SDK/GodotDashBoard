tool
extends HBoxContainer

#这个脚本包含了测试代码，需要整理
var downloaded_size = ""
func _ready():
	#var a = "https://downloads.tuxfamily.org/godotengine/3.0/Godot_v3.0-stable_win32.exe.zip"
	#$HTTPRequest.request("https://downloads.tuxfamily.org/godotengine/3.0/Godot_v3.0-stable_win32.exe.zip")
	$HTTPRequest.connect("request_completed",self,"_on_get_completed")
	$status.text = "下载中"
	#$HTTPRequest.download_file = Global.editor_dir + "/test.exe.zip"
	pass 

func _process(delta):
	var downloaded_bytes = $HTTPRequest.get_downloaded_bytes()
	downloaded_size = str(downloaded_bytes).humanize_size(downloaded_bytes)
	$status.text = "下载中" + downloaded_size
	#print_debug($HTTPRequest.get_downloaded_bytes())
	pass
func _on_button_32_pressed(url):
	print_debug(url)
	$HTTPRequest.request(url)
	$HTTPRequest.download_file = Global.editor_dir + "/" + url.get_file()
	
	pass
func _on_button_64_pressed(url):
	print_debug(url)
	$HTTPRequest.request(url)
	pass

func _on_get_completed(result, response_code, headers, body):
	print_debug(response_code)
	print_debug(body)
	pass
	
