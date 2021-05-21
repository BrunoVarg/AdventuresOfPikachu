.data
.text
#################################
#			        #
#	    PRINT		#
#			        #
#################################

.macro print_background(%label)
	li t1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00	# endereco final - Frame 0
	li t3,0
	bgtz  t0, SOMA_PB
	j INICIO_PB
SOMA_PB:
	li t0, 0x00100000
	add t1,t1,t0		# Endereço Inicial - Frame 1 - 0xFF100000
	add t2,t2,t0		# Endereço Final - Frame 1 - 0xFF112C00
INICIO_PB:
	 
	la s1,%label		# endereço dos dados da tela na memoria
	addi s1,s1,8		# primeiro pixels depois das informações de nlin ncol
LOOP1_PB: beq t1,t2,FIM_PB	# Se for o último endereço então sai do loop
	lw t3,0(s1)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na memória VGA
	addi t1,t1,4		# soma 4 ao endereço
	addi s1,s1,4
	j LOOP1_PB		# volta a verificar
FIM_PB:

.end_macro

#################################
#				#
# 	   Frames		#
#				#
#################################

.macro change_frame()
	li s0,0xFF200604	# Escolhe o Frame 0 ou 1
	lw t2,0(s0)		# inicio Frame
	xori t2, t2, 1
	sw t2,0(s0)
.end_macro

.macro frame_atual()
	li s0, 0xFF200604
	lw t0, 0(s0)
.end_macro

.macro next_frame()
	li s0, 0xFF200604
	lw t2, 0(s0)
	xori t0, t2,1
.end_macro
	

#################################
#				#
#	Carrega valores		#
#   pra usar no PRINT_IMAGE	#
#				#
#################################

.macro load_values(%x,%y,%label)
li s2, %x
li s1, %y
la a1, %label
.end_macro

#################################
#				#
#	   Verifica		#
#   o caractere da KEYBOARD 	#
#				#
#################################

.macro verify(%char,%label)
li t1, %char
beq t1,t0,PASSOU
j FIM
PASSOU:
j %label
FIM:
.end_macro


#################################
#				#
# 	     CLEAN		#
#				#
#################################


.macro clean_image(%label)
mv s2, t1
mv s1, t2
la a1, %label
.end_macro


#################################
#				#
#	   MOVEMENTS		#
#				#
#################################

# Armazena X em t1, e Y em t2



.macro load_position(%label)
la a0, %label
lh t1, 0(a0)
lh t2, 2(a0)
.end_macro

.macro movement_y_up(%label)
addi s1,t2, -16
sh s1, 2(a0)
mv s2, t1
la a1,%label
.end_macro

.macro movement_y_down(%label)
addi s1,t2, 16
sh s1, 2(a0)
mv s2, t1
la a1,%label
.end_macro

.macro movement_x_left(%label)
addi s2,t1, -16
sh s2, 0(a0)
mv s1, t2
la a1, %label
.end_macro

.macro movement_x_right(%label)
addi s2,t1, 16
sh s2, 0(a0)
mv s1, t2
la a1, %label
.end_macro

#################################
#				#
#				#
#	   COLISÃO		#
#				#
#				#
#################################

.macro verifica_muro(%label)
la a2, MURO
lh t4, 2(a2)
lh t5, 6(a2)
lh t6, 0(a2)
lh s4, 4(a2)
ble s1,t4,%label
bge s1,t5,%label
ble s2,t6,%label
bge s2,s4,%label
.end_macro


#################################
#				#
#     Colisão de Blocos		#
# Borda Lateral = 71 (preto)	#
# Borda Superior = 24 (muro)	#
# Pixels = 16			#
# (X atual - Borda Lat.)/16     #
# (Y atual - Borda Sup.)/16     #
# 	Y*11 + X		#
#				#
#################################

# t0, s2,s1, a1
# Armazena em s7 o bloco atual
.macro bloco_atual()
li s7, 0
li s8, 71
li s9, 24
li s10, 16
li s11, 11
la a5, POSITION
lh s6, 0(a5)	# X
lh s4, 2(a5)	# Y
sub s6, s6, s8
sub s4, s4, s9
div s6, s6, s10
div s4, s4, s10
mul s7, s4, s11
add s7, s7, s6
.end_macro

#################################
#				#
#   Macro que verifica qual o	#
#	próximo bloco		#
#   comparando com a matriz	#
#				#
#  %Label = Matriz		#
#				#
#  %Condicional = Label que ele	#
#  vai pular caso for um bloco	#
#     que não pode passar	#
#				#
#################################

