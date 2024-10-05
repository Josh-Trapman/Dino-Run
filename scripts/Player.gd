extends CharacterBody2D

# Game variables
const FLY_VELOCITY = -850.0
const GRAVITY = 1000

func _ready():
	if Global.player_data["UserData"]["EquippedSkin"] == "Bluezoid":
		for child in $Animations.get_children():
			child.visible = false
		$Animations/BlueDino.visible = true
		$Animations/BlueWings.visible = true
		Global.current_skin = $Animations/BlueDino
		Global.current_wings = $Animations/BlueWings
	
	elif Global.player_data["UserData"]["EquippedSkin"] == "BlazeRex":
		for child in $Animations.get_children():
			child.visible = false
		$Animations/RedDino.visible = true
		$Animations/RedWings.visible = true
		Global.current_skin = $Animations/RedDino
		Global.current_wings = $Animations/RedWings
	
	elif Global.player_data["UserData"]["EquippedSkin"] == "LeafRex":
		for child in $Animations.get_children():
			child.visible = false
		$Animations/GreenDino.visible = true
		$Animations/GreenWings.visible = true
		Global.current_skin = $Animations/GreenDino
		Global.current_wings = $Animations/GreenWings


func _physics_process(delta):
	# Check if the game is running
	if not get_parent().game_running:
		Global.current_skin.play("Idle")
		Global.current_wings.play("Idle")
	else:
		# Apply gravity and change animations
		if not is_on_floor():
			if not Input.is_action_pressed("Space"):
				Global.current_wings.play("Fall")
				if velocity.y < 500:
					velocity.y += GRAVITY * delta
				else:
					velocity.y = 500
			else:
				Global.current_skin.play("Fly")
				Global.current_wings.play("Fly")
		else:
			Global.current_skin.play("Run")
			Global.current_wings.play("Run")
			
		# Handle flying
		if Input.is_action_pressed("Space"):
			if not is_on_floor():
				if velocity.y > 100:
					velocity.y += FLY_VELOCITY * delta * 1.5
				if velocity.y > -500:
					velocity.y += FLY_VELOCITY * delta
				else:
					velocity.y = -500
			else:
				velocity.y -= 150
	move_and_slide()

# After collecting a coin, the coin scene calls this function.
# Plays a sound and calls the parent node's function
func coin_picked_up():
	$CoinPickup.play() 
	get_parent().coins_collected += 1
	get_parent().show_coins()

# Called when the player is hit by an obstacle
func hit():
	# Save the data from the run
	get_parent().update_data()
	get_parent().new_game()

