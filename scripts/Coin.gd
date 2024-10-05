extends Area2D

@onready var camera = get_parent().get_parent().find_child("Camera")

var screen_size = Global.screen_size

# Removes the coin from the scene if the camera has gone past it
func _process(_delta): 
	var pos = camera.position.x
	if pos - position.x > 0.5 * screen_size.x:
		queue_free()
	
# When player enters the coin area triggers Player's 
# function then removes the coin instance from the scene
func _on_body_entered(_body):
	_body.coin_picked_up()
	queue_free()


