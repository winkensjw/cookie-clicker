extends PanelContainer

@onready var cookieTexture = $CookiePanelVBox/CookieButton/TextureRect


func _on_cookie_button_pressed() -> void:
	Events.cookie_clicked.emit()
