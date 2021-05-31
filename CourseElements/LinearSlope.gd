extends Area2D

func _on_SlopeArea_body_entered(body):
	if body is GolfBall:
		body.slopeCount += 1
		print("Slope entered")

func _on_SlopeArea_body_exited(body):
	if body is GolfBall:
		body.slopeCount -= 1
		print("Slope exited")
