extends Node3D

var v:Vector3 = Vector3(1,0,0)

@onready var torus = $CSGTorus3D

func _physics_process(delta):
	var t: Transform3D
	var t2: Transform3D = Transform3D(
		Vector3(),
		Vector3(),
		Vector3(),
		Vector3()
	)
	
	var angle: float = .5
	
	var rot: Basis = Basis(
		Vector3(cos(angle),-sin(angle),0),
		Vector3(sin(angle),cos(angle),0),
		Vector3(0,0,1),
	)
	
	v = rot*v
	
	torus.position *= rot
	torus.rotation *= rot
