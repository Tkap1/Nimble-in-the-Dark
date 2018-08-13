extends Container



func _on_Diff1_pressed():
	Global.setDifficulty("easy")

func _on_Diff2_pressed():
	Global.setDifficulty("medium")

func _on_Diff3_pressed():
	Global.setDifficulty("hard")

func _on_Diff4_pressed():
	Global.setDifficulty("insane")
	
func _on_Diff5_pressed():
	Global.setDifficulty("brutal")
