### BoxSpawner.gd

extends Node2D

# Box scene reference
var box = preload("res://Scenes/Box.tscn")

# References to our scene, PathFollow2D path, and AnimationPlayer path
var box_path
var box_animation

# Allows us to flip our pigs around in the editor
@export var flip_h = false
@export var flip_v = false
	
# When it's loaded into the scene
func _ready():
	# Initiates paths
	box_path = $BoxPath/Path2D/PathFollow2D
	box_animation = $BoxPath/Path2D/AnimationPlayer
	#enables box movement on path on load
	box_animation.play("box_movement")
	#default animation on load
	$AnimatedSprite2D.play("pig_throw")
 
func _process(delta):
	#allow us to flip the pigs around in editor
	$AnimatedSprite2D.flip_h = flip_h
	$AnimatedSprite2D.flip_v = flip_v
	
	# Check if the boxes have reached the end of the path
	if box_path.progress_ratio >= 1:
		#respawn box
		box_path.progress_ratio = 0
		Global.enable_spawning()
		box_animation.play("box_movement")	
		
	#play throwing animation if path resets	
	if box_path.progress_ratio == 0:	
		$AnimatedSprite2D.play("pig_throw")
				
# Shoot and spawn box onto path
func _on_timer_timeout():
	# Reset animation back to idle if not throwing
	$AnimatedSprite2D.play("pig_idle")
	
	# Spawns a box onto our path if there are no boxes available and can_spawn is True
	if box_path.get_child_count() <= 0 and Global.can_spawn == true:
		var spawned_box = box.instantiate()
		box_path.add_child(spawned_box)
		


