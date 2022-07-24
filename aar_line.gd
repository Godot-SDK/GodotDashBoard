extends HBoxContainer
var downloaded_size = ""
func _ready():
	$HTTPRequest.connect("request_completed",self,"_on_download_completed")
	pass
	
func _process(delta):
	var downloaded_bytes = $HTTPRequest.get_downloaded_bytes()
	downloaded_size = str(downloaded_bytes).humanize_size(downloaded_bytes)
	$status.text = "下载中" + downloaded_size
	pass
	
func _on_download_pressed(url):
	print_debug(url)
	$HTTPRequest.request(url)
	var download_path = Global.editor_dir + "/" + url.get_file()
	$HTTPRequest.download_file = download_path
	print_debug(download_path)
	pass

func _on_download_completed(result, response_code, headers, body):
	print_debug(response_code)
	#print_debug(body)
	pass
	