.macro verifica_bloco(%label, %condicional)
la a5, %label
add a5, a5, s7
lb t5, 0(a5)		# Bloco do Mapa que a Sprite estÃ¡
la s10, BLOCO_ATUAL 
sb t5, 0(s10)
la a2, BLOCOS_BLOQUEADOS
li t6, 16		# Tamanho dos BLOCOS_BLOQUEADOS
li s4, 0		# Contador
LOOP:
	beq s4, t6, FIM
	addi s4, s4, 1
	lb s6, 0(a2)
	beq t5, s6, %condicional
	addi a2, a2, 1
	j LOOP
FIM:

.end_macro

#################################
#				#
#   Macro que vai contar a 	#
#   quantidade de pokebola	#
#   que o player pegou		#
#   				#
#   label = matriz		#
#   fase = Imediato referente	#
# ao número máximo de pokebola	#
#  por nível (Olhar na memória	#
#    de dados NUM_POKEBOLA)	#
#				#
#   x e y = Coordenadas do baú	#
#      que vai ser printado	#
#				#
#################################

.macro conta_pokebola(%label, %fase, %x,%y)       # X e Y , para printar baú após coleta de todas as pokebolas
la a6, NUM_POKEBOLA
lb a5, %fase(a6)
la s8, %label
add s8, s8, s7
lb t5, 0(s8)
li s6, 20 
beq t5, s6, SOMA
j FIM

SOMA: 
	li a0, 80
	li a3, 127
	li a2, 112
	li a1,300
	li a7, 31
	ecall
	la s9, POKEBOLA
	lb s10, 0(s9)
	addi s10, s10, 1
	sb s10, 0(s9)
	li s11, 23
	sb s11,0(s8)

PRINTAR: 
	li a4,0
	li s4,1
	li a6,2
	li s6,3
	li s7,4
	li s8,5 
	beq s10, a4, PRINT_0
	beq s10, s4, PRINT_1
	beq s10, a6, PRINT_2
	beq s10, s6, PRINT_3
	beq s10, s7, PRINT_4
	beq s10, s8, PRINT_5
	
PRINT_0:
	frame_atual()
	load_values(268,93,ZERO)
	call PRINT_IMAGE
	j ABRIR_BAU
PRINT_1:
	frame_atual()
	load_values(268,93,UM)
	call PRINT_IMAGE
	j ABRIR_BAU
PRINT_2:
	frame_atual()
	load_values(268,93,DOIS)
	call PRINT_IMAGE
	j ABRIR_BAU
PRINT_3:
	frame_atual()
	load_values(268,93,TRES)
	call PRINT_IMAGE
	j ABRIR_BAU
PRINT_4:
	frame_atual()
	load_values(268,93,QUATRO)
	call PRINT_IMAGE
	j ABRIR_BAU
PRINT_5:
	frame_atual()
	load_values(268,93,CINCO)
	call PRINT_IMAGE
	j ABRIR_BAU

ABRIR_BAU:	
	beq s10,a5,PRINTAR_BAU
	j FIM 

PRINTAR_BAU:
	frame_atual()
	load_values(%x,%y,BauAbertoChave)      
	call PRINT_IMAGE
	la t3,PEGOU_POKEBOLA
	lb t6,0(t3)
	addi t6,t6,1 
	sb t6,0(t3)
							
FIM:    
	
.end_macro

.macro reseta_pokebola(%label)
    la a3, %label
    li s4, 121    # Tamanho
    li s5, 0    # Contador
    li s6, 23    # Bloco de Tijolo auxiliar
    li s7, 20    # Valor da Pokebola
LOOP:
    beq s5, s4, FIM
    addi s5, s5, 1
    addi a3, a3, 1
    lb s8, 0(a3)
    beq s8, s6, BOTA_POKEBOLA
    j LOOP
BOTA_POKEBOLA:
    sb s7, 0(a3)
    j LOOP
FIM:
.end_macro

.macro printa_caterpie()
	la s10 , PRINTOU_CATERPIE
	la a4, PEGOU_POKEBOLA
	lb s5, 0(a4)
	bgtz s5, VERIFICAXY
    	j FIM_PC
    	
VERIFICAXY:
	li a6, 88      # coordenada do x da esquerda
	li a3, 216     #coordenada do x da direita
	li a7, 153     #coordenada do y 
	la s6 , POSITION 
	lh s8, 0(s6)        # x do pikachu
	lh s9, 2(s6)        # y do pikachu 
	beq s8, a6 , PASSOU_X_ESQUERDA
	beq s8, a3 , PASSOU_X_DIREITA
	j FIM_PC
PASSOU_X_DIREITA:						 
	beq s9,a7,PASSOU_Y_DIREITA				 
	j FIM_PC						 
PASSOU_Y_DIREITA:						 	
	lb s11, 0(s10)						 
	beqz s11, PRINTA_CATERPIE_DIREITA			 
	j FIM_PC  						 
