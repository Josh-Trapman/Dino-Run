extends Control

@onready var buttons = get_parent().find_child("Buttons")
@onready var main = owner.owner
@onready var game = main.game_instance

var player_data

func _on_volume_value_changed(value : float):
	AudioServer.set_bus_volume_db(0, linear_to_db(value))


func _on_back_pressed():
	visible = false
	$StatsPage.visible = false
	buttons.visible = true
	main.game_instance.can_click = true


func _on_stats_pressed():
	player_data = main.game_instance.player_data
	$StatsPage.visible = true
	$StatsPage/TotalRuns.text = str(player_data["UserData"]["TotalRuns"])
	$StatsPage/HighScore.text = str(player_data["UserData"]["HighScore"])
	$StatsPage/CoinsCollected.text = str(player_data["UserData"]["AllTimeCoinsCollected"])
	$StatsPage/DistanceCovered.text = str(player_data["UserData"]["AllTimeDistance"])
	$StatsPage/MostCoinsCollected.text = str(player_data["UserData"]["MostCoinsCollected"])
	
	
