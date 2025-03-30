extends CharacterBody2D

var direction: Vector2
var speed = 100
var friction = 1.5
var can_go: bool = false

func _ready() -> void:
	pass
	

func _physics_process(delta: float) -> void:
	if can_go:
		velocity = velocity.move_toward(Vector2.ZERO, friction)
	
		move_and_slide()
	

func _input(_event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_X):
		can_go = true
		
		direction.x = randi_range(-1, 1)
		direction.y = randi_range(-1, 1)
		velocity = direction * speed
		$AnimationPlayer.play("ObjectAnimations/throwable_falling")
