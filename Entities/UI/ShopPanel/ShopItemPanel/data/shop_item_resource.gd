class_name ShopItemResource
extends Resource

@export var item_name : String
@export var icon_texture : Texture2D
@export_range(0, 0, 1.0, "or_greater") var initial_cost : int
@export var base_cookies_per_second : float
@export_range(0.0, 100.0, 0.01) var cost_increase_percent : float

func _init(p_item_name ="", p_icon_texture = null, p_initial_cost = 0, p_base_cookies_per_second = 0, p_cost_increase_percent = 15):
	item_name = p_item_name
	icon_texture = p_icon_texture
	initial_cost = p_initial_cost
	base_cookies_per_second = p_base_cookies_per_second
	cost_increase_percent = p_cost_increase_percent
