extends Node2D

signal switch_flipped

func on_hurtbox_hit():
	$Sprite2D.frame = 1
	switch_flipped.emit()
