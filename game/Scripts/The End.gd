extends DirectionalLight

onready var sundemon = $DirectionalLight
var x = 0
var y = 0
var z = 0
var velocity = Vector3()


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	
func _fixed_process(delta):
	velocity.y = velocity.y - 5
	

	
