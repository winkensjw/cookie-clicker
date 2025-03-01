class_name UpgradeItemResource
extends Resource

@export var upgrade_name : String
@export var icon_texture : Texture2D
@export_range(0, 0, 1.0, "or_greater") var cost : int
@export var multiplier : float

func _init(p_upgrade_name ="", p_icon_texture = null, p_cost = 0, p_multiplier = 0):
	upgrade_name = p_upgrade_name
	icon_texture = p_icon_texture
	cost = p_cost
	multiplier = p_multiplier
