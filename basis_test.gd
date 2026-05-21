@tool

extends CSGBox3D


@export var t: Transform3D
@export var rot_x: float = 0
@export var rot_y: float = 0
@export var rot_z: float = 0

@export var t2: Basis

@export var disable_x_change: bool = false
@export var disable_y_change: bool = false
@export var disable_z_change: bool = false

@export var disable_add: bool
@export var add_factor: float = 0

var add:float = 0

func _physics_process(delta):
	if not disable_add:
		add += add_factor
	else:
		add = 0
	
	var rx = Basis(
		Vector3(cos(rot_x+add),-sin(rot_x+add),0),
		Vector3(sin(rot_x+add),cos(rot_x+add),0),
		Vector3(0,0,1),
	)
	var ry = Basis(
		Vector3(cos(rot_y+add),0,sin(rot_y+add)),
		Vector3(0,1,0),
		Vector3(-sin(rot_y+add),0,cos(rot_y+add)),
	)
	var rz = Basis(
		Vector3(1,0,0),
		Vector3(0,cos(rot_z+add),-sin(rot_z+add)),
		Vector3(0,sin(rot_z+add),cos(rot_z+add)),
	)
	
	if disable_x_change: rx = Basis()
	if disable_y_change: ry = Basis()
	if disable_z_change: rz = Basis()
	
	t2 = Basis(Vector3(2,1,0),Vector3(0,.5,1),Vector3(0,0,1))*rx*ry*rz*t.basis
	
	transform.basis = t2
