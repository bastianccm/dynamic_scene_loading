extends Node2D

const SwitchRoom = preload("res://switch_room.gd")

signal switch(next_room: String, above: bool)

func _ready() -> void:
	for child in find_children("*"):
		var switch_room := child as SwitchRoom
		if child is SwitchRoom:
			switch_room.body_entered.connect(_next_room.bind(switch_room.next_room, switch_room.above))

func _next_room(_body: Node2D, next_room: String, above: bool) -> void:
	switch.emit(next_room, above)
