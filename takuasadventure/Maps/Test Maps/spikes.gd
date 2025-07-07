extends Area2D


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("hurtbox"):
		area.get_parent().recieve_damage_simple()
