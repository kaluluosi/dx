extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Log.debug("Log debug")
	Log.info("Log info")
	Log.error("Log error")
	Log.warn("Log warn")
	Log.fatal("Log fatal")
	
