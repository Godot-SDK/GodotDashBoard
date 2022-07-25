extends HBoxContainer

func _ready():
	pass 
	
func _on_Menu_changed(id,editor_path:String):
	#print_debug(id)
	var item = $MenuButton.get_popup().get_item_text(id)
	if item == "打开所在文件夹":
		OS.shell_open(Global.editor_dir)
	if item == "重新下载":
		#必须先卸载，才能重新安装
		uninstall(editor_path)
		print_debug("此功能未完全实现，请使用编辑器下载功能再次下载")
#		print_debug("开始下载！")
#		print_debug(url)
#		var output = []
#		OS.execute(Global.exe_dir + "/downloader.exe",["aar",url],false,output)
#		print_debug(output)
		pass
	if item == "卸载":
		uninstall(editor_path)
		pass
	#print_debug(item)
	pass
func uninstall(p_editor):
	var dir = Directory.new()
	var err = dir.remove(p_editor)
	if err != OK:
		printerr("卸载出错！")
	print_debug(p_editor,"卸载完成")
	pass

