### Ladder.gd
extends Area2D

#sets is_climbing to true to simulate climbing
func _on_body_entered(body):
	if body.name == "Player":
		Global.is_climbing = true

#sets is_climbing to false to simulate climbing
func _on_body_exited(body):
	if body.name == "Player":
		Global.is_climbing = false
		
