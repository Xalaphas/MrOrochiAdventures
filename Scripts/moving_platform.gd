extends Node2D

const WAIT_DURANTION := 1.0

@onready var platform := $platform as AnimatableBody2D
@export var move_speed := 3.0
@export var distance := 192
@export var move_horizontal := true

var follow := Vector2.ZERO
var platform_center := 16

func _ready():
	move_platform()

func _physics_process(_delta: float) -> void:
	platform.position = platform.position.lerp(follow, 0.5)

func move_platform():
	var _move_direction = Vector2.RIGHT * distance if move_horizontal else  Vector2.UP * distance
	var _duration = _move_direction.length() / float(move_speed * platform_center)

	var _platform_tween = create_tween().set_loops().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	_platform_tween.tween_property(self, "follow", _move_direction, _duration).set_delay(WAIT_DURANTION)
	_platform_tween.tween_property(self, "follow", Vector2.ZERO, _duration).set_delay(_duration + WAIT_DURANTION * 2)
