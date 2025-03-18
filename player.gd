extends Area2D
signal hit

# how fast the player will move (px/sec)
@export var speed = 400 
var screen_size

func _ready():
    screen_size = get_viewport_rect().size

    hide() # player is invisible when the game start

# process is called every frame
func _process(delta):
    var velocity = Vector2.ZERO # player's movement vector
    if Input.is_action_pressed("move_right"):
        velocity.x += 1
    if Input.is_action_pressed("move_left"):
        velocity.x -= 1
    if Input.is_action_pressed("move_up"):
        velocity.y -= 1
    if Input.is_action_pressed("move_down"):
        velocity.y += 1
    
    if velocity.length() > 0:
        velocity = velocity.normalized()*speed
        $AnimatedSprite2D.play()
    else:
        $AnimatedSprite2D.stop()
    
    position += velocity * delta
    
    # clamp the pos value so that it does not leave screen
    position = position.clamp(Vector2.ZERO, screen_size)

    if velocity.x != 0:
        $AnimatedSprite2D.animation = "walk"
        $AnimatedSprite2D.flip_v = false
        $AnimatedSprite2D.flip_h = velocity.x < 0

    if velocity.y != 0:
        $AnimatedSprite2D.animation = "up"
        $AnimatedSprite2D.flip_h = false
        $AnimatedSprite2D.flip_v = velocity.y > 0




func _on_body_entered(_body:Node2D):
    hide() # player disappear after being hit
    hit.emit()

    # each time enemy hit, we disable the player's collision so that we don't trigger the hit signal more than once
    # we use "set_deferred" here because we don't want to disable collision right away, it can cause an error if we disable in the middle of the engine's collision
    $CollisionShape2D.set_deferred("disabled", true) 

func start(pos):
    position = pos
    show()
    $CollisionShape2D.disabled = false