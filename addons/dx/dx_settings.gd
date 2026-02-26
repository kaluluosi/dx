extends RefCounted
class_name DXSetting

const DEFINE = preload("res://addons/dx/dx_define.gd")

static var _settings:Dictionary

static var log_format:String:
	get():
		return ProjectSettings.get_setting(DEFINE.SETTING_LOG_FORMAT,DEFINE.DEFAULT_LOG_FORMAT)

static func enable():
	# 在这里注册项目设置
	register_setting(DEFINE.SETTING_LOG_FORMAT,DEFINE.DEFAULT_LOG_FORMAT,TYPE_STRING,PROPERTY_HINT_EXPRESSION,"",true)
	
static func disable():
	cleanup()
	
static func cleanup():	
	for _name in _settings:
		if ProjectSettings.has_setting(_name):
			ProjectSettings.clear(_name)
			Log.info("移除项目设置：%s",_name)
	_settings.clear()
	ProjectSettings.save()
	
static func register_setting(name:String,default_value,type:Variant.Type,hint:PropertyHint,hint_string:String="",basic:bool=true):
	Log.info("注册项目设置：%s",name)
	_settings[name] = true
	var p_info = {
		name=name,
		type=type,
		hint=hint,
		hint_string=hint_string
	}
	
	ProjectSettings.set_setting(name,default_value)
	ProjectSettings.add_property_info(p_info)
	
	ProjectSettings.set_initial_value(name,default_value)
	# 基本设置（如果为false则是高级设置）
	ProjectSettings.set_as_basic(name,basic)
	
	
