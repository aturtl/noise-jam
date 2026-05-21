extends CharacterBody3D

@export var camera: Camera3D

var walk_speed: float = 7.0
var jump_velocity: float = 25.0

var gravity_limit: float = 52.0

var up_velocity: Vector3 = Vector3(0, 0, 0)
var move_velocity: Vector3 = Vector3(0, 0, 0)

func _ready() -> void:
	pass


func _physics_process(delta) -> void:
	var move_direction: Vector3 = self.get_move_direction()
	var jump_direction: Vector3 = self.get_jump_direction()
	var grav_direction: Vector3 = self.get_grav_direction()
	
	move_velocity = move_direction * walk_speed
	
	if not self.is_on_floor():
		up_velocity += grav_direction * Physics.gravity
	
	if self.can_jump() and Input.is_action_just_pressed("jump"):
		up_velocity = jump_direction * jump_velocity
	
	self.velocity = self.get_total_velocity()
	
	self.move_and_slide()


func get_grav_direction() -> Vector3:
	return Vector3(0, -1, 0)


func get_total_velocity() -> Vector3:
	var v: Vector3 = Vector3(0,0,0)
	v += move_velocity
	v += up_velocity
	return v


func get_move_direction() -> Vector3:
	var move_dir: Vector3 = Vector3(Input.get_axis("move_l","move_r"), 0, Input.get_axis("move_f","move_b"))
	
	var cam_angle = camera.rotation
	
	move_dir = move_dir.rotated(Vector3(0,1,0), cam_angle.y)
	
	return move_dir.normalized()


func can_jump() -> bool:
	return self.is_on_floor()


func get_jump_direction() -> Vector3:
	return Vector3(0, 1, 0)
