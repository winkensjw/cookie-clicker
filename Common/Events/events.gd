extends Node

# Scene Manager
signal load_start(loading_screen : LoadingScreen)
signal scene_added(loaded_scene : Node, loading_screen : LoadingScreen)
signal load_complete(loaded_scene : Node)
signal transition_in_complete
signal scene_finished_loading(scene : Node)
signal scene_invalid(scene_path : String)
signal scene_failed_to_load(scene_path : String)

# Main Menu
signal main_menu_closed

# Cookie Panel
signal cookie_clicked

# Cookie Jar
signal cookie_jar_cookie_count_changed(new_count : float)
signal cookie_jar_cookies_per_second_changed(new_cookies_per_second : float)
signal cookie_jar_item_added(item : ShopItem)

# Shop Panel
signal shop_item_clicked(item : ShopItem)

# Shop Item
signal item_bought(cost : float)
signal upgrade_bought(cost : float)
