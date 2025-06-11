class_name Carry
extends Node

signal carried
signal thrown
signal dropped_to_idle

@export var player_body: CharacterBody2D
var items_nearby = []
var closest_item = null

var max_deviation: float = 0.05

#func _process(delta: float) -> void:
	#print(items_nearby)

func _on_player_input_interact() -> void:
	if GlobalVariables.carried_object != null:
		thrown.emit()
		#GlobalVariables.carried_object.throw(player_body.aim_direction)
	
	elif GlobalVariables.targeted_object != null:
		if player_body.get_current_animation() == "idle" \
		or player_body.get_current_animation() == "walk":
			GlobalVariables.targeted_object.carried(player_body)
			carried.emit()
	

func throw_from_animation(): #specifically to be called from any of the throw animations.
	var new_aim_dir = Vector2.ZERO
	#randomize, very slightly the deviation of the angle of the throw to prevent objects from bunching up.
	new_aim_dir.x = player_body.aim_direction.x + randf_range(-max_deviation, max_deviation)
	new_aim_dir.y = player_body.aim_direction.y + randf_range(-max_deviation, max_deviation)
	GlobalVariables.carried_object.throw(new_aim_dir)
	print(new_aim_dir)

func _on_player_input_jumped() -> void:
	if GlobalVariables.carried_object != null and player_body.get_current_animation() != "throw":
		GlobalVariables.carried_object.drop()
		dropped_to_idle.emit()

func _on_item_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("throwable"):
		if items_nearby.has(body) == false: 
			items_nearby.append(body)


func _on_item_detector_body_exited(body: Node2D) -> void:
	if items_nearby.has(body) == true:
		items_nearby.erase(body)


func _on_item_check_tick_timeout() -> void:
	closest_item = find_closest_item()
	#print("the closest item is:", closest_item)
	#if closest_item != null:
		#closest_item.targeted_fosr_carry()
	GlobalVariables.targeted_object = closest_item

func find_closest_item():
	#this should never happen, but might as well add as an edge case.
	if items_nearby.size() < 1: 
		return null
		
	#If there's only one item, no need to do any math. Just return the first element.
	elif items_nearby.size() == 1:
		return items_nearby[0]
		
	#If there's more than one, run an intro-to-CS style number check, and return a reference 
	#to the closest item. 
	elif items_nearby.size() > 1:
		var shortest_length = 100
		var closest
		for x in items_nearby:
			var current_length = (player_body.global_position - x.global_position).length()
			if current_length < shortest_length:
				shortest_length = current_length
				closest = x
		return closest
