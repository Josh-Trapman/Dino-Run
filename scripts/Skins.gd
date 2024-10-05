extends Control

@onready var buttons = get_parent().find_child("Buttons")

func _on_blue_equip_pressed():
	Global.player_data["UserData"]["EquippedSkin"] = "Bluezoid"
	Global.game_instance.save_data()
	
	$SkinBlue/SkinEquipped.visible = true
	$SkinBlue/EquipSkin.visible = false

func _on_red_buy_pressed():
	var current_coins = Global.player_data["UserData"]["Coins"]
	# Reduces the players coin balance and unlocks the skin
	if Global.player_data["UserData"]["Coins"] >= 500 and Global.player_data["UserData"]["Skins"]["BlazeRex"] == false:
		Global.player_data["UserData"]["Coins"] = current_coins - 500
		Global.player_data["UserData"]["Skins"]["BlazeRex"] = true
		Global.game_instance.save_data()
		
		$SkinRed/Price.visible = false
		$SkinRed/Buy.visible = false
		$SkinRed/EquipSkin.visible = true

func _on_red_equip_pressed():
	Global.player_data["UserData"]["EquippedSkin"] = "BlazeRex"
	Global.game_instance.save_data()
	
	$SkinRed/SkinEquipped.visible = true
	$SkinRed/EquipSkin.visible = false


func _on_green_buy_pressed():
	pass # Replace with function body.


func _on_green_equip_pressed():
	pass # Replace with function body.


func _on_back_pressed():
	visible = false
	Global.can_click = true
	buttons.visible = true


func load_in():
	if Global.player_data["UserData"]["EquippedSkin"] == "Bluezoid":
		$SkinBlue/SkinEquipped.visible = true
		$SkinBlue/EquipSkin.visible = false
		
		if Global.player_data["UserData"]["Skins"]["BlazeRex"] == true:
			$SkinRed/EquipSkin.visible = true
			$SkinRed/Buy.visible = false
			$SkinRed/Price.visible = false
		
		if Global.player_data["UserData"]["Skins"]["LeafRex"] == true:
			$SkinGreen/EquipSkin.visible = true
			$SkinGreen/Buy.visible = false
			$SkinGreen/Price.visible = false
	
	elif Global.player_data["UserData"]["EquippedSkin"] == "BlazeRex":
		$SkinRed/SkinEquipped.visible = true
		$SkinRed/EquipSkin.visible = false
		
		if Global.player_data["UserData"]["Skins"]["Bluezoid"] == true:
			$SkinBlue/EquipSkin.visible = true
			$SkinBlue/Buy.visible = false
			$SkinBlue/Price.visible = false
		
		if Global.player_data["UserData"]["Skins"]["LeafRex"] == true:
			$SkinGreen/EquipSkin.visible = true
			$SkinGreen/Buy.visible = false
			$SkinGreen/Price.visible = false
			
	elif Global.player_data["UserData"]["EquippedSkin"] == "LeafRex":
		$SkinGreen/SkinEquipped.visible = true
		$SkinGreen/EquipSkin.visible = false
		
		if Global.player_data["UserData"]["Skins"]["Bluezoid"] == true:
			$SkinBlue/EquipSkin.visible = true
			$SkinBlue/Buy.visible = false
			$SkinBlue/Price.visible = false
		
		if Global.player_data["UserData"]["Skins"]["BlazeRex"] == true:
			$SkinRed/EquipSkin.visible = true
			$SkinRed/Buy.visible = false
			$SkinRed/Price.visible = false
