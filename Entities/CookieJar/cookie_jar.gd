extends Node

func _ready() -> void:
	Events.cookie_clicked.connect(_on_cookie_clicked)
	Events.item_bought.connect(_on_item_bought)
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

func _on_item_bought(item_name : String) -> void:
	_recompute_cookies_per_second()

func _recompute_cookies_per_second() -> void:
	var cookies_per_second = 0.0
	for shop_item_resource in Constants.SHOP_ITEM_RESOURCES:
		var shop_item : ShopItemResource = load(shop_item_resource)
		var item_count = Globals.item_count.get(shop_item.item_name, 0.0)
		cookies_per_second += shop_item.base_cookies_per_second * item_count
	Globals.cookies_per_second = cookies_per_second
