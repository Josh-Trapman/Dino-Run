extends Control

@onready var buttons = get_parent().find_child("Buttons")
@onready var main = owner.owner

func _on_volume_value_changed(value : float):
	AudioServer.set_bus_volume_db(0, linear_to_db(value))

func _on_back_pressed():
	visible = false
	buttons.visible = true
	main.game_instance.can_click = true
	
