### Health.gd

extends ColorRect

#ref to our label node
@onready var label = $Label

# updates label text when signal is emitted
func update_lives(lives):
	label.text = str(lives)
