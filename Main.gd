extends Node2D

onready var click_tween = $ClickTween
onready var GodotCN = $MainPanel/she_qu/GodoterCN
onready var Godott = $MainPanel/she_qu/Godott
onready var GodotPro = $MainPanel/she_qu/GodotPro

onready var SheQuButton = $ThirdPartySheQu
onready var SheQuRoot = $MainPanel/she_qu
onready var engine = $engine
onready var GodotDataButton = $GodotDataButton

func _ready():
	GodotCN.connect("gui_input",self,"jump",[GodotCN])
	Godott.connect("gui_input",self,"jump",[Godott])
	GodotPro.connect("gui_input",self,"jump",[GodotPro])
	SheQuButton.connect("pressed",self,"show_shequ")
	engine.connect("pressed",self,"jump_engine")
	GodotDataButton.connect("pressed",self,"show_data")
	$HTTPRequest.connect("request_completed",self,"_on_get_complete")
	connect_left_bar()
	connect_repo_buttons()
	connect_tween()
	pass 
	
func connect_left_bar():
	var leftBarGroup = $EditorManage.group
	var err = leftBarGroup.connect("pressed",self,"_on_left_bar_pressed")
	print_debug(leftBarGroup)
	#print_debug(err)
	pass
	
func _on_left_bar_pressed(button):
	if button.name == "EditorManage":
		hide_shequ()
		$MainPanel/tip_choose.show()
		pass
	if button.name == "ThirdPartySheQu":
		show_shequ()
		$MainPanel/tip_choose.hide()
	print_debug(button)
	pass
func connect_repo_buttons():
	for node in $repo_source.get_children():
		node.connect("pressed",self,"cancel_tip",[node])
	pass
	
func cancel_tip(node):
	#https://api.github.com/repos/godotengine/godot/releases 查询所有发布的版本
	#https://api.github.com/repos/godotengine/godot/releases/latest 查询最新版本
	$MainPanel/tip_choose.hide()
	if node.name == "offical":
		#print_debug("开始请求")
		OS.shell_open("https://godotengine.org/download")
		#$HTTPRequest.request("https://api.github.com/repos/godotengine/godot/releases",[],true,HTTPClient.METHOD_GET)
	if node.name == "itch":
		OS.shell_open("https://godotengine.itch.io/godot")
	if node.name == "github":
		OS.shell_open("https://github.com/godotengine/godot")
	if node.name == "gitee":
		OS.shell_open("https://gitee.com/mirrors/godot")
	if node.name == "tmux":
		OS.shell_open("https://downloads.tuxfamily.org/godotengine")
	if node.name == "GodotSDK":
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
	click_tween.connect("tween_completed",self,"tween_completed")
	pass

func tween_completed(object,key):
	if object.name == "GodoterCN":
		OS.shell_open("https://godoter.cn")
	if object.name == "Godott":
		OS.shell_open("http://godott.com")
	if object.name == "GodotPro":
		OS.shell_open("https://godot.pro/")
	pass
	
#每一个磁贴点击时都会触发
func jump(event,node):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		click_tween.interpolate_property(node, "rect_scale",Vector2(1, 1), Vector2(0.9, 0.9), 0.1,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		click_tween.start()
	if event is InputEventMouseButton and not event.pressed and event.button_index == BUTTON_LEFT:
		click_tween.interpolate_property(node, "rect_scale",Vector2(0.9, 0.9), Vector2(1, 1), 0.1,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		click_tween.start()
		
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


