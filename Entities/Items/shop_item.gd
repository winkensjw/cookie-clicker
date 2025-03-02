class_name ShopItem
extends Node

const SHOP_ITEM_SCENE : PackedScene = preload("uid://bs37115j2w1rd")

var base_resource : ShopItemResource

var item_id : String
var item_name  : String
var icon_texture : Texture2D 
var initial_cost : int
var base_cookies_per_second : float
var cost_increase_percent : float
var item_upgrades : Array[ShopItemUpgrade]

var cost : float
var count : int

static func create(resource : ShopItemResource) -> ShopItem:
	var instance : ShopItem = SHOP_ITEM_SCENE.instantiate()
	instance.base_resource = resource
	instance.item_id = resource.item_id
	instance.item_name = resource.item_name
	instance.icon_texture = resource.icon_texture
	instance.initial_cost = resource.initial_cost
	instance.base_cookies_per_second = resource.base_cookies_per_second
	instance.cost_increase_percent = resource.cost_increase_percent
	instance.item_upgrades = ShopItemUpgrade.create_all(resource.item_upgrades)
	instance.update_count(0)
	return instance

func _update_cost() -> void:
	cost = initial_cost * pow(1+ (cost_increase_percent/100.0), count)

func update_count(new_value : int) -> void:
	count = new_value
	_update_cost()

func buy() -> void:
	var current_cost : float = cost
	update_count(count + 1)
	_update_cost()
	Events.item_bought.emit(current_cost)
