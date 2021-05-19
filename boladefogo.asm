.data
.text

#################################
#				#
#	Entradas:		#
#	t5 = label da fase	#
#				#
#################################

BOLA_DE_FOGO_PRINT:
	la a5, POSITION
	la a6, BOLA_DE_FOGO
	lh s10, 2(a5)	# y pikachu
	li s9, 0 	# Contador
	li s6, 10
	lh s4, 2(a6)	# y - bola de fogo
	bne s4, s10, FIM_BF

ATIRA:
	beq s9, s6, RESETA
	frame_atual()
	la a1, bolafogo
	load_position(BOLA_DE_FOGO)
	mv s2, t1
	mv s1, t2
	call PRINT_IMAGE
	addi s9,s9, 1
	la a6, BOLA_DE_FOGO
	lh s3, 0(a6)	# x bola de fogo
	addi s3, s3, 16
	sh s3, 0(a6)	# Armazena o novo X
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


FIM_BF:	
j FORA_BOLA_DE_FOGO