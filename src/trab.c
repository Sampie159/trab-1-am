#include <stdio.h>

typedef struct {
	float alta;
	float baixa;
} Valor_Nota;

typedef struct {
	float alto;
	float baixo;
} Esforco;

typedef struct {
	float bom;
	float ruim;
} Estado_Mental;

typedef struct {
	float muito;
	float baixo;
} Nota_Necessaria;

typedef struct {
	Valor_Nota valor_nota;
	Esforco esforco;
	Estado_Mental estado_mental;
	Nota_Necessaria nota_necessaria;
} Conjuntos;

static float u_VN(float x) {
	return x < 1 ? 0 : x / 10;
}

static float u_E(float x) {
	return x > 85 ? 0 : (100 - x) / 100;
}

static float u_EM(float x) {
	return x < 10 ? 0 : x / 100;
}

static float u_NN(float x) {
	if (x < 25) return 0;
	else if (x < 50) return 0.25;
	else if (x < 75) return 0.50;
	else if (x < 85) return 0.75;
	else return 1;
}

int main(void) {
	
}
