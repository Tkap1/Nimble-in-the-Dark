extends Area2D

signal areaEntered

var rotationSpeed = 0.025

func _on_LightBooster_area_entered(area):
	emit_signal("areaEntered",self,area)

func _physics_process(delta):
	$Sprite.rotation += rotationSpeed

func die():
	$Particles2D.emitting = true
	$Sprite.hide()
	$Light2D.hide()
	$PickupSound.play()
	$CollisionShape2D.disabled = true

func _on_PickupSound_finished():
	queue_free()
