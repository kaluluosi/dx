extends RefCounted
class_name Utils

## 返回enum的名字
static func enum_name(enum_value: int, enum_type: Dictionary) -> String:
	return enum_type.keys()[enum_value]

## 就是Glob没错！
## [br]
## 用法1:
## 你可以直接在root_path写通配，但是这种写法你无法适配多种文件类型
## [codeblock]
## Utils.glob("res://assets/**/*.tscn")
## [/codeblock]
## [br]
## 用法2:
## 你可以用include/exclude参数来指定匹配和排除的类型
## [codeblock]
## Utils.glob("res://assets", include: ["*.tscn", "*.png"], exclude: ["*.tres"])
## [/codeblock]
static func glob(root_path: String, include: Array[String]=["*"], exclude: Array[String]=[]):
	return _glob(root_path, include, exclude)

static func _glob(root_path: String, include: Array[String]=["*"], exclude: Array[String]=[], files:=[]):
	
	var root_dir = DirAccess.open(root_path)
	if root_dir:
	
		root_dir.list_dir_begin()
		var file_name = root_dir.get_next()
		while file_name != "":
			if root_dir.current_is_dir():
				files = _glob(root_dir.get_current_dir().path_join(file_name), include, exclude, files)
			else:
				files.append(root_path.path_join(file_name))
			
			file_name = root_dir.get_next()
	else:
		push_error("目录打开失败:%s"%[root_dir])
		return []
	
	# 处理include
	var _n_files = []
	for file in files:
		var success = false
		for inc in include:
			if file. match (inc):
				success = true
				break
		
		for exc in exclude:
			if file. match (exc):
				success = false
				break
				
		if success:
			_n_files.append(file)
	
	return _n_files
