extends HUD

signal start_game


func _on_NewRun_pressed():
	emit_signal("start_game")

func set_summary(collected, missed, penalty, total):
	$Summary/Collected/Amount.text = str(collected)
	$Summary/Missed/Amount.text = str(missed)
	$Summary/Penalty/Amount.text = str(penalty)
	$Summary/Total/Amount.text = str(total)
