package main

import "core:fmt"
import "core:os"
import "core:strconv"

// Problema: Decidir fazer o trabalho que o professor passou.
// Variáveis: Valor da nota; Esforço; Época; Estado Mental; Nível de Preguiça; Nota Necessária.
// Nota Alta/Baixa; Esforço Alto/Baixo; Estado Mental Bom/Ruim; Nota Necessária Muito/Pouco.
// X é a variável!

Conjuntos :: struct {
    valor_nota     : Valor_Nota,
    esforco        : Esforco,
    estado_mental  : Estado_Mental,
    nota_necessaria: Nota_Necessaria,
}

Entradas :: distinct [4]f32

main :: proc() {
    vn, e, em, nn: f32
    conjuntos: Conjuntos
	buffer: [12]u8
    
    fmt.println("Olá, eu sou o Deceditron 3000.")
    fmt.println("Decidirei se você deve ou não fazer o trabalho que seu professor passou")
    fmt.printf("Diga, quanto que vale o trabalho para a sua média [0..10]? ")
	os.read(os.stdin, buffer[:])
    vn, _ = strconv.parse_f32(transmute(string) buffer[:])
	buffer = {}
	
    fmt.printf("E quanto esforço será necessário para fazê-lo [0..100]? ")
	os.read(os.stdin, buffer[:])
	e, _ = strconv.parse_f32(transmute(string) buffer[:])
	buffer = {}
	
    fmt.printf("Como está o seu estado mental nesses últimos dias [-100..100]? ")
	os.read(os.stdin, buffer[:])
    em, _ = strconv.parse_f32(transmute(string) buffer[:])
	buffer = {}
	if em < 0 {
		fmt.println("Coringou")
		fmt.println("Cthulhu Fhtagn")
	}
	
    fmt.printf("Você precisa de muita nota [0..100]? ")
	os.read(os.stdin, buffer[:])
    nn, _ = strconv.parse_f32(transmute(string) buffer[:])
	buffer = {}

    entradas := Entradas{vn, e, em, nn}
    preencher_conjuntos(&conjuntos, &entradas)

    fmt.println("Amigo(a), baseado em tudo que você me disse, acho que você...")
	fazer_escolha(&conjuntos)
}

preencher_conjuntos :: proc(using c: ^Conjuntos, e: ^Entradas) {
    definir_vn(&valor_nota, e.x)
    definir_e(&esforco, e.y)
    definir_em(&estado_mental, e.z)
    definir_nn(&nota_necessaria, e.w)
}

fazer_escolha :: proc(using c: ^Conjuntos) {
	if valor_nota.alta == 1 {
		fmt.println("Deve fazer sem dúvida alguma. Mãos à massa")
		return
	} else if valor_nota.baixa == 1 {
		fmt.println("Vai descansar jovem, aproveita a vida!")
		return
	} else if estado_mental.ruim == 1 {
		fmt.println("Vai descansar jovem, aproveita a vida!")
		return
	} else if nota_necessaria.muito == 1 {
		fmt.println("Deve fazer sem dúvida alguma. Mãos à massa")
		return
	}
	
	fazer := (esforco.baixo) * 0.15 + (estado_mental.bom + nota_necessaria.muito) * 0.5 + (valor_nota.alta) * 0.35

	if fazer == 1 do fmt.println("Deve fazer sem dúvida alguma. Mãos à massa")
	else if fazer > 0.75 do fmt.println("Precisa fazer, boa sorte camarada ;)")
	else if fazer > 0.5 do fmt.println("Seria bom fazer, mas a escolha é sua...")
	else if fazer > 0.25 do fmt.println("Não precisa, mas se quiser...")
	else do fmt.println("Vai descansar jovem, aproveita a vida!")
}

Valor_Nota :: struct {
    alta : f32,
    baixa: f32,
}

Esforco :: struct {
    alto : f32,
    baixo: f32,
}

Estado_Mental :: struct {
    bom : f32,
    ruim: f32,
}

Nota_Necessaria :: struct {
    muito: f32,
    pouco: f32,
}

definir_vn :: proc(using vn: ^Valor_Nota, x: f32) {
    alta  = u_VN(x)
    baixa = 1 - alta
}

definir_e :: proc(using e: ^Esforco, x: f32) {
    alto  = u_E(x)
    baixo = 1 - alto
}

definir_em :: proc(using em: ^Estado_Mental, x: f32) {
    bom  = u_EM(x)
    ruim = 1 - bom
}

definir_nn :: proc(using nn: ^Nota_Necessaria, x: f32) {
    muito = u_NN(x)
    pouco = 1 - muito
}

u_VN :: proc(x: f32) -> f32 {
    return 0 if x < 1 else x / 10
}

u_E :: proc(x: f32) -> f32 {
    return 0 if x > 85 else (100 - x) / 100
}

u_EM :: proc(x: f32) -> f32 {
	return 0 if x < 10 else x / 100
}

u_NN :: proc(x: f32) -> f32 {
    if x < 25 do return 0
    else if x < 50 do return 0.25
    else if x < 75 do return 0.50
    else if x < 85 do return 0.75
    else do return 1
}
