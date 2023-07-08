### LevelDoor.gd

extends Area2D

# Allows us to change the scene (level) we want to go to in the editor properties
@export var next_level: PackedScene

func _ready():
	#hide menu
	$UI/Menu.visible = false
	
func _on_body_entered(body):
	if body.name == "Player":
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) 
		# pause game
		get_tree().paused = true
		# show menu
		$UI/Menu.visible = true
		# make modular value visible
		$AnimationPlayer.play("ui_visibility")	
		#hide the player's UI 
		body.get_node("UI").visible = false	
		#get final values
		body.final_score_time_and_rating()
		# show player values
		$UI/Menu/Container/TimeCompleted/Value.text = str(Global.final_time)
		$UI/Menu/Container/Score/Value.text = str(Global.final_score)
		$UI/Menu/Container/Ranking/Value.text = str(Global.final_rating)
		#play music
		$Music/LevelUpMusic.play()
		
func _on_continue_button_pressed():
	#unpause scene
	get_tree().paused = false
	#hide menu
	$UI/Menu.visible = false
	# Change to the next scene
	get_tree().change_scene_to_packed(next_level)
	# Extract the name of the packed scene file and update the current scene's name in the Global script
	var path = next_level.resource_path
	var scene_name = path.get_file().split(".")[0]
	Global.current_scene_name = scene_name

func _on_restart_button_pressed():
	if Global.get_current_level_number() > 1:
		#unpause scene
		get_tree().paused = false
	#hide menu
	$UI/Menu.visible = false
	# Restart current scene
	get_tree().reload_current_scene()
