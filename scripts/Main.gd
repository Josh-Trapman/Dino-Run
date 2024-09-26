extends Node

@onready var game = preload("res://scenes/game.tscn")

var player_data : Dictionary
var save_path = "user://save.dat"
var game_instance

func logged_in(account):
	player_data = account
	
	game_instance = game.instantiate()
	add_child(game_instance)
