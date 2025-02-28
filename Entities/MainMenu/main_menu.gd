extends CanvasLayer
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed():
		close_main_menu()
		
func close_main_menu() -> void:
		Events.main_menu_closed.emit()
