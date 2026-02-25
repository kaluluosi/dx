extends Node

enum UILayer{
	MAIN,
	POPUP,
	TOP
}

@onready var _layers: Dictionary = {
	UILayer.MAIN:$CL_Main,
	UILayer.POPUP:$CL_Popup,
	UILayer.TOP:$CL_Top
}

## UI实例
var _ui_instances:Dictionary = {}



func open_ui(ui_tscn_path:String):
	# TODO: 打开界面
	pass

func close_ui(ui_tscn_path:String):
	# TODO: 关闭界面
	pass