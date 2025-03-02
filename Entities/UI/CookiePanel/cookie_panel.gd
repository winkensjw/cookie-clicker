extends PanelContainer

const COOKIE_ROTATION_DIRECTION : float = -0.3 
const ROTATION_SPEED : float = 0.5

@onready var _cookie_texture : TextureRect = $CookiePanelVBox/CookieButtonContainer/CookieTexture
@onready var _cookie_label : Label = %CookiesLabel
@onready var _cookies_per_second_label : Label = %CookiesPerSecondLabel

func _ready() -> void:
	Events.cookie_jar_cookie_count_changed.connect(_on_cookie_jar_cookie_count_changed)
	Events.cookie_jar_cookies_per_second_changed.connect(cookie_jar_cookies_per_second_changed_changed)
	# change pivot to center
	print("before: _cookie_texture.pivot_offset:" + str(_cookie_texture.pivot_offset))
	print("before: _cookie_texture:" + str(_cookie_texture.size))
	_cookie_texture.pivot_offset = _cookie_texture.size/2
	print("after: _cookie_texture.pivot_offset:" + str(_cookie_texture.pivot_offset))
	
func _process(delta: float) -> void:
	_animate_rotate_cookie(delta)

func _on_cookie_jar_cookie_count_changed(new_value : float) -> void:
	_cookie_label.text = str(int(new_value)) + " Cookies"

func cookie_jar_cookies_per_second_changed_changed(new_value: float) -> void:
	_cookies_per_second_label.text = "per second: " + str(new_value)
	
func _on_cookie_button_pressed() -> void:
	_animate_cookie_clicked()
	Events.cookie_clicked.emit()
	
func _animate_rotate_cookie(delta: float) -> void:
	_cookie_texture.rotation = lerp(_cookie_texture.rotation, _cookie_texture.rotation + COOKIE_ROTATION_DIRECTION, ROTATION_SPEED * delta)

func _animate_cookie_clicked() -> void:
	var tween : Tween = Tweens.create()
	tween.tween_property(_cookie_texture, "scale", Vector2(0.8, 0.8), 0.05)
	tween.tween_property(_cookie_texture, "scale", Vector2(1, 1), 0.25)
