extends PanelContainer

@onready var shop_item_container : VBoxContainer = $VBoxContainer/ShopScrollContainer/ShopItemContainer
@onready var upgrade_grid_container : GridContainer = $VBoxContainer/UpgradeScrollContainer/UpgradeGridContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	upgrade_grid_container.add_child(UpgradeItemPanel.create())
	shop_item_container.add_child(ShopItemPanel.create())
