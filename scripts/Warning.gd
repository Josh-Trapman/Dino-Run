extends Area2D

var bug = preload("res://scenes/bug.tscn")

@onready var main = get_parent().get_parent()
@onready var camera = main.find_child("Camera")
@onready var player = main.find_child("Player")
@onready var screen_size = main.screen_size

const speed = 180

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if main.game_running:
		# Speeds up the animation as the timer gets closer to ending
		$AnimatedSprite2D.speed_scale = $SummonBug.wait_time - $SummonBug.time_left
		# Keeps the warning animation at the edge of the screen
		position.x = player.position.x + screen_size.x - 170
		# Follows the player's y coordinate
		if abs(position.y - player.position.y) > 5:
			position.y += speed * _delta * sign(player.position.y - position.y)
	else:
		queue_free()
		
# Removes the instance of the warning sign and creates a new instance of a bug when the timer ends
func _on_timer_timeout():
	queue_free()
	var bug_instance = bug.instantiate()
	bug_instance.position = position + Vector2(70, 0)
	add_sibling(bug_instance)
	


