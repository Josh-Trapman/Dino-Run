extends Area2D

@onready var camera = get_parent().get_parent().find_child("Camera")
@onready var screen_size = get_parent().get_parent().screen_size

const speed = 300

 #Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position.x -= speed *  _delta
	# Removes the instance from the scene once it leaves the screen	
	if camera.position.x - position.x > screen_size.x * 0.5:
		queue_free()
  
# Calls the player's hit function then removes this instance from the scene
func _on_body_entered(_body):
	_body.hit()
	queue_free()
