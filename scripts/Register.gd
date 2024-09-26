extends Control

@onready var file = get_parent()

var stylebox0 : StyleBoxFlat = load("res://assets/inactive_style_box_flat.tres")
var stylebox1 : StyleBoxFlat = load("res://assets/active_style_box_flat.tres")

var save_path = "user://save.dat"
var max_index = 0
var accounts = []

func _on_register_pressed():
	var new_account = create_account()
	if new_account[0]:
		file.seek_end()
		file.store_line("")
		file.store_line(JSON.stringify(new_account[1]))
		file = FileAccess.open(save_path, FileAccess.READ_WRITE)
	elif len(new_account) == 2 and typeof(new_account[1]) == 2 and new_account[1] == 0:
		print("Please fill in all fields")

	elif len(new_account) == 2 and typeof(new_account[1]) == 2 and new_account[1] == 1:
		print("passwords dont match")

	else:
		print("account exists")


func create_account():
	for account in accounts:
		if typeof(account) == 27:
			if max_index < account["Index"]:
				max_index = account["Index"]
			if $Register/Username.text == account["Username"]:
				return [false]
			
	if $Register/Password.text.sha256_text() == $Register/ConfirmPassword.text.sha256_text() \
	and not $Register/ConfirmPassword.text.is_empty() \
	and not $Register/Username.text.is_empty():
		var new_account = {
			"Index" : max_index + 1,
			"UserData" : {
				"Coins" : 0,
				"HighScore" : 0,
				"Password" : $Register/ConfirmPassword.text.sha256_text(),
				"Skins" : {
					"Blue" : true,
					"Red" : false}},
			"Username" : $Register/Username.text}
		accounts.append(new_account)
		return [true, new_account]
	
	elif $Register/ConfirmPassword.text.is_empty() \
	or $Register/Password.text.is_empty() \
	or $Register/Username.text.is_empty():
		return [false, 0]
	else:
		return [false, 1]
