extends Control

@onready var buttons = get_parent().find_child("Buttons")

signal skin_changed

# Equips Blue skin
func _on_blue_equip_pressed():
	Global.player_data["UserData"]["EquippedSkin"] = "Bluezoid"
	Global.game_instance.save_data()
	
	$SkinBlue/SkinEquipped.visible = true
	$SkinBlue/EquipSkin.visible = false
	
	if Global.player_data["UserData"]["Skins"]["BlazeRex"] == true:
		$SkinRed/SkinEquipped.visible = false
		$SkinRed/EquipSkin.visible = true
	if Global.player_data["UserData"]["Skins"]["LeafRex"] == true:
		$SkinGreen/SkinEquipped.visible = false
		$SkinGreen/EquipSkin.visible = true
	
	emit_signal("skin_changed")


# Buys Red skin
func _on_red_buy_pressed():
	var current_coins = Global.player_data["UserData"]["Coins"]
	# Reduces the players coin balance and unlocks the skin
	if Global.player_data["UserData"]["Coins"] >= 500 and Global.player_data["UserData"]["Skins"]["BlazeRex"] == false:
		Global.player_data["UserData"]["Coins"] = current_coins - 500
		Global.player_data["UserData"]["Skins"]["BlazeRex"] = true
		Global.game_instance.save_data()
		$"../Main/TotalCoins2".text = Global.player_data["UserData"]["Coins"]
		$"../Main/TotalCoins2/CoinIcon".position.x = len(str(Global.player_data["UserData"]["Coins"])) * -24
		
		# Sets the skin to an equippable state
		$SkinRed/Price.visible = false
		$SkinRed/Buy.visible = false
		$SkinRed/EquipSkin.visible = true


# Equips Red skin
func _on_red_equip_pressed():
	Global.player_data["UserData"]["EquippedSkin"] = "BlazeRex"
	Global.game_instance.save_data()
	
	$SkinRed/SkinEquipped.visible = true
	$SkinRed/EquipSkin.visible = false
	
	if Global.player_data["UserData"]["Skins"]["Bluezoid"] == true:
		$SkinBlue/SkinEquipped.visible = false
		$SkinBlue/EquipSkin.visible = true
	if Global.player_data["UserData"]["Skins"]["LeafRex"] == true:
		$SkinGreen/SkinEquipped.visible = false
		$SkinGreen/EquipSkin.visible = true
	
	emit_signal("skin_changed")


# Buys Green skin
func _on_green_buy_pressed():
	var current_coins = Global.player_data["UserData"]["Coins"]
	# Reduces the players coin balance and unlocks the skin
	if Global.player_data["UserData"]["Coins"] >= 500 and Global.player_data["UserData"]["Skins"]["LeafRex"] == false:
		Global.player_data["UserData"]["Coins"] = current_coins - 500
		Global.player_data["UserData"]["Skins"]["LeafRex"] = true
		Global.game_instance.save_data()
		$"../Main/TotalCoins2".text = str(Global.player_data["UserData"]["Coins"])
		$"../Main/TotalCoins2/CoinIcon".position.x = len(str(Global.player_data["UserData"]["Coins"])) * -24
		
		# Sets the skin to an equippable state
		$SkinGreen/Price.visible = false
		$SkinGreen/Buy.visible = false
		$SkinGreen/EquipSkin.visible = true


# Equips Green skin
func _on_green_equip_pressed():
	Global.player_data["UserData"]["EquippedSkin"] = "LeafRex"
	Global.game_instance.save_data()
	
	$SkinGreen/SkinEquipped.visible = true
	$SkinGreen/EquipSkin.visible = false
	
	if Global.player_data["UserData"]["Skins"]["Bluezoid"] == true:
		$SkinBlue/SkinEquipped.visible = false
		$SkinBlue/EquipSkin.visible = true
	if Global.player_data["UserData"]["Skins"]["BlazeRex"] == true:
		$SkinRed/SkinEquipped.visible = false
		$SkinRed/EquipSkin.visible = true
	
	emit_signal("skin_changed")


# Closes page
func _on_back_pressed():
	visible = false
	Global.can_click = true
	buttons.visible = true


# Updates the page according to player data on log in
func load_in():
	# Set Blue skin to equipped state
	if Global.player_data["UserData"]["EquippedSkin"] == "Bluezoid":
		$SkinBlue/SkinEquipped.visible = true
		$SkinBlue/EquipSkin.visible = false
		
		# If Red skin is owned sets it to an equippable state
		if Global.player_data["UserData"]["Skins"]["BlazeRex"] == true:
			$SkinRed/EquipSkin.visible = true
			$SkinRed/Buy.visible = false
			$SkinRed/Price.visible = false
		
		# If Green skin is owned sets it to an equippable state
		if Global.player_data["UserData"]["Skins"]["LeafRex"] == true:
			$SkinGreen/EquipSkin.visible = true
			$SkinGreen/Buy.visible = false
			$SkinGreen/Price.visible = false
		
	# Set Red skin to equipped state
	elif Global.player_data["UserData"]["EquippedSkin"] == "BlazeRex":
		$SkinRed/SkinEquipped.visible = true
		$SkinRed/Buy.visible = false
		$SkinRed/Price.visible = false
		
		# Sets Blue skin to an equippable state
		if Global.player_data["UserData"]["Skins"]["Bluezoid"] == true:
			$SkinBlue/EquipSkin.visible = true
		
		# If Green skin is owned sets it to an equippable state
		if Global.player_data["UserData"]["Skins"]["LeafRex"] == true:
			$SkinGreen/EquipSkin.visible = true
			$SkinGreen/Buy.visible = false
			$SkinGreen/Price.visible = false
		
	# Set Green skin to equipped state
	elif Global.player_data["UserData"]["EquippedSkin"] == "LeafRex":
		$SkinGreen/SkinEquipped.visible = true
		$SkinGreen/Buy.visible = false
		$SkinGreen/Price.visible = false
		
		# Sets Blue skin to an equippable state
		if Global.player_data["UserData"]["Skins"]["Bluezoid"] == true:
			$SkinBlue/EquipSkin.visible = true
		
		# If Red skin is owned sets it to an equippable state
		if Global.player_data["UserData"]["Skins"]["BlazeRex"] == true:
			$SkinRed/EquipSkin.visible = true
			$SkinRed/Buy.visible = false
			$SkinRed/Price.visible = false
