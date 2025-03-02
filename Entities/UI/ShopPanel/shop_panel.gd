extends PanelContainer

@onready var shop_item_container : VBoxContainer = $VBoxContainer/ShopScrollContainer/ShopItemContainer
@onready var upgrade_grid_container : GridContainer = $VBoxContainer/UpgradeScrollContainer/UpgradeGridContainer


func _ready() -> void:
	Events.cookie_jar_item_added.connect(_on_cookie_jar_item_added)

func _on_cookie_jar_item_added(item : ShopItem) -> void:
	_insert_shop_item(item)
	
func _insert_shop_item(item : ShopItem) -> void:
	shop_item_container.add_child(ShopItemPanel.create(item))
	_insert_upgrade_items(item)

func _insert_upgrade_items(item : ShopItem) -> void:
	for upgrade_item in item.item_upgrades:
		_insert_upgrade_item(upgrade_item)
	
func _insert_upgrade_item(upgrade_item : ShopItemUpgrade) -> void:
	if not upgrade_item.bought:
		upgrade_grid_container.add_child(UpgradeItemPanel.create(upgrade_item))
