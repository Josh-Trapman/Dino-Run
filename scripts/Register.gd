extends Control

var stylebox0 : StyleBoxFlat = load("res://assets/inactive_style_box_flat.tres")
var stylebox1 : StyleBoxFlat = load("res://assets/active_style_box_flat.tres")

var save_path = "user://save.json"
var max_index = -1
var existing_data : Dictionary

func _on_register_pressed():
	load_file()
	var username_available = check_username_available()
	
	if username_available:
		var passwords_match = create_account()
		if passwords_match:
			# Writes all of the accounts back into the file, including the newly created account
			var file = FileAccess.open(save_path, FileAccess.WRITE)
			file.store_string(JSON.stringify(existing_data))
			# Closes the file to free up memory
			file.close()
			file = null
			$Username.text = ""
			$Password.text = ""
			$ConfirmPassword.text = ""
			return await update_error_label("Account registered", Color("00ff00"))
		else:
			return await update_error_label("Passwords must match", Color("ff0000"))
	else:
		return await update_error_label("Username is already in use", Color("ff0000"))


func load_file():
	var file = FileAccess.open(save_path, FileAccess.READ)
	if file:
		if typeof(file) != 0:
			if JSON.parse_string(file.get_as_text()) == null:
				file.close()
				file = FileAccess.open(save_path, FileAccess.WRITE)
				file.store_string(JSON.stringify({}))
				file.close()
				file = null
			else:
				existing_data = JSON.parse_string(file.get_as_text())
				file.close()
				file = null
		else:
			file.close()
			file = FileAccess.open(save_path, FileAccess.WRITE)
			file.store_string(JSON.stringify({}))
			file.close()
			file = null
	else:
		file = FileAccess.open(save_path, FileAccess.WRITE)
		file.store_string(JSON.stringify({}))
		file.close()
		file = null


func check_username_available():
	for key in existing_data.keys():
		var account_data = existing_data[key]
		var credentials = account_data["Credentials"]
		
		# Check if the username matches
		if credentials["Username"] == $Username.text:
			return false
	return true


func create_account():
	for key in existing_data.keys():
		if max_index < int(key):
			max_index = int(key)
	
	if $Password.text.sha256_text() == $ConfirmPassword.text.sha256_text() \
	and not $ConfirmPassword.text.is_empty() \
	and not $Username.text.is_empty():
		existing_data[str(max_index + 1)] = {
			"Credentials" : {
				"Username" : $Username.text,
				"Password" : $ConfirmPassword.text.sha256_text()
			},
			"UserData" : {
				"AllTimeCoinsCollected" : 0,
				"AllTimeDistance" : 0,
				"Coins" : 0,
				"EquippedSkin" : "Bluezoid",
				"HighScore" : 0,
				"MostCoinsCollected" : 0,
				"Skins" : {
					"Bluezoid" : true,
					"LeafRex" : false,
					"BlazeRex" : false
				},
				"TotalRuns" : 0
			}
		}
		return true
	else:
		return false


func update_error_label(message : String, colour):
 # Display error message
	$ErrorLabel.text = message
	$ErrorLabel["theme_override_colors/font_color"] = Color(colour)
	# Clear the error message after 2 seconds
	await get_tree().create_timer(2).timeout
	$ErrorLabel.text = ""
