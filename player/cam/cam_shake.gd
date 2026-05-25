extends Node3D


@export var shake_node: Node3D
@export var shake_intensity: float = 0.0

var negative = -1;

func shake():
	shake_node.rotation = Vector3(0,0,negative*randf_range(0,shake_intensity))
	negative *= -1;


func _physics_process(delta):
	if shake_intensity != 0.0:
		shake()
