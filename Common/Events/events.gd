extends Node

# Scene Manager
signal load_start(loading_screen)
signal scene_added(loaded_scene:Node,loading_screen)
signal load_complete(loaded_scene:Node)
signal transition_in_complete
signal scene_finished_loading(scene)
signal scene_invalid(scene_path:String)
signal scene_failed_to_load(scene_path:String)

# Main Menu
signal main_menu_closed

# Cookie Panel
signal cookie_clicked

# Shop Panel
signal item_bought(item_name : String)
signal upgrade_bought
