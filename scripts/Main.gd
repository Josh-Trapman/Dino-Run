extends Node

@onready var game = preload("res://scenes/game.tscn")

var save_path = "user://save.dat"

func _ready():
	# Receives signal when skin is changed
	$Menu/Main/Skins.connect("skin_changed", _on_skin_changed)


func logged_in():
	Global.game_instance = game.instantiate()
	add_child(Global.game_instance)
	# Updates player skins page
	$Menu/Main/Skins.load_in()


# Updates skin on change
func _on_skin_changed():
	for child in $Game/Player/Animations.get_children():
		child.visible = false
	
	# Stops any player animations before changing skins
	Global.current_skin.stop()
	Global.current_wings.stop()
	
	# Checks which skin is equipped in player data and displays it
	if Global.player_data["UserData"]["EquippedSkin"] == "Bluezoid":
		Global.current_skin = $Game/Player/Animations/BlueDino
		Global.current_wings = $Game/Player/Animations/BlueWings
		Global.current_skin.visible = true
		Global.current_wings.visible = true
		
	elif Global.player_data["UserData"]["EquippedSkin"] == "BlazeRex":
		Global.current_skin = $Game/Player/Animations/RedDino
		Global.current_wings = $Game/Player/Animations/RedWings
		Global.current_skin.visible = true
		Global.current_wings.visible = true
		
	elif Global.player_data["UserData"]["EquippedSkin"] == "LeafRex":
		Global.current_skin = $Game/Player/Animations/GreenDino
		Global.current_wings = $Game/Player/Animations/GreenWings
		Global.current_skin.visible = true
		Global.current_wings.visible = true
