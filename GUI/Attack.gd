### Attack.gd

extends ColorRect

#ref to our label node
@onready var label = $Label

# updates label text when signal is emitted
func update_attack_boost(attack_time_left):
	label.text = str(attack_time_left)
