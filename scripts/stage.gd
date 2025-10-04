extends StaticBody2D

func _ready():
	# Assign a rectangle shape at runtime to avoid parser errors
	if $CollisionShape2D.shape == null:
		var rect = RectangleShape2D.new()
		rect.size = Vector2(1000,50)
		$CollisionShape2D.shape = rect
	print("Stage loaded!")
