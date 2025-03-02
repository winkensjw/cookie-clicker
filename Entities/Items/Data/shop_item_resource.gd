class_name ShopItemResource
extends Resource

@export var item_id : String = ""
@export var item_name : String = ""
@export var icon_texture : Texture2D = null 
@export_range(0, 0, 1.0, "or_greater") var initial_cost : int = 0
@export var base_cookies_per_second : float = 0.0
@export_range(0.0, 100.0, 0.01) var cost_increase_percent : float = 15.0
