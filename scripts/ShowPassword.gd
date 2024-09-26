extends TextureButton

var stylebox0 : StyleBoxFlat = load("res://assets/inactive_style_box_flat.tres")
var stylebox1 : StyleBoxFlat = load("res://assets/active_style_box_flat.tres")

# Changes the visibility of the user's password input
func _on_toggled(toggled_on):
	if toggled_on:
		get_parent().secret = false
	else:
		get_parent().secret = true

# Changes the colour of the panel behind the show password button (Aesthetic only)
func _on_mouse_entered():
	get_parent().find_child("Panel").add_theme_stylebox_override("panel", stylebox1)

func _on_mouse_exited():
	get_parent().find_child("Panel").add_theme_stylebox_override("panel", stylebox0)