PRINTA_CATERPIE_DIREITA:					 
	la t5, FASE2						 
	li t4, 22						 
	sb t4, 109(t5)                                           
	frame_atual()                                            
	load_values(232,169,Caterpie)                            
	call PRINT_IMAGE     
	li s4 , 1
	sb s4, 0(s10)                                   
	j FIM_PC						 	
PASSOU_X_ESQUERDA:
 	beq s9,a7, PASSOU_Y_ESQUERDA
 	j FIM_PC
 		 	
PASSOU_Y_ESQUERDA:
	lb s11, 0(s10)
	beqz s11, PRINTA_CATERPIE_ESQUERDA
	j FIM_PC
	
PRINTA_CATERPIE_ESQUERDA:
	la t5, FASE2
	li t4, 22
	sb t4, 100(t5)
	frame_atual()
	load_values(88,169,Caterpie)
	call PRINT_IMAGE
	li s4 , 1
	sb s4, 0(s10)
	j FIM_PC	

FIM_PC:
.end_macro 

.macro perder_vida(%num, %label)
	li a3, %num
	la s4, BLOCO_ATUAL
	lb s5, 0(s4)
	
	beq s5, a3, SPRITE_MORTE
	j FIM 
	
SPRITE_MORTE:
	load_position(POSITION)
	frame_atual()
	clean_image(fase2)
	call CLEAN_IMAGE
	load_position(POSITION)
	mv s2, t1
	mv s1, t2
	la a1, pikachu_morto
	call PRINT_IMAGE
	li a7, 31                # Musiquinha quando morre
	li a0, 61
	li a1, 2000
	li a2, 121
	li a3, 127
	ecall
	li a7, 32
	li a0, 2000
	ecall 
	la t5, FASE2
	li t4, 0
	sb t4, 100(t5)
	sb t4, 109(t5)
        la a5 , VIDAS
        lb a6, 0(a5)		
        addi a6,a6,-1
        sb a6,0(a5)
        
        j %label 

FIM:
.end_macro 
#################################
#				#
#   Macro que vai verificar	#
#   se o player pegou a chave	#
#	    do baú		#
#				#
#   %x e %y - Coordenada pra	#
#   	printar o baú		#
#				#
# %xporta e %yporta -coordenada	#
#	que vai printar a 	#
#	   porta aberta		#
#				#
#################################

.macro pegou_chave(%x,%y,%xporta,%yporta,%porta)       # Coordenadas do baú     
	li a4,21
	la t3,PEGOU_POKEBOLA
	lb t6,0(t3)
	bgtz t6, PROX_PASSO
	j FIM
	
PROX_PASSO:
	beq a4,t5,PRINTA_BAU
	j FIM 
	
PRINTA_BAU:
	frame_atual()
	load_values(%x,%y,BauAberto)          
	call PRINT_IMAGE
	li a7, 31               
	li a0, 61
	li a1, 2000
	li a2, 114
	li a3, 127
	ecall
	frame_atual()
	load_values(%xporta,%yporta,%porta)          
	call PRINT_IMAGE
	la s4, PEGOU_CHAVE
	lb s5, 0(s4)
	addi s5, s5,1
	sb s5,0(s4)

FIM:
.end_macro 

#################################
#				#
#     Macro que vai detectar	#
#   se o player pegou a chave	#
#            do baú,		#
# e quando chegar na coordenada	#
#     x e y, vai para a 	#
#	próxima fase
#				#
#################################

.macro proxima_fase(%x,%y,%label)
	load_position(POSITION)
	li s7, %x
	li s6, %y
	la s4, PEGOU_CHAVE
	lb s5, 0(s4)
	bgtz s5,PASSOU_UM
        j FIM 
        
PASSOU_UM:
	beq s7,t1,PASSOU_DOIS
	j FIM 
PASSOU_DOIS:
	beq s6,t2,PASSOU_TRES
	j FIM 
PASSOU_TRES:
	j %label 
FIM:

.end_macro

#################################
#				#
#   Verifica a última tecla, 	#
#    se for igual, printa	#
#   uma sprite diferente,	#
#     usando um contador	#
#      que diferencia		#
#      (ímpar ou par)		#
#				#
#################################

.macro ultima_tecla(%label)
la a2,CONTADOR
lw t3, 0(a2)	# Carrega o contador
addi t3,t3,1	# Contador+=1
sw t3, 0(a2)	# Atualiza o Contador 
li t4, 2
rem t0,t3,t4
beqz t0, %label
.end_macro

#################################
#				#
#	Carrega a label		#
#     e a frame para usar	#
#      no procedimento		#
#	 PRINT_MAPA		#
#				#
#################################

.macro load_fase(%label)
la a0, %label
.end_macro
