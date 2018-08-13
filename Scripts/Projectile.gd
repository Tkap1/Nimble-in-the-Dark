extends Area2D

signal areaEntered

var velocity
var speed
var radius
var baseSprSize = 128

onready var sprIn = $SpriteCore
onready var sprOut = $SpriteOutter
onready var coll = $CollisionShape2D

func _ready():
	var keys = Global.spawnLocations.keys()
	var spawn = Global.spawnLocations[keys[randi()%keys.size()]]
	position = Vector2(spawn["func"].call_func(spawn["x"][0],spawn["x"][1]),spawn["func"].call_func(spawn["y"][0],spawn["y"][1]))
	velocity = Vector2(spawn["func"].call_func(spawn["xVel"][0],spawn["xVel"][1]),spawn["func"].call_func(spawn["yVel"][0],spawn["yVel"][1])).normalized()
	speed = Global.difficulty["func"].call_func(Global.difficulty["speed"][0],Global.difficulty["speed"][1])
	radius = Global.difficulty["func"].call_func(Global.difficulty["radius"][0],Global.difficulty["radius"][1])
	coll.shape = CircleShape2D.new()
	coll.shape.radius = radius
	var newScale = radius*2 / baseSprSize
	var newColor = Color(rand_range(0,1),rand_range(0,1),rand_range(0,1))
	sprIn.scale = Vector2(newScale,newScale)
	sprOut.scale = Vector2(newScale,newScale)
	sprOut.modulate = newColor
	$Light2D.texture_scale = newScale / 2
	$Light2D.color = newColor
	

func _physics_process(delta):
	position += velocity * speed * delta

func _on_Projectile_area_entered(area):
	emit_signal("areaEntered",self,area)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
