extends Node2D

var object: RID
var img: RID

func _ready() -> void:
	prints("single object space:", get_world_2d().space)

	var box_shape := RectangleShape2D.new()
	box_shape.size = Vector2(64, 64)

	var physics_server := PhysicsServer2D
	object = physics_server.body_create()
	physics_server.body_set_space(object, get_world_2d().space)
	physics_server.body_add_shape(object, box_shape)

	var trans := Transform2D(0, Vector2(550, -10))
	physics_server.body_set_state(object, PhysicsServer2D.BODY_STATE_TRANSFORM, trans)

	prints("body layer:", physics_server.body_get_collision_layer(object))
	prints("body mask:", physics_server.body_get_collision_mask(object))
	prints("body priority:", physics_server.body_get_collision_priority(object))

	# physics_server.body_set_collision_layer(object, 3)
	# physics_server.body_set_collision_mask(object, 3)

	# canvas
	var tex := preload("res://icon.svg")
	var rs := RenderingServer
	img = rs.canvas_item_create()
	rs.canvas_item_set_parent(img, get_canvas_item())
	rs.canvas_item_add_texture_rect(img, Rect2(-32, -32, 64, 64), tex)
	rs.canvas_item_set_transform(img, trans)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var trans = PhysicsServer2D.body_get_state(object, PhysicsServer2D.BODY_STATE_TRANSFORM)
	RenderingServer.canvas_item_set_transform(img, trans)

func _exit_tree() -> void:
	PhysicsServer2D.free_rid(object)
	RenderingServer.free_rid(img)
