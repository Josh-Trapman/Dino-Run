extends Control

@onready var buttons = get_parent().find_child("Buttons")
@onready var main = owner.owner
@onready var game = main.game_instance

var player_data

func _on_volume_value_changed(value : float):
	AudioServer.set_bus_volume_db(0, linear_to_db(value))


func _on_back_pressed():
	visible = false
	buttons.visible = true
	main.game_instance.can_click = true


func _on_stats_pressed():
	player_data = game.player_data
	$StatsPage/TotalRuns.text = player_data["UserData"]["TotalRuns"]
	$StatsPage/HighScore.text = player_data["UserData"]["HighScore"]
	$StatsPage/CoinsCollected.text = player_data["UserData"]["AllTimeCoinsCollected"]
	$StatsPage/DistanceCovered.text = player_data["UserData"]["AllTimeDistance"]
	$StatsPage/MostCoinsCollected.text = player_data["UserData"]["MostCoinsCollected"]
	
	
