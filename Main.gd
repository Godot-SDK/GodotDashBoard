extends Node2D

onready var click_down_tween = $ClickDownTween
onready var click_up_tween = $ClickUPTween
onready var GodotCN = $MainPanel/she_qu/GodoterCN
onready var Godott = $MainPanel/she_qu/Godott
onready var GodotPro = $MainPanel/she_qu/GodotPro

onready var SheQuButton = $ThirdPartySheQu
onready var SheQuRoot = $MainPanel/she_qu
onready var engine = $engine
onready var GodotDataButton = $GodotDataButton
onready var DownLoadPage = $MainPanel/DownLoadPage
onready var AARLibStand = $AARLibaryStandard

onready var line = load("res://line.tscn")
onready var aar_line = load("res://aar_line.tscn")
onready var editorManagerLine = load("res://editorManager_line.tscn")

onready var tmuxScript = load("res://RepoScript/tmux.gd").new()
onready var githubScript = load("res://RepoScript/github.gd").new()
onready var giteeScript = load("res://RepoScript/gitee.gd").new()
onready var itchScript = load("res://RepoScript/itch.gd").new()

onready var EditorManage = $EditorManage2

func _ready():
	init_editor_dir()
	GodotCN.connect("gui_input",self,"jump",[GodotCN])
	Godott.connect("gui_input",self,"jump",[Godott])
	GodotPro.connect("gui_input",self,"jump",[GodotPro])
	SheQuButton.connect("pressed",self,"show_shequ")
	engine.connect("pressed",self,"jump_engine")
	GodotDataButton.connect("pressed",self,"show_data")
	#$HTTPRequest.connect("request_completed",self,"_on_get_complete")
	EditorManage.connect("pressed",self,"show_editor_manage")
	connect_left_bar()
	connect_repo_buttons()
	connect_tween()
	connect_aar_button()
	pass 
func connect_aar_button():
	#重构
	AARLibStand.connect("pressed",self,"_on_aar_lib_standard_pressed")
	pass
	
func _on_aar_lib_standard_pressed():
	clean_up_DownloadPage()
	for key in githubScript.aar_url:
		#url
		var url = githubScript.aar_url[key]
		var LineInstance = aar_line.instance()
		LineInstance.get_node("version").text = key
		var download_button = LineInstance.get_node("download")
		var download_bilin = LineInstance.get_node("download2")
		download_button.connect("pressed",LineInstance,"_on_download_pressed",[url])
		
#		for key2 in bilinScript.aar_url:
#			var url2 = bilinScript.aar_url[key2]
#			download_bilin.connect("pressed",LineInstance,"_on_download_pressed",[url])
#
		DownLoadPage.get_node("Root").add_child(LineInstance)
	
	var tip_mux = Button.new()
	tip_mux.set("custom_fonts/font",load("res://font20.tres"))
	tip_mux.text = "下载其他版本"
	tip_mux.connect("pressed",self,"goto_tmux")
	DownLoadPage.get_node("Root").add_child(tip_mux)
	pass
func init_editor_dir():
	var exe_dir = OS.get_executable_path().get_base_dir()
	var editor_dir_path = exe_dir + "/editor"
	var editor_dir = Directory.new()
	if not editor_dir.dir_exists(editor_dir_path):
		editor_dir.make_dir(editor_dir_path)
		var file = File.new()
		var err = file.open(editor_dir_path + "/__sc__",File.WRITE)
		file.store_line(" ")
		file.close()
		if err != OK:
			printerr("创建__sc__文件失败！")
			
func connect_left_bar():
	var leftBarGroup = $EditorManage.group
	var err = leftBarGroup.connect("pressed",self,"_on_left_bar_pressed")
	#print_debug(leftBarGroup)
	#print_debug(err)
	pass
	
func _on_left_bar_pressed(button):
	if button.name == "EditorManage":
		hide_shequ()
		DownLoadPage.show()
		$MainPanel/tip_choose.show()
		show_repo()
		pass
	if button.name == "ThirdPartySheQu":
		hide_repo()
		show_shequ()
		$MainPanel/tip_choose.hide()
		DownLoadPage.hide()
	#print_debug(button)
	pass
func connect_repo_buttons():
	for node in $repo_source.get_children():
		node.connect("pressed",self,"cancel_tip",[node])
	pass
	
