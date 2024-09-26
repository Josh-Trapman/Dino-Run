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
		else:
			print("Passwords don't match")
	else:
		print("Username is already in use")


func load_file():
	var file = FileAccess.open(save_path, FileAccess.READ)
	if file:
		if typeof(file) != 24:
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
				"HighScore" : 0,
				"MostCoinsCollected" : 0,
				"Skins" : {
					"Bluezoid" : true,
					"Leafy" : false,
					"GoldieRaptor" : false,
					"BlazeRex" : false
				},
				"TotalRuns" : 0
			}
		}
		return true
	
	else:
		return false
