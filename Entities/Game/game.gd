extends Node2D

@onready var cookie_jar : CookieJar = $CookieJar

func _ready() -> void:
	cookie_jar.load_data()
