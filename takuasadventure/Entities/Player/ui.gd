extends Control

#TEST CODE DELETE THIS LATER PLS
func _input(_event: InputEvent) -> void:
	if GlobalVariables.DEVELOPER_MODE == true:
		if Input.is_key_label_pressed(KEY_O):
			$TextureProgressBar.value += 1
		if Input.is_key_label_pressed(KEY_P):
			$TextureProgressBar.value -= 1
