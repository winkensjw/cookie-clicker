class_name UpgradeItemPanel
extends TextureRect

const UPGRADE_ITEM_PANEL_SCENE : PackedScene = preload("uid://x0yj4jndodam")
const ENABLED_COLOR : Color = Color8(22,201,0,255)
const DISABLED_COLOR : Color = Color8(255,22,24,255)

@onready var tooltip : PanelContainer = $Tooltip
@onready var name_label : Label = $Tooltip/VBoxContainer/NameLabel
@onready var cost_label : Label = $Tooltip/VBoxContainer/CostLabel

var upgrade : ShopItemUpgrade
var current_state : State

enum State {
	ENABLED, 
	DISABLED,
}

static func create(item_upgrade : ShopItemUpgrade) -> ShopItemPanel:
	var instance := UPGRADE_ITEM_PANEL_SCENE.instantiate()
	instance.upgrade = item_upgrade
	instance.current_state = State.DISABLED
	return instance

func _ready() -> void:
	Events.cookie_jar_cookie_count_changed.connect(_on_cookie_jar_cookie_count_changed)
	_disable()
	_init_upgrade_panel()

func _init_upgrade_panel() -> void:
	name_label.text = upgrade.upgrade_name
	cost_label.text = str(int(upgrade.cost))
	texture = upgrade.icon_texture
	_update_state(0)

func _update_state(cookie_count : float) -> void:
	if current_state == State.DISABLED and cookie_count >= upgrade.cost:
		_enable()
	elif current_state == State.ENABLED and cookie_count < upgrade.cost:
		_disable()

func _enable() -> void:
	current_state = State.ENABLED
	cost_label.add_theme_color_override("font_color", ENABLED_COLOR)

func _disable() -> void:
	current_state = State.DISABLED
	cost_label.add_theme_color_override("font_color", DISABLED_COLOR)
	
func _on_cookie_jar_cookie_count_changed(new_value : float) -> void:
	_update_state(new_value)
	
func _on_button_pressed() -> void:
	upgrade.buy()
	queue_free()

func _on_button_mouse_entered() -> void:
	tooltip.show()

func _on_button_mouse_exited() -> void:
	tooltip.hide()
