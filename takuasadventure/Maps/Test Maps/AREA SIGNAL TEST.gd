extends Area2D

#this code hurts me, but it's just test code, dear god, none of this will stay in the final game.

var stuff = []
var shortest_length
var closest_body = null

func _on_body_entered(body: Node2D) -> void:
	print("A thing entered!")
	
	if stuff.has(body) == false: 
		stuff.append(body)
		print(stuff)

	if stuff.size() > 0:
		shortest_length = 100
		for x in stuff:
			var current_length = (self.global_position - x.global_position).length()
			if current_length < shortest_length:
				shortest_length = current_length
				closest_body = x
			
	print("The closest body is ", closest_body)
