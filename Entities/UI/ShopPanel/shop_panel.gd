extends PanelContainer

@onready var shop_item_container : VBoxContainer = $VBoxContainer/ShopScrollContainer/ShopItemContainer
@onready var upgrade_grid_container : GridContainer = $VBoxContainer/UpgradeScrollContainer/UpgradeGridContainer


func _ready() -> void:
	Constants.UPGRADE_ITEM_RESOURCES.all(_insert_upgrade_item)
	Constants.SHOP_ITEM_RESOURCES.all(_insert_shop_item)

func _insert_upgrade_item(resource_path : String) -> bool:
	var upgrade_item : UpgradeItemResource = load(resource_path)
	if Globals.bought_upgrades.has(upgrade_item.upgrade_name):
		Events.upgrade_bought.emit(upgrade_item.upgrade_name, upgrade_item.multiplier)
		return false
	upgrade_grid_container.add_child(UpgradeItemPanel.create(upgrade_item))
	return true;
	
func _insert_shop_item(resource_path : String) -> bool:
	var shop_item : ShopItemResource = load(resource_path)
	shop_item_container.add_child(ShopItemPanel.create(shop_item))
	return true;
