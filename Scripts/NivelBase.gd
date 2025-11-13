extends Node2D

class_name NivelBase

signal update_pos();

# variavel para pegar todos os nós filhos na cena
onready var filhos:Array=get_children();

# variavel para receber todos os objetivos do nivel
onready var objetivos:Array=[];

# variavel para separar caixas
onready var caixas:Array=[];
onready var qtd_caixas:int;

onready var conta_caixas:int;

# variaveis das caixas de dialogo de fim do nivel
onready var confirma:WindowDialog;
onready var fim:WindowDialog;

# variavel que define ultimo nivel
onready var ultimo:int=0;

# variavel que guarda o proximo nivel
onready var proximo:String;


func _ready():
	connect("update_pos", self, "_on_update_pos");
	
	for i in filhos:
		if i.name=="Objetivo":
			objetivos=i.posicoes;
		
		elif i.is_in_group("caixa"):
			caixas.append(i);
			
		elif i is WindowDialog:
			if i.name=="Proximo":
				confirma=i;
				
			elif i.name=="Fim":
				fim=i;
				
			else:pass;
			
		else:pass;
	
	qtd_caixas=caixas.size();
	
	
func _process(delta):
	nivel_comands();
	verifica();
	

func nivel_comands():
	if Input.is_action_just_pressed("volta"):
		for i in filhos:
			if i is KinematicBody2D:
				i.position=i.ultima_pos;
				
	
	if Input.is_action_just_pressed("reinicia"):
		for i in filhos:
			if i is KinematicBody2D:
				i.position=i.inicial_pos;
				i.ultima_pos=i.inicial_pos;
	
	
	
func verifica():
	conta_caixas=0;
	
	for i in caixas:
		if objetivos.has(i.position):
			i.certo=true;
			conta_caixas+=1;
			
		else:
			i.certo=false;
			
	
	if conta_caixas==qtd_caixas:
		if !ultimo:
			confirma.visible=true;
			
		else:
			fim.visible=true;
			
			
func _on_update_pos():
	for i in caixas:
		if !i.andou:
			i.ultima_pos=i.position;
			
		else:
			i.andou=false;
			
			
func _on_Proximo_pressed():
	get_tree().change_scene(proximo);


func _on_Menu_pressed():
	get_tree().change_scene("menu"); #mudar para cena menu
