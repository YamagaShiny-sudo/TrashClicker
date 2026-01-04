extends PanelContainer


@export var build_cost : int = 2
@export var build_output : int = 1
@export var build_label: Label
@export var build_name : String = "Building"
@export var build_button : TextureButton

@onready var build_timer : Timer = %BuildTimer
var total_output : int = 0

func _ready() -> void:
	build_button.pressed.connect(_on_build_upgrade_button_pressed)
	build_timer.timeout.connect(_on_build_timer_timeout)
	build_label.text = build_name + "\nCost: " + str(build_cost) + "\nOutput: " + str(build_output)


@onready var hud: Node = $"../../../../.."
func _on_build_upgrade_button_pressed() -> void:
	if hud.trash_score >= build_cost:
		hud.subScore(build_cost)
		total_output += build_output
		build_cost += 1
		build_label.text = build_name + "\nCost: " + str(build_cost) + "\nOutput: " + str(total_output)

#Building adding score
func _on_build_timer_timeout() -> void:
	hud.addScore(total_output)
