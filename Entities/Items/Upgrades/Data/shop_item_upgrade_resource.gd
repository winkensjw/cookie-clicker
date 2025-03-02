class_name ShopItemUpgradeResource
extends Resource

@export var upgrade_id : String = ""
@export var upgrade_name : String = ""
@export var icon_texture : Texture2D = null
@export_range(0, 0, 1.0, "or_greater") var count_required : int = 0
@export_range(0, 0, 1.0, "or_greater") var cost : int = 0
@export_range(0, 0, 0.1, "or_greater") var cookies_per_click_flat_added : float = 0.0
@export_range(0, 0, 0.1, "or_greater") var cookies_per_second_multiplier_added : float = 1.0
