class_name UpgradeItemPanel
extends TextureRect

const UPGRADE_ITEM_PANEL_SCENE : PackedScene = preload("uid://x0yj4jndodam")

const ENABLED_COLOR : Color = Color8(22,201,0,255)
const DISABLED_COLOR : Color = Color8(255,22,24,255)

@onready var tooltip : PanelContainer = $Tooltip
@onready var name_label : Label = $Tooltip/VBoxContainer/NameLabel
@onready var cost_label : Label = $Tooltip/VBoxContainer/CostLabel

var base_resource : UpgradeItemResource

enum State {
	ENABLED, 
	DISABLED,
}

var upgrade_name
var cost
var multiplier
var current_state
var is_updating : bool = false

static func create(resource : UpgradeItemResource) -> ShopItemPanel:
	var instance := UPGRADE_ITEM_PANEL_SCENE.instantiate()
	instance.base_resource = resource
	return instance

func _ready() -> void:
	_disable()
	_init_upgrade_panel()

func _init_upgrade_panel() -> void:
	upgrade_name = base_resource.upgrade_name
	cost = base_resource.cost
	multiplier = base_resource.multiplier
	name_label.text = upgrade_name
	cost_label.text = "Cost: " + str(int(cost))
	texture = base_resource.icon_texture
	
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

func _on_button_pressed() -> void:
	if current_state == State.DISABLED or is_updating:
		return
	is_updating = true
	Globals.upgrade_bought(upgrade_name, multiplier)
	is_updating = false
	Events.upgrade_bought.emit()
	queue_free()


func _on_button_mouse_entered() -> void:
	tooltip.show()


func _on_button_mouse_exited() -> void:
	tooltip.hide()
