extends "res://src/Actors/Actor.gd"


func _ready():
	set_physics_process(false)
	_velocity.x = -speed.x
	

# test
func _physics_process(delta):
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0
	_velocity.y = move_and_slide(_velocity, 
	FLOOR_NORMAL).y
