extends Container

onready var timeLabel = $VBoxContainer/TimeLabel

func _ready():
	if Global.timeSurvived == 1:
		timeLabel.text = "You surived 1 second!"
	else:
		timeLabel.text = "You surived " +str(Global.timeSurvived)+" seconds!"
	if Global.timeSurvived >= Global.timeToWin:
		$VBoxContainer/LabelOutcome.text = "You win!"


func _on_RetryButton_pressed():
	Global.setScene(Global.gameSc)

func _on_DifficultyButton_pressed():
	Global.setScene(Global.mainSc)
