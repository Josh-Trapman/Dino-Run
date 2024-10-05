extends Control

@onready var buttons = get_parent().find_child("Buttons")

func _on_volume_value_changed(value : float):
	AudioServer.set_bus_volume_db(0, linear_to_db(value))


func _on_back_pressed():
	visible = false
	$StatsPage.visible = false
	buttons.visible = true
	Global.can_click = true


func _on_stats_pressed():
	$StatsPage.visible = true
	$StatsPage/TotalRuns.text = str(Global.player_data["UserData"]["TotalRuns"])
	$StatsPage/HighScore.text = str(Global.player_data["UserData"]["HighScore"])
	$StatsPage/CoinsCollected.text = str(Global.player_data["UserData"]["AllTimeCoinsCollected"])
	$StatsPage/DistanceCovered.text = str(Global.player_data["UserData"]["AllTimeDistance"])
	$StatsPage/MostCoinsCollected.text = str(Global.player_data["UserData"]["MostCoinsCollected"])
	
	
