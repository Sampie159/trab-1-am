package main

import "core:fmt"

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

Decisao :: enum {
    Fazer,
    NaoFazer,
}

Entradas :: [4]f16

main :: proc() {
    vn, e, em, nn: f16
    conjuntos: Conjuntos
    
    fmt.println("Olá, eu sou o Deceditron 3000.")
    fmt.println("Decidirei se você deve ou não fazer o trabalho que seu professor passou")
    fmt.printf("Diga, quanto que vale o trabalho para a sua média [0..10]? ")
    vn = 10
    fmt.printf("E quanto esforço será necessário para fazê-lo [0..100]? ")
    e = 0
    fmt.printf("Como está o seu estado mental nesses últimos dias [-100..100]? ")
    em = 100
    fmt.printf("Você precisa de muita nota [0..100]? ")
    nn = 100

    entradas := Entradas{vn, e, em, nn}
    preencher_conjuntos(&conjuntos, &entradas)
    
    decisao := fazer_escolha(&conjuntos)

    fmt.println("Amigo(a), baseado em tudo que você me disse, acho que você...")

    if decisao == .Fazer do fmt.println("Deveria fazer o trabalho. Boa sorte ;)")
    else do fmt.println("Não deveria, vai descansar camarada ;)")
}

preencher_conjuntos :: proc(using c: ^Conjuntos, e: ^Entradas) {
    definir_vn(&valor_nota, e.x)
    definir_e(&esforco, e.y)
    definir_em(&estado_mental, e.z)
    definir_nn(&nota_necessaria, e.w)
}

fazer_escolha :: proc(using c: ^Conjuntos) -> Decisao {
    fazer     := (valor_nota.alta + esforco.baixo + estado_mental.bom + nota_necessaria.muito) / 4
    nao_fazer := 1 - fazer
    
    return .Fazer if fazer > nao_fazer else .NaoFazer
}

Valor_Nota :: struct {
    alta : f16,
    baixa: f16,
}

Esforco :: struct {
    alto : f16,
    baixo: f16,
}

Estado_Mental :: struct {
    bom : f16,
    ruim: f16,
}

Nota_Necessaria :: struct {
    muito: f16,
    pouco: f16,
}

definir_vn :: proc(using vn: ^Valor_Nota, x: f16) {
    alta  = u_VN(x)
    baixa = 1 - alta
}

definir_e :: proc(using e: ^Esforco, x: f16) {
    alto  = u_E(x)
    baixo = 1 - alto
}

definir_em :: proc(using em: ^Estado_Mental, x: f16) {
    bom  = u_EM(x)
    ruim = 1 - bom
}

definir_nn :: proc(using nn: ^Nota_Necessaria, x: f16) {
    muito = u_NN(x)
    pouco = 1 - muito
}

u_VN :: proc(x: f16) -> f16 {
    return 0 if x < 1 else x / 10
}

u_E :: proc(x: f16) -> f16 {
    return 0 if x > 85 else (100 - x) / 100
}

u_EM :: proc(x: f16) -> f16 {
    if x < 0 {
	fmt.println("Coringou")
	fmt.println("Cthulhu Fhtagn")
	return 0
    } else {
	return x / 100
    }
}

u_NN :: proc(x: f16) -> f16 {
    if x < 25 do return 0
    else if x < 50 do return 0.25
    else if x < 75 do return 0.50
    else if x < 85 do return 0.75
    else do return 1
}
