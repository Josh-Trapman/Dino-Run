extends Control

@onready var buttons = get_parent().find_child("Buttons")

func _on_blue_equip_pressed():
	$SkinBlue/SkinEquipped.visible = true
	$SkinBlue/EquipSkin.visible = false

func _on_red_buy_pressed():
	print(Global.player_data)
	# Reduces the players coin balance and unlocks the skin
	if Global.player_data["UserData"]["Coins"] >= 500:
		Global.player_data["UserData"]["Coins"] -= 500
		Global.player_data["UserData"]["Skins"]["BlazeRex"] = true


func _on_red_equip_pressed():
	pass # Replace with function body.


func _on_green_buy_pressed():
	pass # Replace with function body.


func _on_green_equip_pressed():
	pass # Replace with function body.


func _on_back_pressed():
	visible = false
	Global.can_click = true
	buttons.visible = true
