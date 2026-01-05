extends Node2D

const COLLISION_MASK_CARD = 1

var screenSize =  null
var cardBeingDragged = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screenSize = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("grabCard")):
		cardBeingDragged = raycastCheckCard()
	if(Input.is_action_just_released("grabCard")):
		cardBeingDragged = null
		
	if cardBeingDragged:
		updateCarcCoordinates()
		

func raycastCheckCard():
		var spaceState = get_world_2d().direct_space_state
		var parameters = PhysicsPointQueryParameters2D.new()
		parameters.position = get_global_mouse_position()
		parameters.collide_with_areas = true
		parameters.collision_mask = COLLISION_MASK_CARD
		var result = spaceState.intersect_point(parameters)
		if result.size()>0:
			return result[0].collider.get_parent()
		return null

func updateCarcCoordinates():
	var mouse = get_global_mouse_position()
	var sprite = cardBeingDragged.get_node("cardImage")
	var offSet_y = (sprite.get_texture().get_height() * sprite.get_scale().y) /2
	var offSet_x = (sprite.get_texture().get_width() * sprite.get_scale().x) /2
	cardBeingDragged.position = Vector2(clamp(mouse.x, 0 + offSet_x, screenSize.x - offSet_x), 
	clamp(mouse.y,0 + offSet_y , screenSize.y - offSet_y))
