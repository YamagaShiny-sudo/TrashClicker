extends Button

@onready var score_label = $"../score_label"
@onready var click_button = $"." 

# This variable will store the actual number (integer)
var score = 0

func _ready():
	#Initialiser le score avec label
	score = int(score_label.text)
	
	#Mettre le signal du boutton appuyer sur la fonction "_on_click_button_pressed"
	click_button.pressed.connect(self._on_click_button_pressed)

#Lance cette fonction a chaque click
func _on_click_button_pressed():
	#Ajout de point à la variable score
	score += 1
	
	#Met à jour l'affichage du score
	score_label.text = str(score)
