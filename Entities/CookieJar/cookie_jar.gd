class_name CookieJar
extends Node

var id := "f310524a-1bda-4bc4-86a2-e1d92f861db6"
var version_id := 1.0

# persited
var cookie_count : float = 0.0 
var last_save_unix_time : float = 0
var shop_items : Dictionary = {}

# non-persisted
var cookies_per_click: float = 1.0
var cookies_per_second : float = 0.0
var multiplier: float = 1.0

func _ready() -> void:
	Events.cookie_clicked.connect(_on_cookie_clicked)
	Events.item_bought.connect(_on_item_bought)
	Events.upgrade_bought.connect(_on_upgrade_bought)
	
func _process(delta: float) -> void:
	_apply_cookies_per_second(delta)
	
func _apply_cookies_per_second(delta: float) -> void:
	set_cookie_count(cookie_count + cookies_per_second * delta)

func _on_cookie_clicked() -> void:
	set_cookie_count(cookie_count + cookies_per_click)

func _update_cookies_on_resume() -> void:
	set_cookie_count(cookie_count + cookies_per_second * _get_time_since_last_played_in_seconds())

func set_cookie_count(new_value : float) -> void:
	cookie_count = new_value
	Events.cookie_jar_cookie_count_changed.emit(cookie_count)
	
func _get_time_since_last_played_in_seconds() -> float:
	var lastTime : float = last_save_unix_time
	if lastTime == 0:
		# never saved before
		return 0
	var currentTime : float = Time.get_unix_time_from_system()
	return currentTime - lastTime

func _on_item_bought(cost : float) -> void:
	set_cookie_count(cookie_count - cost)
	_recompute_cookies_per_second()

func _on_upgrade_bought(cost : float) -> void:
	set_cookie_count(cookie_count - cost)
	_recompute_cookies_per_second()

func _recompute_cookies_per_second() -> void:
	var result : float = 0.0
	for shop_item_id : String in shop_items:
		var shop_item : ShopItem = shop_items.get(shop_item_id)
		var flat_cookies_added : float = 0.0
		var mulitplier_added : float = 1.0
		for upgrade_item : ShopItemUpgrade in shop_item.item_upgrades:
			if upgrade_item.bought:
				flat_cookies_added += upgrade_item.cookies_per_click_flat_added
				mulitplier_added += upgrade_item.cookies_per_second_multiplier_added
		result += (shop_item.base_cookies_per_second * shop_item.count * mulitplier_added) + flat_cookies_added
	set_cookies_per_second(result * multiplier)

func set_cookies_per_second(new_value : float) -> void:
	cookies_per_second = new_value
	Events.cookie_jar_cookies_per_second_changed.emit(cookies_per_second)
	
######################
# Savind and Loading #
######################

func get_save_id() -> String:
	return id

func save_data() -> Dictionary:
	return {
		"version_id": version_id,
		"cookie_count": cookie_count,
		"last_save_unix_time": Time.get_unix_time_from_system(),
		"shop_items": _save_shop_items()
	}

func load_data() -> void:
	var data : Dictionary = SaveManager.get_data(get_save_id())
	cookie_count = data.get("cookie_count",0.0)
	last_save_unix_time = data.get("last_save_unix_time",0.0)
	_load_shop_items(data)
	_recompute_cookies_per_second()
	_update_cookies_on_resume()

func _load_shop_items(data : Dictionary) -> void:
	var shop_item_save_data : Dictionary = data.get("shop_items", {})
	for shop_item_resource_path : String in Constants.SHOP_ITEM_RESOURCES:
		var shop_item_resource : ShopItemResource = load(shop_item_resource_path)
		var shop_item : ShopItem = _load_shop_item(shop_item_resource, shop_item_save_data)
		if not shop_items.has(shop_item.item_id):
			shop_items[shop_item.item_id] = shop_item
			Events.cookie_jar_item_added.emit(shop_item)
		
func _load_shop_item(shop_item_resource : ShopItemResource, data : Dictionary) -> ShopItem:
	var shop_item : ShopItem = ShopItem.create(shop_item_resource)
	var shop_item_save_data : Dictionary = data.get(shop_item.item_id, {})
	shop_item.update_count(shop_item_save_data.get("count", shop_item.count))
	_load_shop_item_upgrades(shop_item, shop_item_save_data)
	return shop_item

func _load_shop_item_upgrades(shop_item : ShopItem, data : Dictionary) -> void:
	var upgrade_datas : Dictionary = data.get("item_upgrades", {})
	for upgrade : ShopItemUpgrade in shop_item.item_upgrades:
		var upgrade_data : Dictionary = upgrade_datas.get(upgrade.upgrade_id, {})
		upgrade.bought = upgrade_data.get("bought", false)
	
func _save_shop_items() -> Dictionary:
	var data : Dictionary = {}
	for shop_item_id : String in shop_items:
		var shop_item : ShopItem = shop_items.get(shop_item_id)
		var shop_item_data : Dictionary = _save_shop_item(shop_item)
		data[shop_item.item_id] = shop_item_data
	return data

func _save_shop_item(shop_item : ShopItem) -> Dictionary:
	return {
		"count": shop_item.count,
		"item_upgrades": _save_shop_item_upgrades(shop_item)
	}

func _save_shop_item_upgrades(shop_item : ShopItem) -> Dictionary:
	var data : Dictionary = {}
	for shop_item_upgrade : ShopItemUpgrade in shop_item.item_upgrades:
		var shop_item_upgrade_data : Dictionary = _save_shop_item_upgrade(shop_item_upgrade)
		data[shop_item_upgrade.upgrade_id] = shop_item_upgrade_data
	return data

func _save_shop_item_upgrade(shop_item_upgrade : ShopItemUpgrade) -> Dictionary:
	return {
		"bought": shop_item_upgrade.bought
	}
