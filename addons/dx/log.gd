extends Object
class_name Log

const DEFINE = preload("res://addons/dx/dx_define.gd")

enum Level {
	DEBUG = 0,
	INFO,
	WARN,
	ERROR,
	FATAL
}

const COLOR_PALETTE = {
	Level.DEBUG: "green",
	Level.INFO: "white",
	Level.WARN: "yellow",
	Level.ERROR: "red",
	Level.FATAL: "magenta"
}

static var format:String:
	get():
		var fmt = ProjectSettings.get_setting("dx/log/format",DEFINE.DEFAULT_LOG_FORMAT)
		return fmt

static func _make_log(msg:String,args:Array,level:Level = Level.INFO,with_stack:bool=false):
	msg = msg%args
	
	var stack = get_stack() # 获取堆栈
	var caller
	if stack:
		# 网上弹两层才能够拿到真正调用打印的地方
		caller = stack[2]
	else:
		caller = {source = "logger", line = 39}
	var data = {}
	data.color = COLOR_PALETTE[level]
	data.source = caller.source
	data.file = (caller.source as String).get_file()
	data.line = caller.line
	data.time = Time.get_time_string_from_system()
	data.level = Utils.enum_name(level, Level).rpad(5)
	data.msg = msg
	var text = format.format(data)
	
	## 打印堆栈
	if with_stack and stack and len(stack) > 2:
		stack = stack.slice(2)
		var lines = PackedStringArray()
		for index in stack.size():
			var frame = stack[index]
			var tab_s = "└" if index == stack.size() - 1 else "├"
			lines.append(
				"{tab_s} Frame {index} - [url={source}:{line}]{source}:{line}[/url] --> {function}".format({
					tab_s=tab_s, index=index, source=frame.source, line=frame.line, function=frame.function
				})
			)
		var stack_text = "\n".join(lines)
		text += "\n"+stack_text
	
	return text

		
static func debug(msg:String, ...args):
	if not OS.is_debug_build():
		return
	
	var text = _make_log(msg,args,Level.DEBUG,true)
	print_rich(text)

static func info(msg:String, ...args):
	if not OS.is_debug_build():
		return
		
	var text = _make_log(msg,args,Level.INFO)
	print_rich(text)
	
static func warn(msg:String, ...args):
	var text = _make_log(msg,args,Level.WARN,false)
	print_rich(text)
	
static func error(msg:String, ...args):
	var text = _make_log(msg,args,Level.ERROR,false)
	print_rich(text)
	
static func errorx(msg:String, ...args):
	var text = _make_log(msg,args,Level.ERROR,true)
	print_rich(text)
	
static func fatal(msg:String, ...args):
	var text = _make_log(msg,args,Level.FATAL,false)
	print_rich(text)
	
static func fatalx(msg:String, ...args):
	var text = _make_log(msg,args,Level.FATAL,true)
	print_rich(text)
