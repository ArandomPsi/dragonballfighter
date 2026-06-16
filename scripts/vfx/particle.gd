extends GPUParticles2D
@export var ignoretimescale : bool = false
var last : float = -1

func _ready() -> void:
	emitting = true
	await finished
	queue_free()

func _process(delta: float) -> void:
	if ignoretimescale:
		if Engine.time_scale != last:
			last = Engine.time_scale
			speed_scale = 1.0 / Engine.time_scale
