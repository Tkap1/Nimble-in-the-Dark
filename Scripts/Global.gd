extends Node

var width = 1024
var height = 600

var currentScene

# Scenes
var mainSc = preload("res://Scenes/MainMenu.tscn")
var gameSc = preload("res://Scenes/Game.tscn")
var loseSc = preload("res://Scenes/Lose.tscn")
#

var difficulties = {
	"easy":
	{
		"func": funcref(self,"getValue"),
		"projectileDelay": 0.6,
		"speed": [200,600],
		"radius": [10,20],
		"lightDecay" : 0.01,
		"lightRespawnDelay": 3.0
	},
	"medium":
	{
		"func": funcref(self,"getValue"),
		"projectileDelay": 0.4,
		"speed": [150,700],
		"radius": [15,25],
		"lightDecay" : 0.02,
		"lightRespawnDelay": 2.0
	},
	"hard":
	{
		"func": funcref(self,"getValue"),
		"projectileDelay": 0.25,
		"speed": [100,750],
		"radius": [20,30],
		"lightDecay" : 0.03,
		"lightRespawnDelay": 1.5
	},
	"insane":
	{
		"func": funcref(self,"getValue"),
		"projectileDelay": 0.1,
		"speed": [50,800],
		"radius": [25,35],
		"lightDecay" : 0.04,
		"lightRespawnDelay": 1.0
	},
	"brutal":
	{
		"func": funcref(self,"getValue"),
		"projectileDelay": 0.05,
		"speed": [50,800],
		"radius": [25,35],
		"lightDecay" : 0.05,
		"lightRespawnDelay": 0.5
	}
}
var difficulty

var spawnLocations = {
	"left":
	{
		"func": funcref(self,"getValue"),
		"x": [0,0],
		"y": [0,height],
		"xVel": [1,1],
		"yVel": [-1,1]
	},
	"right":
	{
		"func": funcref(self,"getValue"),
		"x": [width,width],
		"y": [0,height],
		"xVel": [-1,-1],
		"yVel": [-1,1]
	},
	"top":
	{
		"func": funcref(self,"getValue"),
		"x": [0,width],
		"y": [0,0],
		"xVel": [-1,1],
		"yVel": [1,1]
	},
	"bottom":
	{
		"func": funcref(self,"getValue"),
		"x": [0,width],
		"y": [height,height],
		"xVel": [-1,1],
		"yVel": [-1,-1]
	},
}

var timeToWin = 60
var timeSurvived = 0

func _ready():
	currentScene = get_tree().current_scene
	
func setScene(new, init=false, value=0):
	call_deferred("changeScene",new.instance(),init,value)

func changeScene(newScene, init=false, value=0):
	currentScene.free()
	currentScene = newScene
	get_tree().get_root().add_child(currentScene)
	get_tree().set_current_scene(currentScene)
	if init:
		currentScene.init(value)
		
func setDifficulty(difficulty):
	self.difficulty = difficulties[difficulty]
	setScene(gameSc)
	
func getValue(minVal,maxVal):
	return rand_range(minVal,maxVal)