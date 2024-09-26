extends Node2D

@onready var logged_in_player = get_parent().player_data
@onready var menu_screens = get_parent().find_child("Menu")


# Node start positions
const PLAYER_START_POS := Vector2i(145, 322)
const CAM_START_POS := Vector2i(360, 200)
const GROUND_START_POS := Vector2i(720, 364)
const CEILING_START_POS := Vector2i(720, 0)

# Save path
var save_path = "user://save.dat"

# Game variables
const START_SPEED : float = 250.0
const MAX_SPEED : int = 750
const SPEED_MODIFIER : int = 100
var speed : float
const SCORE_MODIFIER : int = 3
var score : int
var screen_size : Vector2i
var game_running : bool = false
var coins_collected : int
var total_coins : int
var already_spawned : bool = false
var high_score : int
var can_click : bool = true

func _ready():
	screen_size = get_window().size

func new_game():
	load_data()
	get_tree().paused = false
	
	menu_screens.find_child("Main").visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Player.visible = true
	$HUD/HighScore.text = "Best:" + str(high_score) + "m"
	
	# Reset variables
	score = 0
	speed = 0
	coins_collected = 0
	game_running = false
	
	# Reset the nodes
	$Player.position = PLAYER_START_POS
	$Player.velocity = Vector2i(0, 0)
	$Camera.position = CAM_START_POS
	$Ground.position = GROUND_START_POS
	$Ceiling.position = CEILING_START_POS
	$HUD/Score.text = str(score).pad_zeros(4) + "m"
	$Player/Dino.speed_scale = 1
	$Player/Wings.speed_scale = 1
	show_coins()
	
func _process(delta):
	if game_running:
		# Increases and limits the speed
		if speed < MAX_SPEED:
			speed = START_SPEED + score / SPEED_MODIFIER
		
		# Increases the animation speed when running
		if $Player/Dino.animation == "Run":
			$Player/Dino.speed_scale = speed / 100
			$Player/Wings.speed_scale = speed / 100
		# Otherwise sets the speed scale to 1
		else:
			$Player/Dino.speed_scale = 1
			$Player/Wings.speed_scale = 1
		
		# Move player and camera
		$Player.position.x += speed * delta
		$Camera.position.x += speed * delta
		
		# Move ground
		if $Camera.position.x - $Ground.position.x > screen_size.x * 0.5:
			$Ground.position.x += screen_size.x
			$Ceiling.position.x += screen_size.x
		
		if Input.is_action_just_pressed("Pause") :
			menu_screens.find_child("Pause").just_paused(total_coins + coins_collected)
		
		score = $Player.position.x * SCORE_MODIFIER
		show_score()
		spawn_items()
		
	# Waits for the user to press space then runs the game
	else:
		$HUD.visible = false
		
		if Input.is_action_just_pressed("Space") and can_click:
			game_running = true
			$HUD.visible = true
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			menu_screens.find_child("Main").start_game()

# Updates the score label
func show_score():
	$HUD/Score.text = str(score).left(-2).pad_zeros(4) + "m"

# Updates the coins and the coin label
func show_coins():
	$HUD/Coins.text = str(coins_collected).pad_zeros(3)
	if len(str(coins_collected)) > 3:
		$HUD/Coins/CoinIcon.position.x = 42 + 16.25 * (len(str(coins_collected)) - 3)

# Randomly spawns an obstacle or coin pattern when the player's score is a multiple of 50
func spawn_items():
	# Spawns something every 50 metres
	if (score / 100) % 50 == 0:
		# Checks if something has already been spawned so nothing overlaps
		if not already_spawned:
			# Gets a random integer 
			var coin_or_obstacle = randi_range(1,3)
			# Spawns a random coin pattern 
			if coin_or_obstacle == 1:
				var pattern = randi_range(1, 2)
				$Coin_Patterns.place_pattern(pattern, $Player.position.x, [screen_size.x, screen_size.y])
			# Spawns a random obstacle
			else:
				$Obstacles.spawn()
			# Stops trying to spawn anything until the player's x coordinate is outside the spawning range
			already_spawned = true
	else:
		already_spawned = false

# After logging in this updates loads any info associated with the account
func load_data():
	high_score = logged_in_player["UserData"]["HighScore"]
	total_coins = logged_in_player["UserData"]["Coins"]

func update_data():
	total_coins += coins_collected
	logged_in_player["UserData"]["Coins"] = total_coins
	
	if int(str(score).left(-2)) > logged_in_player["UserData"]["HighScore"]:
		logged_in_player["UserData"]["HighScore"] = int(str(score).left(-2))
	high_score = logged_in_player["UserData"]["HighScore"]
	
	save_data()

# Opens the save file, converts data into a JSON string then finds the end of the file and saves the data
func save_data():
	var file = FileAccess.open(save_path, FileAccess.READ_WRITE)
	var accounts = []
	var temp_accounts = []
	
	while not file.eof_reached():
		temp_accounts.append(JSON.parse_string(file.get_line()))
	
	for account in temp_accounts:
		if typeof(account) == 27 \
		and not accounts.has(account):
			accounts.append(account)
	
	file.close()
		
	file = FileAccess.open(save_path, FileAccess.WRITE)
	
	for index in accounts.size():
		if index == logged_in_player["Index"]:
			file.store_line(JSON.stringify(logged_in_player))
		else:
			file.store_line(JSON.stringify(accounts[index]))
	file.close()
