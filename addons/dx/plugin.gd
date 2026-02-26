@tool
class_name DX
extends EditorPlugin
## XXX: EditorPlugin是创建并添加到编辑器树中的节点。由于游戏运行的时候游戏有自己的场景树
## EditorPlugin是不会添加到游戏场景树中。因此游戏中EditorPlugin是不会执行的。
## 所以如果你的插件的某些功能需要在游戏中执行，一定要设计成AutoLoad。
## EditorPlugin仅仅作为编辑器模式下的入口用来处理编辑器内工具。

func _enable_plugin() -> void:
	# Add autoloads here.
	DXSetting.enable()
	
	
func _disable_plugin() -> void:
	# Remove autoloads here.
	DXSetting.disable()
	
	


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	# 自定义的编辑器工具场景要在这里添加到编辑器树。因为只有这个时候Plugin才入树。
	pass


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	# 自定义的编辑器工具场景要在这里从编辑器树移除
	pass
