extends Area2D

signal outOfLight

var moveDelay = 0.15
var maxLightRadius = 5.0

onready var light1 = $Light2D
onready var light2 = $Light2D2
onready var moveTween = $MoveTween
onready var spr = $Sprite

func _ready():
	setLightRadius(maxLightRadius)

func setLightRadius(newRadius):
	light1.texture_scale = newRadius
	light2.texture_scale = newRadius

func _physics_process(delta):
	# Move
	moveTween.interpolate_property(self,"position",position,get_global_mouse_position(),moveDelay,Tween.TRANS_LINEAR,Tween.EASE_IN)
	if not moveTween.is_active():
		moveTween.start()
	#
	
	#Angle
	var angle = (get_global_mouse_position() - position).angle() + PI/2
	spr.rotation = angle
	#
	
	# Reduce light
	if light1.texture_scale >= Global.difficulty["lightDecay"]:
		light1.texture_scale -= Global.difficulty["lightDecay"]
		light2.texture_scale -= Global.difficulty["lightDecay"]
	else:
		emit_signal("outOfLight")
	#
	
func die():
	set_physics_process(false)
	$CollisionShape2D.disabled = true
	$Sprite.hide()
	$TrailParticles.hide()
	$DeathParticles.emitting = true
	$DeathSound.play()