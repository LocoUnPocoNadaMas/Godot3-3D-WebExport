extends KinematicBody

var velocity: Vector3 = Vector3.ZERO
const SPEED: float = 5.0
const JUMP_VELOCITY: float = 4.5
var gravity: float = 9.8  # Asumiendo gravedad estándar (9.8 m/s^2)

func _ready() -> void:
	#var instance = load("res://Barbarian.tscn").instance()
	#add_child(instance)
	pass

func _physics_process(delta: float) -> void:
	# Agregar la gravedad.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Manejar el salto.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Obtener la dirección de entrada y manejar el movimiento/deceleración.
	# Como buena práctica, deberías reemplazar las acciones de UI con acciones de juego personalizadas.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)
		velocity.z = move_toward(velocity.z, 0, SPEED * delta)

	move_and_slide(velocity)
