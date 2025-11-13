extends KinematicBody2D

class_name Player

# signal para mover o player junto a caixa
signal ajusta(local);

# variaveis para reinicio do nivel e para retornar um movimeto
onready var inicial_pos:Vector2;
onready var ultima_pos:Vector2;

# variavel para reajuste em caso de colisão
onready var volta:Vector2;

# variavel para detectar colisoes
onready var move:KinematicCollision2D;

# variavel para movimento da caixa
onready var lado:int;

# bloco execultado assim que o codigo roda
func _ready():
	# passando posição do objeto para marcar como inicial e para ultima_pos
	inicial_pos=position;
	ultima_pos=position;
	
	# conectando signals ao codigo para que possa ser usado
	connect("ajusta",self,"_on_ajusta");
	
# bloco execultado a cada frame do codigo
func _process(delta):
	anda();
	
	
# bloco de codigo que define movimentação do player
func anda():
	# difinindo move como null e lado como 0 para previnir erros
	move=null;
	lado=0;
	
	# verificação dos inputs do jogador
	# is_action_just_pressed verifica se a tecla foi pressionada
	if Input.is_action_just_pressed("direita"):
		volta=position;
		lado=6;
		move=move_and_collide(Vector2(16,0));
		
	if Input.is_action_just_pressed("esquerda"):
		volta=position;
		lado=4;
		move=move_and_collide(Vector2(-16,0));
		
	if Input.is_action_just_pressed("cima"):
		volta=position;
		lado=8;
		move=move_and_collide(Vector2(0,-16));
		
	if Input.is_action_just_pressed("baixo"):
		volta=position;
		lado=2;
		move=move_and_collide(Vector2(0,16));
		
		
	# bloco para ajuste do player
	if lado:
		# fmod é uma função para pegar o resto da divisão nativa da godot engine
		if fmod(position.x,8)!=0 or fmod(position.y,8):
			# verificando se o player esta desalinhado em relação a grade
			position=volta;
		else:pass;
		
		# bloco de verificação de colisão do movimento
		if move:
			if move.collider is KinematicBody2D and move.collider.has_signal("anda"):
				move.collider.emit_signal("anda",lado,self);
			else:pass;
			
		else:
			ultima_pos=volta;
			# emite signal para no pai
			get_parent().emit_signal("update_pos");
			
			
func _on_ajusta(local):
	ultima_pos=position;
	position=local;
	get_parent().emit_signal("update_pos");
