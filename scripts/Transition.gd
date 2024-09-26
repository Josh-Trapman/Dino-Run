extends CanvasLayer

@onready var main = owner.owner

func _ready():
	$ColorRect.visible = false
	$AnimationPlayer.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(animation_name):
	# Plays the fade in animation once fade out finishes
	if animation_name == "fade_out":
		$AnimationPlayer.play("fade_in")
		# Hides the login screen
		owner.find_child("Login").visible = false
		# Calls a new game which sets the player at the start
		main.game_instance.new_game()
	# Enables all user inputs once the fade in animation finishes
	elif animation_name == "fade_in":
		$ColorRect.visible = false
		main.game_instance.can_click = true
		get_tree().root.gui_disable_input = false

func transition():
	$ColorRect.visible = true
	# Disables all user inputs while transition animation is playing
	main.game_instance.can_click = false
	get_tree().root.gui_disable_input = true
	# Plays transition animation
	$AnimationPlayer.play("fade_out")


