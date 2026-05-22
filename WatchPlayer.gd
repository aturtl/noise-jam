extends Node

@export var body: CharacterBody3D
@export var camera: Camera3D

var new_pos: Vector3

func _ready():
	new_pos = body.position + -5*-body.transform.basis.z

func _physics_process(delta):
	camera.look_at(body.position)
	
	var dir:Vector3 = camera.position.direction_to(body.position)
	
	dir = dir.normalized()
	
	dir = dir.clamp(Vector3(-1,0,-1),Vector3(1,0,1))
	
	if camera.position.lerp(new_pos,.7).distance_to(body.position) > 2.5:
		new_pos += dir*.1
	elif camera.position.lerp(new_pos,.7).distance_to(body.position) < 2:
		new_pos -= dir*.1
	
	new_pos.y = body.position.y + .5
	
	camera.position = camera.position.lerp(new_pos, .02)
