extends Node

var move_direction: Vector3
var jump_direction: Vector3 = Vector3(0, 1, 0)

func get_move_direction() -> Vector3:
	return self.move_direction


func set_move_direction(direction: Vector3) -> void:
	self.move_direction = direction


func get_jump_direction() -> Vector3:
	return self.jump_direction


func set_jump_direction(direction: Vector3) -> void:
	self.jump_direction = direction
