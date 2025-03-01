class_name ShopItemPanel
extends PanelContainer

const SHOP_ITEM_PANEL_SCENE : PackedScene = preload("uid://cki7cb05syyuq")

enum State {
	ENABLED, 
	DISABLED,
}

const ENABLED_COLOR : Color = Color8(22,201,0,255)
const DISABLED_COLOR : Color = Color8(255,22,24,255)

var base_resource : ShopItemResource

var item_name
var cost
var count
var current_state

var is_updating : bool = false

@onready var icon : TextureRect = $HBoxContainer/Icon
@onready var name_label : Label = $HBoxContainer/Container/NameLabel
@onready var cost_label : Label = $HBoxContainer/Container/HBoxContainer/CostLabel
@onready var count_label : Label = $HBoxContainer/CountLabel

static func create(resource : ShopItemResource) -> ShopItemPanel:
	var instance := SHOP_ITEM_PANEL_SCENE.instantiate()
	instance.base_resource = resource
	return instance

func _ready() -> void:
	_disable()
	_init_item_panel()

func _init_item_panel() -> void:
	item_name = base_resource.item_name
	name_label.text = item_name
	icon.texture = base_resource.icon_texture
	_recompute_values()
	
func _process(_delta: float) -> void:
	if current_state == State.DISABLED and Globals.cookie_count >= cost:
		_enable()
	elif current_state == State.ENABLED and Globals.cookie_count < cost:
		_disable()

func _enable() -> void:
	current_state = State.ENABLED
	cost_label.add_theme_color_override("font_color", ENABLED_COLOR)

func _disable() -> void:
	current_state = State.DISABLED
	cost_label.add_theme_color_override("font_color", DISABLED_COLOR)

func _update_count_label() -> void:
	count_label.text = str(int(Globals.item_count.get(item_name, 0)))

func _update_cost_label() -> void:
	cost_label.text = str(int(cost))

func _recompute_values() -> void:
	_recompute_count()
	_recompute_cost()
	
func _recompute_count() -> void:
	count = Globals.item_count.get(item_name, 0)
	_update_count_label()

func _recompute_cost() -> void:
	cost = base_resource.initial_cost * pow(1+ (base_resource.cost_increase_percent/100.0), count)
	_update_cost_label()
	
func _on_shop_item_panel_button_pressed() -> void:
	if current_state == State.DISABLED or is_updating:
		return
	is_updating = true
	Globals.increase_item_count(item_name, 1)
	_recompute_count()
	_recompute_cost()
	is_updating = false
	Events.item_bought.emit(item_name)
