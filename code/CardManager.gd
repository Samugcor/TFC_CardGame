extends Node2D

var cardBeingDragged = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("grabCard")):
		cardBeingDragged = raycastCheckCard()
	if(Input.is_action_just_released("grabCard")):
		cardBeingDragged = null
		
	if cardBeingDragged:
		cardBeingDragged.position = get_global_mouse_position()

func raycastCheckCard():
		var spaceState = get_world_2d().direct_space_state
		var parameters = PhysicsPointQueryParameters2D.new()
		parameters.position = get_global_mouse_position()
		parameters.collide_with_areas = true
		parameters.collision_mask = 1
		var result = spaceState.intersect_point(parameters)
		if result.size()>0:
			return result[0].collider.get_parent()
		return null
