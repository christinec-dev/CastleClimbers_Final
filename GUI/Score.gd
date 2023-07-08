### Score.gd

extends ColorRect

#ref to our label node
@onready var label = $Label

# updates label text when signal is emitted
func update_score(score):
	label.text = str(score)
