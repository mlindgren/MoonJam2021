extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	self.gravity_vec = self.gravity_vec.rotated(self.rotation)

func _on_SlopeArea_body_entered(body):
	if body is GolfBall:
		body.slopeCount += 1
		print("Slope entered")

func _on_SlopeArea_body_exited(body):
	if body is GolfBall:
		body.slopeCount -= 1
		print("Slope exited")
