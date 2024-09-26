extends Node2D

# Preload the coin scene
var coin = preload("res://scenes/coin.tscn")

const spacing : int = 25

# Initialize the patterns dictionary
var patterns = {}

func _ready():
	# Create coin patterns here
	set_rect_pattern(1, 9, 3)
	set_rect_pattern(2, 6, 5)

func set_rect_pattern(pattern_index : int, columns : int, rows : int):
	var x = 0
	# Create a new key in patterns dict
	patterns[pattern_index] = []
	# Generate positions and store them in the patterns dictionary under a defined key
	for n in range(columns * rows):
		if n % rows == 0:
			x += 1
		var pos = Vector2i((x * spacing),
							n % rows * spacing)
		patterns[pattern_index].append(pos)

func place_pattern(pattern_index : int, current_x : int, screen_size : Array):
	var y = randi_range(50, screen_size[1] - 50)
	# Iterate through the positions stored in patterns and instantiate coins
	for pos in patterns[pattern_index]:
		var instance = coin.instantiate()
		pos += Vector2i(screen_size[0] + current_x,
						50 + (screen_size[1] % y))
		instance.position = pos
		add_child(instance)
