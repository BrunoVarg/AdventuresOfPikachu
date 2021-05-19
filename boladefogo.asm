.data
.text

#################################
#				#
#	Entradas:		#
#	t5 = label da fase	#
#				#
#################################

BOLA_DE_FOGO_PRINT:
	la a6, BOLA_DE_FOGO
	la t4, CONTADOR_FIREBALL # Contador
	lb s9, 0(t4)
	li s6, 10
	lh t6, 0(a6)    # x - bola de fogo 
	lh s4, 2(a6)	# y - bola de fogo
	la s10, POSITION 
	lh s11, 0(s10)    # x pikachu
	lh a3, 2(s10)     # y pikachu
	beq t6, s11, PASSOU_UM_BF
	j ATIRA
	
PASSOU_UM_BF:
	beq a3,s4,MORTE_BF
	j ATIRA
	
MORTE_BF:
	load_position(POSITION)
	frame_atual()
	clean_image(fase3)
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
	j INICIO_FASE3 

ATIRA:
	beq s9, s6, RESETA
	frame_atual()
	la a1, bolafogo
	load_position(BOLA_DE_FOGO)
	mv s2, t1
	mv s1, t2
	call PRINT_IMAGE
	addi s9,s9, 1
	la t4, CONTADOR_FIREBALL
	sb s9, 0(t4)
	la a6, BOLA_DE_FOGO
	lh s3, 0(a6)	# x bola de fogo
	addi s3, s3, 16
	sh s3, 0(a6)	# Armazena o novo X
	li a7, 32
	li a0, 200
	ecall
	load_position(BOLA_DE_FOGO)
	frame_atual()
	mv a1, t5
	call CLEAN_IMAGE
	beq zero, zero, FIM_BF	
	
RESETA:
	la a4, BOLA_DE_FOGO
	li s7, 88
	li s8, 185
	sh s7, 0(a4)
	sh s8, 2(a4)
	la t4, CONTADOR_FIREBALL
	li t3, 0 
	sb t3, 0(t4) 

FIM_BF:	
j FORA_BOLA_DE_FOGO