func show_repo():
	$repo_source.show()
	pass
	
#管理本地编辑器
func show_editor_manage():
	clean_up_DownloadPage()
	var exe_files = get_downloaded_editors()
	for file in exe_files:
		var LineInstance = editorManagerLine.instance()
		LineInstance.get_node("version").text = file.get_basename()
		var pop = LineInstance.get_node("MenuButton").get_popup()
		var full_exe_path = Global.editor_dir + "/" + file
		print_debug("完整路径:",full_exe_path)
		pop.connect("id_pressed",LineInstance,"_on_Menu_changed",[full_exe_path])
		DownLoadPage.get_node("Root").add_child(LineInstance)
	pass
	
func get_downloaded_editors() -> Array:
	var exe_files = []
	var dir = Directory.new()
	if dir.open(Global.editor_dir) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print_debug("发现目录：" + file_name)
				pass
			else:
				if file_name.ends_with(".exe"):
					print_debug("发现exe：" + file_name)
					exe_files.append(file_name)
			file_name = dir.get_next()
	else:
		print_debug("error")
		printerr("尝试访问路径时出错。")
	return exe_files
	pass
func hide_repo():
	$repo_source.hide()
	
func clean_up_DownloadPage():
	for childs in DownLoadPage.get_node("Root").get_children():
		childs.queue_free()
	pass
#这里的需要重命名
#此处用于处理右侧的软件源按钮事件
func cancel_tip(node):
	#https://api.github.com/repos/godotengine/godot/releases 查询所有发布的版本
	#https://api.github.com/repos/godotengine/godot/releases/latest 查询最新版本
	$MainPanel/tip_choose.hide()
	if node.name == "offical":
		#print_debug("开始请求")
		# warning-ignore:return_value_discarded
		OS.shell_open("https://godotengine.org/download")
		#$HTTPRequest.request("https://api.github.com/repos/godotengine/godot/releases",[],true,HTTPClient.METHOD_GET)
	if node.name == "itch":
		clean_up_DownloadPage()
		for key in itchScript.itch_url:
			var x86 = itchScript.itch_url[key]["32bit"]
			var x64 = itchScript.itch_url[key]["64bit"]
			#print_debug(x86)
			#print_debug(x64)
			var LineInstance = line.instance()
			LineInstance.get_node("version").text = key
			var download_button_32 = LineInstance.get_node("32")
			var download_button_64 = LineInstance.get_node("64")

			download_button_32.connect("pressed",LineInstance,"_on_button_32_pressed",[x86])
			download_button_64.connect("pressed",LineInstance,"_on_button_32_pressed",[x64])
			
			DownLoadPage.get_node("Root").add_child(LineInstance)
			
		var tip_itch = Button.new()
		tip_itch.set("custom_fonts/font",load("res://font20.tres"))
		tip_itch.text = "下载其他版本"
		tip_itch.connect("pressed",self,"goto_itch")
		DownLoadPage.get_node("Root").add_child(tip_itch)
		
	if node.name == "github":
		# warning-ignore:return_value_discarded
		clean_up_DownloadPage()
		for key in githubScript.editor_url:
			var x86 = githubScript.editor_url[key]["32bit"]
			var x64 = githubScript.editor_url[key]["64bit"]
			var LineInstance = line.instance()
			LineInstance.get_node("version").text = key
			var download_button_32 = LineInstance.get_node("32")
			var download_button_64 = LineInstance.get_node("64")
			
			download_button_32.connect("pressed",LineInstance,"_on_button_32_pressed",[x86])
			download_button_64.connect("pressed",LineInstance,"_on_button_32_pressed",[x64])
			DownLoadPage.get_node("Root").add_child(LineInstance)
			
		var tip_github = Button.new()
		tip_github.set("custom_fonts/font",load("res://font20.tres"))
		tip_github.text = "下载其他版本"
		tip_github.connect("pressed",self,"goto_github")
		DownLoadPage.get_node("Root").add_child(tip_github)
	if node.name == "gitee":
		# warning-ignore:return_value_discarded
		clean_up_DownloadPage()
		DownLoadPage.show()
		var tip_gitee = Label.new()
		tip_gitee.set("custom_fonts/font",load("res://font20.tres"))
		tip_gitee.text = GiteeRepo.repo_info
		
		var tip_link = Button.new()
		tip_link.text = "Gitee"
		tip_link.connect("pressed",self,"goto_gitee")
		
		DownLoadPage.get_node("Root").add_child(tip_gitee)
		DownLoadPage.get_node("Root").add_child(tip_link)
	if node.name == "tmux":
		clean_up_DownloadPage()
		DownLoadPage.show()
		#$MainPanel/DownLoadPage/Root/tip_tmux.show()
		for key in tmuxScript.urls:
			#url
			var x86 = tmuxScript.urls[key]["32bit"]
			var x64 = tmuxScript.urls[key]["64bit"]
			#print_debug(x86)
			#print_debug(x64)
			var LineInstance = line.instance()
			LineInstance.get_node("version").text = key
			var download_button_32 = LineInstance.get_node("32")
			var download_button_64 = LineInstance.get_node("64")
			
			download_button_32.connect("pressed",LineInstance,"_on_button_32_pressed",[x86])
			download_button_64.connect("pressed",LineInstance,"_on_button_32_pressed",[x64])
			
			DownLoadPage.get_node("Root").add_child(LineInstance)
			
		var tip_mux = Button.new()
		tip_mux.set("custom_fonts/font",load("res://font20.tres"))
		tip_mux.text = "下载其他版本"
		tip_mux.connect("pressed",self,"goto_tmux")
		DownLoadPage.get_node("Root").add_child(tip_mux)
		#OS.shell_open("https://downloads.tuxfamily.org/godotengine")
	if node.name == "GodotSDK":
