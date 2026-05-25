extends Node

var gravity: float = 5.2
var gravity_direction: Vector3 = Vector3(0, -1, 0)

func get_gravity() -> float:
	return self.gravity


func set_gravity(gravity: float) -> void:
	self.gravity = gravity


func get_gravity_direction() -> Vector3:
	return self.gravity_direction


func set_gravity_direction(direction: Vector3) -> void:
	self.gravity_direction = direction
