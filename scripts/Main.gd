extends Node

@onready var game = preload("res://scenes/game.tscn")

var save_path = "user://save.dat"


func logged_in():
	Global.game_instance = game.instantiate()
	add_child(Global.game_instance)
