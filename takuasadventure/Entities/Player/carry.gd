class_name Carry
extends Node

signal carried

@export var player_body: CharacterBody2D
var items_nearby = []
var closest_item = null

func _on_player_input_interact() -> void:
	if GlobalVariables.carried_object != null:
		GlobalVariables.carried_object.throw(player_body.aim_direction)
	
	elif GlobalVariables.targeted_object != null:
		if player_body.get_current_animation() == "idle" \
		or player_body.get_current_animation() == "walk":
			GlobalVariables.targeted_object.carried(player_body)
			carried.emit()
	

func _on_player_input_jumped() -> void:
	if GlobalVariables.carried_object != null:
		GlobalVariables.carried_object.drop()

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
