class_name UpgradeItemPanel
extends TextureRect

const UPGRADE_ITEM_PANEL_SCENE : PackedScene = preload("uid://x0yj4jndodam")

enum State {
	ENABLED, 
	DISABLED,
}

var cost = 1000
var current_state

static func create() -> ShopItemPanel:
	return UPGRADE_ITEM_PANEL_SCENE.instantiate()

func _ready() -> void:
	_disable()

func _process(_delta: float) -> void:
	if current_state == State.DISABLED and Globals.cookie_count >= cost:
		_enable()
	elif current_state == State.ENABLED and Globals.cookie_count < cost:
		_disable()

func _enable() -> void:
	current_state = State.ENABLED

func _disable() -> void:
	current_state = State.DISABLED
