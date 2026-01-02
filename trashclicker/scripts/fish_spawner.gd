extends Node

var randomTimeSpawn : Array[int] = [1, 2]
var spawnObject = preload("res://scenes/fish.tscn")

@onready var spawn_timer: Timer = $SpawnTimer
var spawnTime = randi_range(randomTimeSpawn[0], randomTimeSpawn[1])
func _ready() -> void:
	spawn_timer.start(spawnTime)

func spawn(body : StaticBody2D) -> void:
	var obj = spawnObject.instantiate()
	obj.position.x = body.position.x
	var line = body.get_child(0)
	obj.position.y = randf_range(line.shape.get_a().y, line.shape.get_b().y)
	if body == left_spawner:
		obj.side = -1
	add_child(obj)

@onready var right_spawner: StaticBody2D = $RightSpawner
@onready var left_spawner: StaticBody2D = $LeftSpawner
func _on_spawn_timer_timeout() -> void:
	spawnTime = randi_range(randomTimeSpawn[0], randomTimeSpawn[1])
	spawn_timer.wait_time = spawnTime
	var side_line = randi_range(0, 1)
	if side_line == 0:
		spawn(right_spawner)
	else:
		spawn(left_spawner)
	
