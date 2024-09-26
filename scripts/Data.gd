extends Control

@onready var player = get_parent().find_child("game")
@onready var camera = get_parent().find_child("Camera")

var stylebox0 : StyleBoxFlat = load("res://assets/inactive_style_box_flat.tres")
var stylebox1 : StyleBoxFlat = load("res://assets/active_style_box_flat.tres")

var save_path = "user://save.dat"
var accounts = []
var data = []

func _ready():
	data = load_file()

func load_file():
	var file = FileAccess.open(save_path, FileAccess.READ_WRITE)
	while not file.eof_reached():
		var line = file.get_line()
		if line != "null":
			accounts.append(JSON.parse_string(line))
	return [accounts, file]

func _on_register_screen_pressed():
	$Login.visible = false
	$Register.visible = true

func _on_login_screen_pressed():
	$Login.visible = true
	$Register.visible = false

func _on_login_pressed():
	var login_credentials = check_credentials()
	# Runs the game if the login credentials is true and passes the account info
	if login_credentials[0]:
		get_parent().logged_in(login_credentials[1])
		# Closes the file
		data[1].close()
		# Removes the log in screen
		$Transition.transition()

func check_credentials():
	for account in accounts:
		if typeof(account) == 27 \
		and not $Login/Username.text.is_empty() \
		and $Login/Username.text == account["Username"] \
		and $Login/Password.text.sha256_text() == account["UserData"]["Password"]:
			return [true, account]
	return [false]

