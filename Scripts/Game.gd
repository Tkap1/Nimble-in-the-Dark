extends Node2D

var playerSc = preload("res://Scenes/Player.tscn")
var lightBoosterSc = preload("res://Scenes/LightBooster.tscn")
var projectileSc = preload("res://Scenes/Projectile.tscn")
var player

func _ready():
	player = playerSc.instance()
	player.position = Vector2(Global.width/2,Global.height/2)
	player.connect("outOfLight",self, "_playerOutOfLight")
	add_child(player)
	$TimerProjectile.wait_time = Global.difficulty["projectileDelay"]
	$TimerProjectile.start()
	$TimerBooster.wait_time = Global.difficulty["lightRespawnDelay"]
	$TimerBooster.start()
	Global.timeSurvived = 0


func _on_TimerBooster_timeout():
	var lightBooster = lightBoosterSc.instance()
	lightBooster.connect("areaEntered",self, "_lightBoosterAreaEntered")
	add_child(lightBooster)
	lightBooster.position = Vector2(rand_range(0,Global.width),rand_range(0,Global.height))
	
func _lightBoosterAreaEntered(booster,area):
	if area == player:
		booster.die()
		player.setLightRadius(player.maxLightRadius)

func _on_TimerProjectile_timeout():
	var projectile = projectileSc.instance()
	projectile.connect("areaEntered",self, "_projectileAreaEntered")
	add_child(projectile)
	
func _projectileAreaEntered(projectile,area):
	if area == player:
		$TimerDeath.start()
		player.die()

func _on_TimerSurvive_timeout():
	Global.timeSurvived += 1
	if Global.timeSurvived == Global.timeToWin:
		$WinSound.play()
	$TimeLabel.text = "Time: " + str(Global.timeSurvived)

func _playerOutOfLight():
	$TimerDeath.start()
	player.die()

func _on_TimerDeath_timeout():
	Global.setScene(Global.loseSc)
