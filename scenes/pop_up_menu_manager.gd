extends MarginContainer

@export var menu_screen: VBoxContainer
@export var open_menu_screen: VBoxContainer
@export var help_menu_screen: MarginContainer
func toggle_visibility (object):
	if object.visible:
		object.visible = false
	else:
		object.visible = true

func _on_toggle_menu_button_pressed() -> void:
	toggle_visibility(menu_screen)
	toggle_visibility(open_menu_screen)
	


func _on_toggle_help_menu_button_pressed() -> void:
	toggle_visibility(help_menu_screen)
