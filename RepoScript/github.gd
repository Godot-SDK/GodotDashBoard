class_name GitHubRepo
const base_url = "https://github.com/godotengine/godot/releases"
const repo_info = "github镜像源"
var aar_url = {
	"3.2.3" : "https://github.com/godotengine/godot/releases/download/3.2.3-stable/godot-lib.3.2.3.stable.release.aar",
	"3.3" : "https://github.com/godotengine/godot/releases/download/3.3-stable/godot-lib.3.3.stable.release.aar",
	"3.4.4" : "https://github.com/godotengine/godot/releases/download/3.4.4-stable/godot-lib.3.4.4.stable.release.aar"
}
var editor_url = {
	"3.2.3":
		{
			"32bit" : "https://github.com/godotengine/godot/releases/download/3.2.3-stable/Godot_v3.2.3-stable_win32.exe.zip",
			"64bit" :  "https://github.com/godotengine/godot/releases/download/3.2.3-stable/Godot_v3.2.3-stable_win64.exe.zip"
		},
	"3.3.3":
		{
			"32bit" : "https://github.com/godotengine/godot/releases/download/3.3.3-stable/Godot_v3.3.3-stable_win32.exe.zip",
			"64bit" :  "https://github.com/godotengine/godot/releases/download/3.3.3-stable/Godot_v3.3.3-stable_win64.exe.zip"
		},
	"3.4.4":
		{
			"32bit" : "https://github.com/godotengine/godot/releases/download/3.4.4-stable/Godot_v3.4.4-stable_win32.exe.zip",
			"64bit" :  "https://github.com/godotengine/godot/releases/download/3.4.4-stable/Godot_v3.4.4-stable_win64.exe.zip"
		}
}
