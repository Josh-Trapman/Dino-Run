extends CanvasLayer

@onready var main = owner.owner

func _ready():
	$AnimationPlayer.animation_finished.connect(_on_animation_finished)

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

func start_game():
	$Timer.paused = true
	$Label.visible = false
	$AnimationPlayer.play("start_game")

func _on_settings_pressed():
	$Buttons.visible = false
	$Settings.visible = true
	main.game_instance.can_click = false

func _on_skins_pressed():
	$Buttons.visible = false
	$Skins.visible = true
	main.game_instance.can_click = false
