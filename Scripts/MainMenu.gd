### MainMenu.gd

extends CanvasLayer

func _ready():
	#pause it by default 
	get_tree().paused = true
	#show cursor
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) 
	#play background music
	$Music/BackgroundMusic.play()
			
#starts a new game in the Main scene, which is our 1st level
func _on_button_new_pressed():
	# Get the current scene
	var current_scene = get_tree().current_scene
	# Free the current scene if it exists
	if current_scene:
		current_scene.queue_free()
	# Load the new scene
	var new_scene = load("res://Scenes/Main.tscn").instantiate()
	# Add the new scene as a child of the root node
	get_tree().root.add_child(new_scene)
	# Set the new scene as the current scene
	get_tree().set_current_scene(new_scene)
	# Update the global variable with the name of the new scene
	Global.current_scene_name = new_scene.name
	# Ensures scene isn't paused if it isn'the first level
	if Global.get_current_level_number() > 1:
		get_tree().paused = false
		#show cursor
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) 
		
#quit game
func _on_button_quit_pressed():
	get_tree().quit()
	
#load game
func _on_button_load_pressed():
	# Get the current scene
	var current_scene = get_tree().current_scene
	# Free the current scene if it exists
	if current_scene:
		current_scene.queue_free()
	
	# Load the main scene and its saved state
	var game = Global.load_game()
	
	# Set its loading state to true
	game.loading = true 
	
	# Add the new scene as a child of the root node
	get_tree().root.add_child(game)

	# Set the new scene as the current scene
	get_tree().set_current_scene(game)

	# Update the global variable with the name of the new scene
	Global.update_scene_name()
	
	# Remove main menu scene
	queue_free()

