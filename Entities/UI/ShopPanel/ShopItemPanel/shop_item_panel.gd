class_name ShopItemPanel
extends PanelContainer

const SHOP_ITEM_PANEL_SCENE : PackedScene = preload("uid://cki7cb05syyuq")

enum State {
	ENABLED, 
	DISABLED,
}

const ENABLED_COLOR : Color = Color8(22,201,0,255)
const DISABLED_COLOR : Color = Color8(255,22,24,255)

var cost = 1000
var current_state

@onready var icon : TextureRect = $HBoxContainer/Icon
@onready var nameLabel : Label = $HBoxContainer/Container/NameLabel
@onready var costLabel : Label = $HBoxContainer/Container/HBoxContainer/CostLabel
@onready var countLabel : Label = $HBoxContainer/CountLabel

static func create() -> ShopItemPanel:
	return SHOP_ITEM_PANEL_SCENE.instantiate()

func _ready() -> void:
	_disable()

func _process(_delta: float) -> void:
	if current_state == State.DISABLED and Globals.cookie_count >= cost:
		_enable()
	elif current_state == State.ENABLED and Globals.cookie_count < cost:
		_disable()
	
	_updateCount()
	_updateCost()

func _enable() -> void:
	current_state = State.ENABLED
	costLabel.label_settings.font_color = ENABLED_COLOR

func _disable() -> void:
	current_state = State.DISABLED
	costLabel.label_settings.font_color = DISABLED_COLOR

func _updateCount() -> void:
	# FIXME
	countLabel.text = "0"

func _updateCost() -> void:
	# FIXME
	costLabel.text = str(cost)
