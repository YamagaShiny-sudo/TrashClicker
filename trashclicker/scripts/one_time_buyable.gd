extends ScrollContainer

@onready var hud = get_node("../../..")


@onready var power_upgrade_button: PanelContainer = $VBoxContainer/HBoxContainer/Power
var up_cost = 10
func _on_button_pressed() -> void:
	if hud.trash_score >= up_cost:
		hud.trash_score -= up_cost
		hud.build_output_1 += 10
		power_upgrade_button.hide()
		hud.update_text()
