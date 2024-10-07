extends Node2D

var warning = preload("res://scenes/warning.tscn")

@onready var player = get_parent().find_child("Player")

# Creates an instance of the warning scene at the player's y value
func spawn():
	var warning_instance = warning.instantiate()	
	warning_instance.position.y = player.position.y
	add_child(warning_instance)
	
	

