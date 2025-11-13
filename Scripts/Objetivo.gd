extends TileMap

onready var posicoes:Array=[];

func _ready():
	var celulas=get_used_cells();
	
	for i in celulas:
		posicoes.append(i*16+Vector2(8,8));
