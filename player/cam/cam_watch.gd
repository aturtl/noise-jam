extends Node3D

@export var body: CharacterBody3D
@export var watch_node: Node3D

var new_pos: Vector3

func _ready():
	new_pos = body.position + -5*-body.transform.basis.z


func watch_player(up_offset: float):
	watch_node.look_at(body.position, Vector3(0,up_offset,0))
	
	var dir:Vector3 = watch_node.position.direction_to(body.position).normalized()
	dir = dir.clamp(Vector3(-1,0,-1),Vector3(1,0,1))
	
	if watch_node.position.lerp(new_pos,.7).distance_to(body.position) > 2.5:
		new_pos += dir*.1
	elif watch_node.position.lerp(new_pos,.7).distance_to(body.position) < 2:
		new_pos -= dir*.1
	
	if new_pos.distance_to(body.position) < 1:
		new_pos = -body.position.direction_to(new_pos)
	
	new_pos.y = body.position.y + up_offset
	
	watch_node.position = watch_node.position.lerp(new_pos, .1)


func _physics_process(delta):
	watch_player(.5)