# warning-ignore:return_value_discarded
		OS.shell_open("https://github.com/Godot-SDK")
		
func _on_get_complete(result, response_code, headers, body):
	print_debug("请求结束")
	#print_debug(result)
	#print_debug(response_code)
	print_debug(headers)
	print_debug(body)
	pass
	
func _on_EditorManage_pressed():
	$repo_source.show()
	$MainPanel/tip_choose.show()
	pass
	
#连接磁贴tween
func connect_tween():
	click_up_tween.connect("tween_completed",self,"tween_completed")
	pass

func tween_completed(object,key):
	if object.name == "GodoterCN":
		OS.shell_open("https://godoter.cn")
		pass
	if object.name == "Godott":
		OS.shell_open("http://godott.com")
		pass
	if object.name == "GodotPro":
		OS.shell_open("https://godot.pro/")
		pass
	#print_debug("tween执行完毕 ",object,key)
	pass
	
#每一个磁贴点击时都会触发
func jump(event,node):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		click_down_tween.interpolate_property(node, "rect_scale",Vector2(1, 1), Vector2(0.9, 0.9), 0.1,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		click_down_tween.start()
	if event is InputEventMouseButton and not event.pressed and event.button_index == BUTTON_LEFT:
		click_up_tween.interpolate_property(node, "rect_scale",Vector2(0.9, 0.9), Vector2(1, 1), 0.1,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		click_up_tween.start()
	pass
	
func jump_engine():
	OS.shell_open("https://godotengine.org/")
	
func show_shequ():
	SheQuRoot.show()
	pass
	
func hide_shequ():
	SheQuRoot.hide()
	
func show_data():
	#var user_name = "Administrator"
	var dir = OS.get_executable_path().get_base_dir()
	var fullpath = dir + "/GetUserName.exe"
	print_debug("完整可执行文件路径",fullpath)
	var output = []
	var exit_code = OS.execute(fullpath,[],true,output)
	print_debug("exit_code: ",exit_code)
	if exit_code != OK:
		printerr("发生错误！","Main.gd >> 调用exe失败")
	else:
		var file = File.new()
		file.open(dir+"/username.txt",File.READ)
		var user_name = file.get_as_text()
		file.close()
		var err = OS.shell_open("C:/Users/" + user_name + "/AppData/Roaming/Godot")
		if err != OK:
			print_debug("无法打开文件夹")
	pass

func goto_tmux():
	OS.shell_open("https://downloads.tuxfamily.org/godotengine")
	pass
	
func goto_gitee():
	OS.shell_open("https://gitee.com/mirrors/godot")
	
func goto_itch():
	OS.shell_open("https://godotengine.itch.io/godot")

func goto_github():
	OS.shell_open("https://github.com/godotengine/godot/releases")
