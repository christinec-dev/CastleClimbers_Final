### Bomb.gd 

extends Area2D

var rotation_speed = 10

#default animation on spawn
func _ready():
	$AnimatedSprite2D.play("moving")
	
func _on_body_entered(body):
	#if the bomb collides with the player, play the explosion animation and start the timer
	if body.name == "Player":
		$AnimatedSprite2D.play("explode")
		$Timer.start()
		Global.is_bomb_moving = false
		#deal damage
		if Global.can_hurt == true:
			body.take_damage()
			Global.is_climbing = false
			Global.is_jumping = false
			
	#OPTION 1	
	#if the bomb collides with our Level Tilemap (floor and walls). 
	if body.name == "Level":
		$AnimatedSprite2D.play("explode")
		$Timer.start()
		Global.is_bomb_moving = false
		
	#OPTION 2	
	#if the bomb collides with our Wall scene, explode and remove
	if body.name.begins_with("Wall"):
		$AnimatedSprite2D.play("explode")
		$Timer.start()
		Global.is_bomb_moving = false

#remove the bomb from the scene only if the Bomb exists
func _on_timer_timeout():
	if is_instance_valid(self):
		self.queue_free()

#rolls the bomb
func _physics_process(delta):
	# Rotate the bomb if it hasn't exploded
	if Global.is_bomb_moving == true:
		$AnimatedSprite2D.rotation += rotation_speed * delta
