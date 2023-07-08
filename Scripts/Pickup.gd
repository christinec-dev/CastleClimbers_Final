### Pickup.gd

#When you add at the top of a script the tool keyword, it will be executed not only during the game, but also in the editor.
@tool

extends Area2D

#pickups enum
@export var pickup : Global.Pickups

#texture assets for our pickup
var health_texture = preload("res://Assets/heart/heart/sprite_0.png")
var score_texture = preload("res://Assets/star/star/sprite_04.png")
var attack_boost_texture = preload("res://Assets/lightning bolt/lightning bolt/sprite_0.png")

#reference to our Sprite2D texture
@onready var pickup_texture = get_node("Sprite2D")

#allow us to change the sprite texture in the editor
func _process(_delta):
	if Engine.is_editor_hint():
		if pickup == Global.Pickups.HEALTH:
			pickup_texture.set_texture(health_texture)
		elif pickup == Global.Pickups.SCORE:
			pickup_texture.set_texture(score_texture)
		elif pickup == Global.Pickups.ATTACK:
			pickup_texture.set_texture(attack_boost_texture)

#changes pickup texture in game screen		
func _ready():
	if pickup == Global.Pickups.HEALTH:
		pickup_texture.set_texture(health_texture)
	elif pickup == Global.Pickups.SCORE:
		pickup_texture.set_texture(score_texture)
	elif pickup == Global.Pickups.ATTACK:
		pickup_texture.set_texture(attack_boost_texture)

#removes the pickup from the game scene tree
func _on_body_entered(body):
	if body.name == "Player":
		get_tree().queue_delete(self)
		#adds pickup to player to change player stats
		body.add_pickup(pickup)

