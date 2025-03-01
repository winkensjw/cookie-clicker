extends Node

var cookie_count : float = 0.0
var cookies_per_click: float = 1.0
var cookies_per_second : float = 0.0
var last_save_unix_time : float = 0

var item_count: Dictionary = {}

func _ready() -> void:
	load_data()
	
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_data()

func save_data() -> void:
	SaveManager.save_data(_export_data())

func load_data() -> void:
	_import_data(SaveManager.load_data())

func _export_data() -> Dictionary:
	return {
		"cookie_count": cookie_count,
		"last_save_unix_time": Time.get_unix_time_from_system(),
		"item_count": item_count
	}
	
func _import_data(data : Dictionary) -> void:
	if data.is_empty():
		return
	cookie_count = data.get("cookie_count",0.0)
	last_save_unix_time = data.get("last_save_unix_time",0.0)
	item_count = data.get("item_count", {})

func increase_item_count(item_name:String, value:int=1):
	var new_count = item_count.get(item_name, 0) + value
	item_count[item_name] = new_count
