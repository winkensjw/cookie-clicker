class_name ShopItemUpgrade
extends Node

const SHOP_ITEM_UPGRADE_SCENE : PackedScene = preload("uid://d2r2ml7mj3ayh")

var base_resource : ShopItemUpgradeResource

var upgrade_id : String
var upgrade_name  : String
var icon_texture : Texture2D 
var count_required : int
var cost : int
var cookies_per_click_flat_added : float
var cookies_per_second_multiplier_added : float

var bought : bool = false

static func create(resource : ShopItemUpgradeResource) -> ShopItemUpgrade:
	var instance : ShopItemUpgrade = SHOP_ITEM_UPGRADE_SCENE.instantiate()
	instance.base_resource = resource
	instance.upgrade_id = resource.upgrade_id
	instance.upgrade_name = resource.upgrade_name
	instance.icon_texture = resource.icon_texture
	instance.count_required = resource.count_required
	instance.cost = resource.cost
	instance.cookies_per_click_flat_added = resource.cookies_per_click_flat_added
	instance.cookies_per_second_multiplier_added = resource.cookies_per_second_multiplier_added
	return instance

static func create_all(resources : Array[ShopItemUpgradeResource]) -> Array[ShopItemUpgrade]:
	var result : Array[ShopItemUpgrade] = []
	for resource in resources:
		result.append(ShopItemUpgrade.create(resource))
	return result

func buy() -> void:
	bought = true
	Events.upgrade_bought.emit(cost)
