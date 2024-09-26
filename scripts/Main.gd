extends Node

@onready var game = preload("res://scenes/game.tscn")

var player_data : Dictionary
var player_key
var save_path = "user://save.dat"
var game_instance

func logged_in(account : Dictionary, key):
	player_data = account
	player_key = key
	game_instance = game.instantiate()
	add_child(game_instance)
