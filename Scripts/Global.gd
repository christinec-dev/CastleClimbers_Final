### Global.gd

extends Node

#movement states
var is_attacking = false
var is_climbing = false
var is_jumping = false

# Indicates if box can be spawned
var can_spawn = true

#current scene
var current_scene_name

#bomb movement state
var is_bomb_moving = false

#pickups
enum Pickups {HEALTH, SCORE, ATTACK}

#can the player be damaged?
var can_hurt = true

#final level results
var final_score
var final_rating
var final_time

#path to save the game
const SAVE_PATH = "user://savegame.save"

func _ready():
	# Sets the current scene's name
	var scene_name = get_tree().get_current_scene().name
	current_scene_name = clean_scene_name(scene_name)

# Function to disable box spawning
func disable_spawning():
	can_spawn = false

# Function to enable box spawning
func enable_spawning():
	can_spawn = true

# Current level based on scene name
func get_current_level_number():
	if current_scene_name == "Main" || current_scene_name == "MainMenu":
		return 1
	elif current_scene_name.begins_with("Main_"):
		# Extract the number after "Main_"
		var level_number = current_scene_name.get_slice("_", 1).to_int()
		return level_number
	else:
		return -1 # Indicate an unknown scene
		
#removes the @x@n from our name
func clean_scene_name(scene_name):
	var at_position = scene_name.find("@")
	if at_position != -1:
		# Extract the portion of the string before the "@" character
		return scene_name.substr(0, at_position)
	else:
		# If "@" character is not found, return the original string
		return scene_name
		
# Function to save the game
func save_game():
	var save_file = ConfigFile.new()
	# Save the current level
	save_file.set_value("level", "current_level", "res://Scenes/" + Global.current_scene_name + ".tscn")
	# Save the file
	var err = save_file.save(SAVE_PATH)
	# Err handling
	if err != OK:
		print("An error occurred while saving the game")
	else:
		print("Saving game.")
	
# Function to load the game
func load_game():
	var save_file = ConfigFile.new()
	var err = save_file.load(SAVE_PATH)

	# Check if the save file exists and is successfully loaded
	if err == OK:
		# Get the full path to the current level from the save file
		var saved_level = save_file.get_value("level", "current_level", "res://Scenes/Main.tscn")
		# Load and instantiate the saved scene
		var new_scene_resource = load(saved_level)
		var new_scene = new_scene_resource.instantiate()
		# Add it to the root of the scene tree
		get_tree().get_root().add_child(new_scene)
		# Set it as the current scene
		get_tree().current_scene = new_scene
		#update current scene name
		current_scene_name = get_tree().get_current_scene().name
		clean_scene_name(current_scene_name)
		#notify
		print("Loading game.")
	else:
		print("An error occurred while loading the game")


