extends Panel

@onready var slide_animation: AnimationPlayer = $slideAnimation

func _ready() -> void:
	slide_animation.play("slide_out_left")

@onready var button: Button = $Button
@onready var disable_time: Timer = $disableTime
var close = true
func _on_button_pressed() -> void:
	pass # Replace with function body.
	if close:
		button.disabled = true
		slide_animation.play("slide_in_left")
		close = false
		disable_time.start()
		
	else:
		slide_animation.play("slide_out_left")
		close = true


func _on_disable_time_timeout() -> void:
	button.disabled = false
