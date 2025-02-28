extends Node

func _ready() -> void:
	Events.cookie_clicked.connect(_on_cookie_clicked)
	_update_cookies_per_second();

func _process(delta: float) -> void:
	_apply_cookies_per_second(delta)
	
func _apply_cookies_per_second(delta: float) -> void:
	Globals.cookie_count += Globals.cookies_per_second * delta

func _update_cookies_per_second() -> void:
	pass

func _on_cookie_clicked() -> void:
	Globals.cookie_count += Globals.cookies_per_click
