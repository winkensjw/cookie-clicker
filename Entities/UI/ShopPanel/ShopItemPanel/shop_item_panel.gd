class_name ShopItemPanel
extends PanelContainer

const SHOP_ITEM_PANEL_SCENE : PackedScene = preload("uid://cki7cb05syyuq")
const ENABLED_COLOR : Color = Color8(22,201,0,255)
const DISABLED_COLOR : Color = Color8(255,22,24,255)

@onready var icon : TextureRect = $HBoxContainer/Icon
@onready var name_label : Label = $HBoxContainer/Container/NameLabel
@onready var cost_label : Label = $HBoxContainer/Container/HBoxContainer/CostLabel
@onready var count_label : Label = $HBoxContainer/CountLabel

var item : ShopItem
var current_state : State
var is_updating : bool = false

enum State {
	ENABLED, 
	DISABLED,
}

static func create(shop_item : ShopItem) -> ShopItemPanel:
	var instance := SHOP_ITEM_PANEL_SCENE.instantiate()
	instance.item = shop_item
	instance.current_state = State.DISABLED
	return instance

func _ready() -> void:
	Events.cookie_jar_cookie_count_changed.connect(_on_cookie_jar_cookie_count_changed)
	_disable()
	_init_item_panel()

func _init_item_panel() -> void:
	name_label.text = item.item_name
	cost_label.text = str(int(item.cost))
	icon.texture = item.icon_texture
	_update_state(0)
	
func _update_state(cookie_count : float) -> void:
	if current_state == State.DISABLED and cookie_count >= item.cost:
		_enable()
	elif current_state == State.ENABLED and cookie_count < item.cost:
		_disable()
	_update_count_label()
	_update_cost_label()

func _enable() -> void:
	current_state = State.ENABLED
	cost_label.add_theme_color_override("font_color", ENABLED_COLOR)

func _disable() -> void:
	current_state = State.DISABLED
	cost_label.add_theme_color_override("font_color", DISABLED_COLOR)
		
func _update_count_label() -> void:
	count_label.text = str(int(item.count))

func _update_cost_label() -> void:
	cost_label.text = str(int(item.cost))

func _on_cookie_jar_cookie_count_changed(new_value : float) -> void:
	_update_state(new_value)
	
func _on_shop_item_panel_button_pressed() -> void:
	if current_state == State.DISABLED:
		return
	item.buy()
	
