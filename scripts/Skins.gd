extends Control

var player_data : Dictionary

func _ready():
	player_data = owner.owner.game_instance.player_data
	
func _on_blue_equip_pressed():
	$SkinBlue/SkinEquipped.visible = true
	$SkinBlue/EquipSkin.visible = false


func _on_red_buy_pressed():
	pass # Replace with function body.


func _on_red_equip_pressed():
	pass # Replace with function body.


func _on_green_buy_pressed():
	pass # Replace with function body.


func _on_green_equip_pressed():
	pass # Replace with function body.
