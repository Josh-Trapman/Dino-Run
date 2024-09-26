extends Control

@onready var player = get_parent().find_child("game")
@onready var camera = get_parent().find_child("Camera")

var stylebox0 : StyleBoxFlat = load("res://assets/inactive_style_box_flat.tres")
var stylebox1 : StyleBoxFlat = load("res://assets/active_style_box_flat.tres")

var save_path = "user://save.json"
var existing_data : Dictionary
var account : Dictionary = {}

func _on_register_screen_pressed():
	$Login.visible = false
	$Register.visible = true

func _on_login_screen_pressed():
	$Login.visible = true
	$Register.visible = false

func _on_login_pressed():
	load_file()
	var login_validation = check_credentials()
	# Runs the game if the login credentials is true and passes the account info
	if login_validation[0]:
		get_parent().logged_in(login_validation[1])
		# Removes the log in screen
		$Transition.transition()

func load_file():
	var file = FileAccess.open(save_path, FileAccess.READ)
	if file:
		existing_data = JSON.parse_string(file.get_as_text())
		file.close()
		file = null

func check_credentials():
	for key in existing_data.keys():
		var account_data = existing_data[key]
		var credentials = account_data["Credentials"]
		
		# Check if the username matches
		if credentials["Username"] == $Login/Username.text \
		and credentials["Password"] == $Login/Password.text.sha256_text():
			print("Login successful for user: ", credentials["Username"])
			# Return true and the user data (including the index for later use)
			return [true, existing_data[key]]
			
	print("Please ensure that both your Username and Password are entered correctly")
	return [false, null]

