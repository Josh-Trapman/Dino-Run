extends CanvasLayer

@onready var main = owner.owner

func _ready():
	$ColorRect.visible = false
	$AnimationPlayer.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(animation_name):
	if animation_name == "fade_out":
		$AnimationPlayer.play("fade_in")
		owner.find_child("Login").visible = false
		main.game_instance.new_game()

	elif animation_name == "fade_in":
		$ColorRect.visible = false
		main.game_instance.can_click = true
		get_tree().root.gui_disable_input = false

func transition():
	$ColorRect.visible = true
	main.game_instance.can_click = false
	get_tree().root.gui_disable_input = true
	$AnimationPlayer.play("fade_out")


