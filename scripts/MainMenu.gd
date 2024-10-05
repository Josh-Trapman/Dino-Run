extends CanvasLayer

func _ready():
	$AnimationPlayer.animation_finished.connect(_on_animation_finished)
	$"../Pause".connect("run_ended", _on_run_ended)


func _on_timer_timeout():
	if $Label.visible == true:
		$Label.visible = false
	else:
		$Label.visible = true


func _on_animation_finished(_animation_name):
	if _animation_name == "start_game":
		visible = false
	$AnimationPlayer.play("RESET")
	$Timer.paused = false


func _on_settings_pressed():
	$Buttons.visible = false
	$Settings.visible = true
	Global.can_click = false


func _on_skins_pressed():
	$Buttons.visible = false
	$Skins.visible = true
	Global.can_click = false


func _on_logout_pressed():
	# Resetting all global variables and destroying the game instance
	await get_tree().process_frame
	Global.game_instance.queue_free()
	Global.player_data = {}
	Global.player_key = -1
	Global.can_click = true
	Global.current_skin = null
	Global.current_wings = null
	Global.game_instance = null
	
	visible = false
	
	$"../Login".visible = true


func _on_run_ended():
	$AnimationPlayer.stop()
	$AnimationPlayer.seek(0)


func start_game():
	$Timer.paused = true
	$Label.visible = false
	$AnimationPlayer.play("start_game")


