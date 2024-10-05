extends Node2D

@onready var menu_screens = get_parent().find_child("Menu")

# Node start positions
const PLAYER_START_POS := Vector2i(145, 322)
const CAM_START_POS := Vector2i(360, 200)
const GROUND_START_POS := Vector2i(720, 364)
const CEILING_START_POS := Vector2i(720, 0)

# Save path
var save_path = "user://save.json"

# Game variables
const START_SPEED : float = 250.0
const MAX_SPEED : int = 750
const SPEED_MODIFIER : int = 100
const SCORE_MODIFIER : int = 3
var speed : float
var score : int
var screen_size = Global.screen_size
var game_running : bool = false
var coins_collected : int
var already_spawned : bool = false

# Save variables
var total_coins : int
var high_score : int
var total_runs : int
var most_coins_collected : int
var all_time_coins : int
var all_time_distance : int
var existing_data : Dictionary


func _ready():
	# Sets all of the save variables
	total_coins = Global.player_data["UserData"]["Coins"]
	high_score = Global.player_data["UserData"]["HighScore"]
	total_runs = Global.player_data["UserData"]["TotalRuns"]
	most_coins_collected = Global.player_data["UserData"]["MostCoinsCollected"]
	all_time_coins = Global.player_data["UserData"]["AllTimeCoinsCollected"]
	all_time_distance = Global.player_data["UserData"]["AllTimeDistance"]

func new_game():
	get_tree().paused = false
	
	menu_screens.find_child("Main").visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Player.visible = true
	
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
	$Player/BlueDino.speed_scale = 1
	$Player/BlueWings.speed_scale = 1
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
			pass
		
		score = $Player.position.x * SCORE_MODIFIER
		show_score()
		spawn_items()
		
	# Waits for the user to press space then runs the game
	else:
		$HUD.visible = false
		
		if Input.is_action_just_pressed("Space") and Global.can_click:
			game_running = true
			$HUD.visible = true
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			menu_screens.find_child("Main").start_game()


# Updates the score label
func show_score():
	$HUD/Score.text = str(score).left(-2).pad_zeros(4) + "m"
	if high_score < int(str(score).left(-2)):
		$HUD/HighScore.text = "Best:" + str(score).left(-2) + "m"
	else:
		$HUD/HighScore.text = "Best:" + str(high_score) + "m"


# Updates the coins and the coin icon
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


func update_data():
	total_coins += coins_collected
	Global.player_data["UserData"]["Coins"] = total_coins
	Global.player_data["UserData"]["AllTimeCoinsCollected"] += coins_collected
	Global.player_data["UserData"]["TotalRuns"] += 1
	Global.player_data["UserData"]["AllTimeDistance"] += int(str(score).left(-2))
	if Global.player_data["UserData"]["MostCoinsCollected"] < coins_collected:
		Global.player_data["UserData"]["MostCoinsCollected"] = coins_collected
	if int(str(score).left(-2)) > Global.player_data["UserData"]["HighScore"]:
		Global.player_data["UserData"]["HighScore"] = int(str(score).left(-2))
	high_score = Global.player_data["UserData"]["HighScore"]
	
	save_data()

# Opens the save file, converts data into a JSON string then finds the end of the file and saves the data
func save_data():
	var file = FileAccess.open(save_path, FileAccess.READ)
	existing_data = JSON.parse_string(file.get_as_text())
	file.close()
	file = null
	
	existing_data[str(Global.player_key)] = Global.player_data
	
	file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(existing_data))
	file.close()
	file = null

