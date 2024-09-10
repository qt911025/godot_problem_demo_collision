extends Node2D

var plane_body: RID

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var physics_space := get_world_2d().space
	prints("main physics space:", physics_space)

	plane_body = PhysicsServer2D.body_create()
	var plane_shape := SegmentShape2D.new()
	plane_shape.a = Vector2(200, 400)
	plane_shape.b = Vector2(800, 400)

	PhysicsServer2D.body_set_space(plane_body, physics_space)
	PhysicsServer2D.body_add_shape(plane_body, plane_shape)
	PhysicsServer2D.body_set_mode(plane_body, PhysicsServer2D.BODY_MODE_STATIC)

# func _physics_process(_delta: float) -> void:
# 	prints("plane transform:", PhysicsServer2D.body_get_state(plane_body, PhysicsServer2D.BODY_STATE_TRANSFORM))