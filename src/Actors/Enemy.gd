extends "res://src/Actors/Actor.gd"
class_name Enemy

func _ready():
	set_physics_process(false)
	_velocity.x = -speed.x
	
func start():
	set_physics_process(true)

func _physics_process(delta):
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0
	_velocity.y = move_and_slide(_velocity, 
	FLOOR_NORMAL).y

func kill() -> void:
	queue_free()
