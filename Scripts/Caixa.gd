extends KinematicBody2D

class_name Caixa

# declarando siganal de movimento da caixa
signal anda(lado,emissor);

# definindo variaveis de posição
onready var inicial_pos:Vector2;
onready var ultima_pos:Vector2;

# variavel para reajuste em caso de colisão
onready var volta:Vector2;

# variavel para detectar colisoes
onready var move:KinematicCollision2D;

# variavel para identificar se a caixa foi movida
onready var andou:bool;

# variavel para identificar se a caixa esta no local marcado
onready var certo:bool;

# variavel que pega o caminho do sprite do objeto e referencia seu objeto
export(NodePath) onready var sprite=get_node(sprite);


func _ready():
	# adicionando objeto caixa a um grupo de mesmo nome
	add_to_group("caixa");
	
	# conectando signal anda ao codigo
	connect("anda",self,"_on_anda");
	
	inicial_pos=position;
	ultima_pos=inicial_pos;
	
	
func _process(delta):
	if certo:
		sprite.modulate=Color("12e511");
	else:
		sprite.modulate=Color("ffffff");
		
		
func _on_anda(lado, emissor):
	volta=position;
	
	if lado==4:
		move=move_and_collide(Vector2(-16,0));
		
	if lado==6:
		move=move_and_collide(Vector2(16,0));
		
	if lado==8:
		move=move_and_collide(Vector2(0,-16));
		
	if lado==2:
		move=move_and_collide(Vector2(0,16));
		
	
	if move:
		position=volta;
	else:
		if fmod(position.x,8)!=0 or fmod(position.y,8)!=0:
			position=volta;
		else:
			andou=1;
			ultima_pos=volta;
			emissor.emit_signal("ajusta",ultima_pos);
