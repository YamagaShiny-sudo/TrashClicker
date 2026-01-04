extends PanelContainer


@export var build_cost : float = 2
@export var build_output : float = 1
@export var build_label: Label
@export var build_name : String = "Building"
@export var build_button : TextureButton

@onready var build_timer : Timer = %BuildTimer
var total_output : float = 0
var total_cost : float = build_cost
var mult_cost : float = 1.1
var level : int = 0

func _ready() -> void:
	build_button.pressed.connect(_on_build_upgrade_button_pressed)
	build_timer.timeout.connect(_on_build_timer_timeout)
	build_label.text = build_name + " | Lvl: " + str(level) + "\nCost: " + format_build(build_cost) + "\nOutput: " + format_build(build_output)


@onready var hud: Node = $"../../../../.."
func _on_build_upgrade_button_pressed() -> void:
	if hud.trash_score >= total_cost:
		hud.subScore(total_cost)
		level += 1
		total_output = build_output * level
		total_cost = build_cost * (mult_cost ** level)
		build_label.text = build_name + " | Lvl: " + str(level) + "\nCost: " + format_build(total_cost) + "\nOutput: " + format_build(total_output)

#Building adding score
func _on_build_timer_timeout() -> void:
	hud.addScore(total_output)

func format_build(number : float) -> String:
	return hud.format(number)
