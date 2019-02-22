extends Node2D

# Grid Variables
export (int) var width
export (int) var height
export (int) var x_start
export (int) var y_start
export (int) var offset

var possible_pieces = [
preload("res://scene/piece/piece_yellow.tscn"),
preload("res://scene/piece/piece_pink.tscn"),
preload("res://scene/piece/piece_orange.tscn"),
preload("res://scene/piece/piece_lightGreen.tscn"),
preload("res://scene/piece/piece_green.tscn"),
preload("res://scene/piece/piece_blue.tscn")
]

var all_pieces = []


func _ready():
	all_pieces = make_2d_array()
	spawn_pieces()
	
func make_2d_array():
	var array =[]
	for i in width:
		array.append([]);
		for j in height:
			array[i].append(null)
	return array;
	
func spawn_pieces ():
	randomize()
	for i in width:
		for j in height:
			var rand = floor(rand_range(0, possible_pieces.size()))
			var piece = possible_pieces[rand].instance()
			var loops = 0
			while(match_at(i,j, piece.color) && loops < 100):
				rand = floor(rand_range(0, possible_pieces.size()))
				piece = possible_pieces[rand].instance()
				loops +=1
			add_child(piece)
			piece.position = grid_to_pixel(i, j)
			all_pieces[i][j] = piece
	
func match_at(i, j, color):
	if i > 1:
		if all_pieces[i-1][j] != null && all_pieces[i-2][j] != null:
			if all_pieces[i-1][j].color == color && all_pieces[i-2][j].color == color:
				return true;
		
		if all_pieces[i][j-1] != null && all_pieces[i][j-2] != null:
			if all_pieces[i][j-1].color == color && all_pieces[i-2][j].color == color:
				return true;
	pass

func grid_to_pixel(column, row):
	var new_x = x_start + offset * column
	var new_y = y_start + offset * row
	return Vector2(new_x, new_y)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
