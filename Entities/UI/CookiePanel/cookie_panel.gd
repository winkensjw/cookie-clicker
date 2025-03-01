extends PanelContainer

const COOKIE_ROTATION_DIRECTION: float = -0.3 
const ROTATION_SPEED:float = 0.5

@onready var _cookie_button: TextureButton = $CookiePanelVBox/CookieButton
@onready var _cookie_label: Label = %CookiesLabel
@onready var _cookies_per_second_label: Label = %CookiesPerSecondLabel

func _ready() -> void:
	# change pivot to center
	_cookie_button.pivot_offset = _cookie_button.size/2
	
func _process(delta: float) -> void:
	_update_labels()
	_animate_rotate_cookie(delta)

func _update_labels() -> void:
	_cookie_label.text = str(int(Globals.cookie_count)) + " Cookies"
	_cookies_per_second_label.text = "per second: " + str(Globals.cookies_per_second)

func _on_cookie_button_pressed() -> void:
	_animate_cookie_clicked()
	Events.cookie_clicked.emit()
	
func _animate_rotate_cookie(delta: float) -> void:
	_cookie_button.rotation = lerp(_cookie_button.rotation, _cookie_button.rotation + COOKIE_ROTATION_DIRECTION, ROTATION_SPEED * delta)

func _animate_cookie_clicked() -> void:
	var tween = Tweens.create()
	tween.tween_property(_cookie_button, "scale", Vector2(0.8, 0.8), 0.05)
	tween.tween_property(_cookie_button, "scale", Vector2(1, 1), 0.25)
