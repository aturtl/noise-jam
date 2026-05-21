extends Node

@export var body: CharacterBody3D
@export var camera: Camera3D

func _physics_process(delta):
	camera.look_at(body.position)
	
	if camera.position.distance_to(body.position) > 3:
		camera.position += camera.position.direction_to(body.position)*.1
