extends Node

func _ready() -> void:
	Events.cookie_clicked.connect(_on_cookie_clicked)
	_update_cookies_on_resume()

func _process(delta: float) -> void:
	_apply_cookies_per_second(delta)
	
func _apply_cookies_per_second(delta: float) -> void:
	Globals.cookie_count += Globals.cookies_per_second * delta

func _on_cookie_clicked() -> void:
	Globals.cookie_count += Globals.cookies_per_click

func _update_cookies_on_resume() -> void:
	Globals.cookie_count += Globals.cookies_per_second * _get_time_since_last_played_in_seconds()

func _get_time_since_last_played_in_seconds() -> int:
	var lastTime = Globals.last_save_unix_time
	if lastTime == 0:
		# never saved before
		return 0
	var currentTime = Time.get_unix_time_from_system()
	return currentTime - lastTime
