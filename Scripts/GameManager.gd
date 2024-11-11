extends Node

var score_left = 0
var score_right = 0

func reset_scores():
	score_left = 0
	score_right = 0

func get_nearest_node_in_group(group, position):
	var nodes = get_tree().get_nodes_in_group(group)
	nodes.sort_custom( func(a,b): return a.global_position.distance_to(position)<b.global_position.distance_to(position) )
	return nodes[0]
