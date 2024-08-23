extends Node2D

const Room = preload("res://room.gd")

@onready var rooms := $Rooms as Node2D
@onready var player := $Character as Node2D

var lowest := 0
var highest := 0

const ROOM_SIZE := 640

func _load_scene(path: String, above: bool) -> void:
	var must_load := false
	var current: int = (int(player.global_position.y) - posmod(int(player.global_position.y), ROOM_SIZE)) / ROOM_SIZE
	if above and current == highest:
		must_load = true
		highest -= 1
	elif !above and current == lowest:
		must_load = true
		lowest += 1

	prints("player is in room %d, lowest: %d, highest: %d, must_load: %s, direction: %s" % [current, lowest, highest, must_load, "above" if above else "below"])

	if !must_load:
		return

	var packed_scene := load(path) as PackedScene
	var new_scene := packed_scene.instantiate() as Room
	new_scene.global_position = Vector2(0, ROOM_SIZE * (highest if above else lowest))
	new_scene.switch.connect(_load_scene)
	rooms.add_child.call_deferred(new_scene)
