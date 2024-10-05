extends CanvasLayer

signal run_ended

func just_paused(total_coins):
	get_tree().paused = true
	visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$TotalCoins.text = str(total_coins)
	$TotalCoins/CoinIcon.position.x = len(str(total_coins)) * -14

func _on_resume_pressed():
	get_tree().paused = false
	visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
 
func _on_end_run_pressed():
	visible = false
	owner.find_child("Transition").transition()
	Global.game_instance.find_child("HUD").visible = false
	Global.game_instance.update_data()
	Global.game_instance.save_data()
	emit_signal("run_ended")
	

